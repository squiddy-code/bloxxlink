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

    drawMainGameScreen(margin, gridDimensions);
}

void windowResized() {
    println("resized.");
}
