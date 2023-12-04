boolean isOnMainGameScreen() {
    return screenIndex == 1;
}

void showMainGameScreen() {
    screenIndex = 1;
}

int[] getMainGameScreenSize(int[] gridSize, int scoreCounterHeight) {
    int gridWidth = gridSize[0];
    int gridHeight = gridSize[1];

    int width = gridWidth;
    int height = scoreCounterHeight + gridHeight;

    return new int[] {width, height};
}

void drawMainGameScreen(
    int[] gridDimensions,
    int[][][] gridContent,
    int[] scores
) {
    int marginX = 60;
    int marginY = 60;

    int[] margin = {marginX, marginY};
    int[] fullGameScreenSize = {width, height};

    int[] availableSize = subtractMarginFromSize(fullGameScreenSize, margin);

    int scoreCounterTextSize = 30;
    int scoreCounterHeight = getScoreCounterHeight(scoreCounterTextSize);

    int[] availableGridSize = getAvailableGridSize(
        availableSize,
        scoreCounterHeight
    );
    int cellSize = getGridCellSize(
        availableGridSize,
        gridDimensions
    );
    int[] gridSize = getGridSize(cellSize, gridDimensions);

    int[] size = getMainGameScreenSize(gridSize, scoreCounterHeight);
    int[] coordinates = centerInFullScreen(size, margin);

    drawScoreCounter(
        coordinates,
        scoreCounterTextSize,
        scores
    );

    coordinates = getGridCoordinates(coordinates, scoreCounterHeight);
    drawGrid(coordinates, gridDimensions, cellSize, gridContent);
}
