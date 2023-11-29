void settings() {
    int windowWidth = 1280;
    int windowHeight = 720;
    size(windowWidth, windowHeight);
}

void setup() {
    windowResizable(true);

    // noLoop() must be the last line of setup()
    noLoop();
}

void windowResized() {
    println("windowResized");
}

int[] gridDimensions = {
    10, // # of columns
    10  // # of rows
};

int[] gridContentAmounts = {
    4, // # of obstacles
    2, // # of players
    8  // # of blocks per player
};

int[][][] gridContent;

int[] scores = {
    100, // player 1
    100  // player 2
};

boolean playingGame = false;

void draw() {
    clearScreen();

    if (playingGame) {
        drawMainGameScreen(gridDimensions, gridContent, scores);
    } else {
        drawHomeScreen();
    }
}

void keyPressed() {
    Integer playerIndex = getPlayerIndexByKeyCode(keyCode);
    if (playerIndex == null) {
        return;
    }

    int[] playerPosition = getPlayerPosition(playerIndex, gridContent);
    int[] newPlayerPosition = getNewPlayerPosition(keyCode, playerPosition);

    int[][][] newGridContent = tryToMovePlayer(
        playerPosition,
        newPlayerPosition,
        gridDimensions,
        gridContent
    );

    if (equalGridContents(gridContent, newGridContent)) {
        return;
    }

    scores[playerIndex] -= 1;
    gridContent = newGridContent;

    Integer winnerIndex = getWinnerIndex(gridDimensions, gridContent);

    redraw();
}

void mouseClicked() {
    if (playingGame) {
        return;
    }

    for (
        int inputsCoordinatesIndex = 0;
        inputsCoordinatesIndex < inputsCoordinates.length;
        inputsCoordinatesIndex++
    ) {
        int[] inputCoordinates = inputsCoordinates[inputsCoordinatesIndex];

        int inputX1 = inputCoordinates[0];
        int inputY1 = inputCoordinates[1];

        int inputX2 = inputCoordinates[2];
        int inputY2 = inputCoordinates[3];

        if (
            mouseX > inputX1 &&
            mouseY > inputY1 &&
            mouseX < inputX2 &&
            mouseY < inputY2
        ) {
            switch (inputsCoordinatesIndex) {
                case 0: // player
                    gridContentAmounts[1]++;
                    break;
                case 1: // player
                    gridContentAmounts[1]--;
                    break;
                case 2: // block
                    gridContentAmounts[2]++;
                    break;
                case 3: // block
                    gridContentAmounts[2]--;
                    break;
                case 4: // obstacle
                    gridContentAmounts[0]++;
                    break;
                case 5: // obstacle
                    gridContentAmounts[0]--;
                    break;
                case 6:
                    gridContent = getRandomGridContent(
                        gridDimensions,
                        gridContentAmounts
                    );

                    playingGame = true;
                    break;
                default:
                    break;
            }

            redraw();
            return;
        }
    }
}
