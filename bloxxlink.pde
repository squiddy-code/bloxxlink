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

int[][] buttonsCoordinates = {};

int[] gridDimensions = {
    10, // # of columns
    10  // # of rows
};

int[][][] gridContent;

int winnerIndex;

void draw() {
    clearScreen();
    drawCurrentScreen(
        screenIndex,
        gridDimensions,
        gridContent,
        scores,
        winnerIndex
    );
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
    // The main game screen doesn't have any buttons,
    // so we can skip if it's on that screen.
    if (isOnMainGameScreen()) {
        return;
    }

    for (
        int buttonsCoordinatesIndex = 0;
        buttonsCoordinatesIndex < buttonsCoordinates.length;
        buttonsCoordinatesIndex++
    ) {
        int[] buttonCoordinates = buttonsCoordinates[buttonsCoordinatesIndex];

        int buttonX1 = buttonCoordinates[0];
        int buttonY1 = buttonCoordinates[1];

        int buttonX2 = buttonCoordinates[2];
        int buttonY2 = buttonCoordinates[3];

        if (
            mouseX < buttonX1 ||
            mouseY < buttonY1 ||
            mouseX > buttonX2 ||
            mouseY > buttonY2
        ) {
            continue;
        }

        if (screenIndex == 0) {
            if (buttonsCoordinatesIndex < 6) { // grid content amount button
                onGridContentAmountButtonPressed(buttonsCoordinatesIndex);
            } else if (buttonsCoordinatesIndex == 6) { // start game button
                startGame();
            }
        }

        if (screenIndex == 2 && buttonsCoordinatesIndex == 7) {
            endGame();
        }

        redraw();
        return;
    }
}
