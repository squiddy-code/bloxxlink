int[] getMainGameScreenPosition(
    int[] margin,
    int[] gridSize,
    int scoreCounterHeight
) {
    int marginInline = margin[0];
    int marginBlock = margin[1];

    int gridWidth = gridSize[0];
    int gridHeight = gridSize[1];

    int leftoverInlineSpace = width - marginInline - gridWidth - marginInline;
    int marginInlineToCenter = leftoverInlineSpace / 2;

    int leftoverBlockSpace = 
        height 
        - marginBlock 
        - scoreCounterHeight 
        - gridHeight 
        - marginBlock;
    int marginBlockToCenter = leftoverBlockSpace / 2;

    int x1 = marginInline + marginInlineToCenter;
    int y1 = marginBlock + marginBlockToCenter;

    int x2 = width - marginInline - marginInlineToCenter;
    int y2 = height - marginBlock - marginBlockToCenter;

    return new int[] {
        x1,
        y1,
        x2,
        y2,
    };
}

int[] getMainGameScreenSize(int[] margin) {
    int marginInline = margin[0];
    int marginBlock = margin[1];

    int mainGameScreenWidth = width - marginInline * 2;
    int mainGameScreenHeight = height - marginBlock * 2;

    return new int[] {
        mainGameScreenWidth,
        mainGameScreenHeight
    };
}

void drawMainGameScreen(int[] margin, int[] gridDimensions) {
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
    drawGrid(position, gridDimensions);
}
