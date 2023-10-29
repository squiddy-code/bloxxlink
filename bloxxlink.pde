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

// int[] gridContentAmounts = {
//     3, // # of obstacles
//     2, // # of players
//     4  // # of blocks per player
// };

int[] gridContentAmounts = {
    0, // # of obstacles
    2, // # of players
    8  // # of blocks per player
};

int[][][] gridContent = getRandomGridContent(
    gridDimensions,
    gridContentAmounts
);

void draw() {
    // int[][][] soep = {{{0, 1}}};
    // soep = appendTo3DimensionalArray(soep, new int[][] {{2, 3}});

    // int[][] positionsBetweenPositions = getPositionsBetweenPositions(new int[] {0, 0}, new int[] {3, 0}, 0);
    // for (int i = 0; i < positionsBetweenPositions.length; i++) {
    //     println(positionsBetweenPositions[i]);
    // }

    clearScreen();
    drawMainGameScreen(gridDimensions, gridContent);
}

void keyPressed() {
    Integer playerNumber = getPlayerNumberByKeyCode(keyCode);
    if (playerNumber == null) {
        return;
    }

    int[] playerPosition = getPlayerPosition(playerNumber, gridContent);
    int[] newPlayerPosition = getNewPlayerPosition(keyCode, playerPosition);

    gridContent = tryToMovePlayer(
        playerPosition,
        newPlayerPosition,
        gridDimensions,
        gridContent
    );

    redraw();
}
