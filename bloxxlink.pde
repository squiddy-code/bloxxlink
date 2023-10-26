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

    int[] gridContentAmounts = {
        3, // # of obstacles
        2, // # of players
        4  // # of blocks per player
    };
    
    int[][][] gridContent = getRandomGridContent(
        gridDimensions,
        gridContentAmounts
    );

    drawMainGameScreen(gridDimensions, gridContent);
}

void windowResized() {
    println("resized.");
}
