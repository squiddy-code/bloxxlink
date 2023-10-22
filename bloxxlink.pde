void settings() {
    int windowWidth = 1280;
    int windowHeight = 720;
    size(windowWidth, windowHeight);
}

void setup() {
    windowResizable(true);

    background(WHITE);

    // noLoop() must be the last line of setup()
    noLoop();
}

void draw() {
    int[] gridDimensions = {
        10, // # of columns
        10  // # of rows
    };

    int[] gridItemAmounts = {
        2, // # of players
        3, // # of obstacles
        4  // # of blocks per player
    };
    
    int[][][] gridContent = getRandomGridContent(
        gridDimensions,
        gridItemAmounts
    );

    drawMainGameScreen(gridDimensions, gridContent);
}

void windowResized() {
    println("resized.");
}
