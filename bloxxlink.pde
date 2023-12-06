void settings() {
    int windowWidth = 1280;
    int windowHeight = 720;
    size(windowWidth, windowHeight);
}

void setup() {
    // noLoop() must be the last line of setup()
    noLoop();
}

int screenIndex = 0;

int[] gridDimensions = {
    10, // # of columns
    10  // # of rows
};

int[][][] gridContent;

Integer winnerIndex;

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
    int playerAmount = gridContentAmounts[1];

    if (playerIndex == null || playerIndex >= playerAmount) {
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

    gridContent = newGridContent;

    Integer _winnerIndex = getWinnerIndex(gridDimensions, gridContent);
    if (_winnerIndex != null) {
        winnerIndex = _winnerIndex;
        showEndScreen();
    }

    int newScore = scores[playerIndex] - 1;
    if (newScore <= 0) {
        showHomeScreen();
    }

    scores[playerIndex] = newScore;

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
                gridContent = startGame();
            }
        }

        if (screenIndex == 2 && buttonsCoordinatesIndex == 7) {
            winnerIndex = null;
            showHomeScreen();
        }

        redraw();
        return;
    }
}
