int[] getMainGameScreenCoordinates(
    int[] margin,
    int[] gridSize,
    int scoreCounterHeight
) {
    int marginX = margin[0];
    int marginY = margin[1];

    int gridWidth = gridSize[0];
    int gridHeight = gridSize[1];

    int leftoverHorizontalSpace = width - marginX - gridWidth - marginX;
    int marginXToCenter = leftoverHorizontalSpace / 2;

    int leftoverVerticalSpace = 
        height 
        - marginY 
        - scoreCounterHeight 
        - gridHeight 
        - marginY;
    int marginYToCenter = leftoverVerticalSpace / 2;

    int x1 = marginX + marginXToCenter;
    int y1 = marginY + marginYToCenter;

    int x2 = width - marginX - marginXToCenter;
    int y2 = height - marginY - marginYToCenter;

    return new int[] {
        x1,
        y1,
        x2,
        y2
    };
}

void drawMainGameScreen(int[] gridDimensions, int[][][] gridContent) {
    int[] size = {width, height};
    int[] margin = {
        60, // x
        60  // y
    };

    size = subtractMarginFromSize(size, margin);

    int scoreCounterTextSize = 30;
    int scoreCounterMarginBottom = 20;
    int scoreCounterHeight = scoreCounterTextSize + scoreCounterMarginBottom;

    int[] availableGridSize = getAvailableGridSize(size, scoreCounterHeight);
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
        new int[] {1, 2}
    );

    coordinates = getGridCoordinates(coordinates, scoreCounterHeight);
    drawGrid(coordinates, gridDimensions, gridContent);
}
