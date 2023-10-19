int[] getMainGameScreenPosition(
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
        y2,
    };
}

int[] getMainGameScreenSize(int[] margin) {
    int marginX = margin[0];
    int marginY = margin[1];

    int mainGameScreenWidth = width - marginX * 2;
    int mainGameScreenHeight = height - marginY * 2;

    return new int[] {
        mainGameScreenWidth,
        mainGameScreenHeight
    };
}

void drawMainGameScreen(int[] margin, int[] gridDimensions, int[][][] gridContent) {
    int[] mainGameScreenSize = getMainGameScreenSize(margin);
    int cellSize = getGridCellSize(
        mainGameScreenSize,
        gridDimensions
    );
    
    int[] gridSize = getGridSize(cellSize, gridDimensions);

    int scoreCounterTextSize = 30;
    int scoreCounterMarginBottom = 20;
    int scoreCounterHeight = scoreCounterTextSize + scoreCounterMarginBottom;

    int[] position = getMainGameScreenPosition(
        margin,
        gridSize,
        scoreCounterHeight
    );

    drawScoreCounter(
        position,
        scoreCounterTextSize,
        new int[] {1, 2}
    );

    position = getGridPosition(position, scoreCounterHeight);
    drawGrid(position, gridDimensions, gridContent);
}
