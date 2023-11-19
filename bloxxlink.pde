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
    0, // # of obstacles
    2, // # of players
    8  // # of blocks per player
};

int[][][] gridContent = getRandomGridContent(
    gridDimensions,
    gridContentAmounts
);

void draw() {
    clearScreen();
    drawMainGameScreen(gridDimensions, gridContent);
}

void keyPressed() {
    Integer playerIndex = getPlayerIndexByKeyCode(keyCode);
    if (playerIndex == null) {
        return;
    }

    int[] playerPosition = getPlayerPosition(playerIndex, gridContent);
    int[] newPlayerPosition = getNewPlayerPosition(keyCode, playerPosition);

    if (
        !rowCanBePushed(
            playerPosition,
            newPlayerPosition,
            gridDimensions,
            gridContent
        )
    ) {
        println("player cannot be moved (row cannot be pushed)");
        println(newPlayerPosition);

        return;
    }

    gridContent = movePlayer(playerPosition, newPlayerPosition, gridContent);

    redraw();
}
