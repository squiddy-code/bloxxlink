// TODO copy version with margin built in
int[] getMainGameScreenCoordinates(
    int[] margin,
    int[] gridSize,
    int scoreCounterHeight
) {
    int marginX = margin[0];
    int marginY = margin[1];

    int gridWidth = gridSize[0];
    int gridHeight = gridSize[1];

    int[] size = {
        marginX + gridWidth + marginX,                      // width
        marginY + scoreCounterHeight + gridHeight + marginY // height
    };

    int[] availableSize = {
        width,
        height
    };

    int[] marginToCenter = getMarginToCenterBoth(size, availableSize);

    int marginXToCenter = marginToCenter[0];
    int marginYToCenter = marginToCenter[1];

    int x1 = marginX + marginXToCenter;
    int y1 = marginY + marginYToCenter;

    int x2 = width - marginX - marginXToCenter;
    int y2 = height - marginY - marginYToCenter;

    return new int[] {x1, y1, x2, y2};
}

void drawMainGameScreen(
    int[] gridDimensions,
    int[][][] gridContent,
    int[] scores
) {
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
        scores
    );

    coordinates = getGridCoordinates(coordinates, scoreCounterHeight);
    drawGrid(coordinates, gridDimensions, cellSize, gridContent);
}
