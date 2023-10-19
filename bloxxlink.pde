void settings() {
    int windowWidth = 1280;
    int windowHeight = 720;
    size(windowWidth, windowHeight);
}

void setup() {
    windowResizable(true);

    background(WHITE);

    // noLoop() must be on the last line of setup()
    noLoop();
}

void draw() {
    int[] margin = {
        60, // inline
        60  // block
    };

    int[] gridDimensions = {
        10, // # of columns
        10  // # of rows
    };

    int[][][] gridContent = {
        {
            {1, 1}, {2, 2} // player 1 at (1, 1) and player 2 at (2, 2)
        },
        {
            {3, 3}, {4, 4} // obstakels at (3, 3) and (4, 4)
        },
        {
            {5, 5}, {6, 6} // player 1 blocks at (5, 5) and (6, 6)
        },
        {
            {7, 7}, {8, 8} // player 2 blocks at (7, 7) and (8, 8)
        }
    };

    drawMainGameScreen(margin, gridDimensions, gridContent);
}

void windowResized() {
    println("resized.");
}
