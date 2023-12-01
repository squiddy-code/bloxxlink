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
        gridWidth,                      // width
        scoreCounterHeight + gridHeight // height
    };

    int[] availableSize = {
        width,
        height
    };

    int[] marginToCenter = addMarginToCenterBoth(size, availableSize, margin);

    int marginToCenterX = marginToCenter[0];
    int marginToCenterY = marginToCenter[1];

    int x1 = marginToCenterX;
    int y1 = marginToCenterY;

    int x2 = width - marginToCenterX;
    int y2 = height - marginToCenterY;

    return new int[] {x1, y1, x2, y2};
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
