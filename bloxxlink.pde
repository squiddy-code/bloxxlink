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

int screenIndex = 0;

int[][] inputsCoordinates = {};

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

int winnerIndex;

void draw() {
    clearScreen();

    switch (screenIndex) {
        case 0:
            resetScores();
            drawHomeScreen();
            break;
        case 1:
            drawMainGameScreen(gridDimensions, gridContent, scores);
            break;
        case 2:
            drawEndScreen(winnerIndex, scores[winnerIndex]);
            break;
        default:
            break;
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

    int newScore = scores[playerIndex] - 1;
    if (newScore <= 0) {
        showHomeScreen();
        redraw();

        return;
    }

    scores[playerIndex] = newScore;
    gridContent = newGridContent;

    Integer _winnerIndex = getWinnerIndex(gridDimensions, gridContent);
    if (_winnerIndex != null) {
        winnerIndex = _winnerIndex;
        showEndScreen();
    }

    redraw();
}

void mouseClicked() {
    if (screenIndex == 1) {
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
            mouseX < inputX1 ||
            mouseY < inputY1 ||
            mouseX > inputX2 ||
            mouseY > inputY2
        ) {
            continue;
        }

        switch (inputsCoordinatesIndex) {
            case 0: // increment player
                gridContentAmounts[1]++;
                break;
            case 1: // decrement player
                gridContentAmounts[1]--;
                break;
            case 2: // increment block
                gridContentAmounts[2]++;
                break;
            case 3: // decrement block
                gridContentAmounts[2]--;
                break;
            case 4: // increment obstacle
                gridContentAmounts[0]++;
                break;
            case 5: // decrement obstacle
                gridContentAmounts[0]--;
                break;
            case 6: // start game
                gridContent = getRandomGridContent(
                    gridDimensions,
                    gridContentAmounts
                );

                showMainGameScreen();
                break;
            case 7: // play again
                resetScores();
                showHomeScreen();

                break;
            default:
                break;
        }

        redraw();
        return;
    }
}
