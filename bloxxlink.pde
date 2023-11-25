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

int[][][] gridContent = getRandomGridContent(
    gridDimensions,
    gridContentAmounts
);

int[] scores = {
    100, // player 1
    100  // player 2
};

void draw() {
    clearScreen();
    drawMainGameScreen(gridDimensions, gridContent, scores);
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
    redraw();
}
