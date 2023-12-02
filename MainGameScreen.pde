int[] getMainGameScreenSize(int[] gridSize, int scoreCounterHeight) {
    int gridWidth = gridSize[0];
    int gridHeight = gridSize[1];

    int width = gridWidth;
    int height = scoreCounterHeight + gridHeight;

    return new int[] {width, height};
}

int[] getMainGameScreenCoordinates(
    int[] margin,
    int[] gridSize,
    int scoreCounterHeight
) {
    int[] size = getMainGameScreenSize(gridSize, scoreCounterHeight);
    return centerInFullScreen(size, margin);
}

void drawMainGameScreen(
    int[] gridDimensions,
    int[][][] gridContent,
    int[] scores
) {
    int marginX = 60;
    int marginY = 60;

    int[] margin = {
        marginX,
        marginY
    };

    int[] fullGameScreenSize = {width, height};

    int[] availableSize = subtractMarginFromSize(fullGameScreenSize, margin);

    int scoreCounterTextSize = 30;
    int scoreCounterMarginBottom = 20;
    int scoreCounterHeight = scoreCounterTextSize + scoreCounterMarginBottom;

    int[] availableGridSize =
        getAvailableGridSize(availableSize, scoreCounterHeight);
    int cellSize = getGridCellSize(
        availableGridSize,
        gridDimensions
    );

    int[] gridSize = getGridSize(cellSize, gridDimensions);

    int[] coordinates = getMainGameScreenCoordinates(
        margin,
        gridSize,
        scoreCounterHeight
    );

    drawScoreCounter(
        coordinates,
        scoreCounterTextSize,
        scores
    );

    coordinates = getGridCoordinates(coordinates, scoreCounterHeight);
    drawGrid(coordinates, gridDimensions, cellSize, gridContent);
}
