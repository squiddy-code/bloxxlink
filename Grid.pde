int[] getAvailableGridSize(
    int[] availableMainGameScreenSize,
    int scoreCounterHeight
) {
    int availableMainGameScreenWidth = availableMainGameScreenSize[0];
    int availableMainGameScreenHeight = availableMainGameScreenSize[1];

    int availableGridWidth = availableMainGameScreenWidth;
    int availableGridHeight = 
        availableMainGameScreenHeight - scoreCounterHeight;

    return new int[] {availableGridWidth, availableGridHeight};
}

int getGridCellSize(int[] availableGridSize, int[] gridDimensions) {
    int availableGridWidth = availableGridSize[0];
    int availableGridHeight = availableGridSize[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int maxCellWidth = availableGridWidth / columnAmount;
    int maxCellHeight = availableGridHeight / rowAmount;

    return min(maxCellWidth, maxCellHeight);
}

int[] getGridSize(int gridCellSize, int[] gridDimensions) {
    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int width = gridCellSize * columnAmount;
    int height = gridCellSize * rowAmount;

    return new int[] {width, height};
}

int[] getGridCoordinates(int[] previousCoordinates, int scoreCounterHeight) {
    int x1 = previousCoordinates[0];
    int y1 = previousCoordinates[1] + scoreCounterHeight;

    int x2 = previousCoordinates[2];
    int y2 = previousCoordinates[3];

    return new int[] {x1, y1, x2, y2};
}

void drawEmptyGrid(int[] coordinates, int[] gridDimensions, int cellSize) {
    int x = coordinates[0];
    int y = coordinates[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    for (int rowIndex = 0; rowIndex < rowAmount; rowIndex++) {
        for (int columnIndex = 0; columnIndex < columnAmount; columnIndex++) {
            int cellX = x + columnIndex * cellSize;
            int cellY = y + rowIndex * cellSize;
            rect(cellX, cellY, cellSize, cellSize);
        }
    }
}

int[] cellPositionToCoordinates(
    int[] cellPosition,
    int[] gridCoordinates,
    int cellSize,
    int margin
) {
    int gridX = gridCoordinates[0];
    int gridY = gridCoordinates[1];

    int column = cellPosition[0];
    int row = cellPosition[1];

    int x = gridX + column * cellSize + margin;
    int y = gridY + row * cellSize + margin;

    return new int[] {x, y};
}

int[][] cellsPositionsToCoordinates(
    int[][] cellsPositions,
    int[] gridCoordinates,
    int cellSize,
    int margin
) {
    int[][] cellsCoordinates = {};

    for (int cellIndex = 0; cellIndex < cellsPositions.length; cellIndex++) {
        int[] cellPosition = cellsPositions[cellIndex];
        int[] cellCoordinates = cellPositionToCoordinates(
            cellPosition,
            gridCoordinates,
            cellSize,
            margin
        );
        
        cellsCoordinates = appendTo2DArray(cellsCoordinates, cellCoordinates);
    }

    return cellsCoordinates;
}

void drawGrid(
    int[] coordinates,
    int[] gridDimensions,
    int cellSize,
    int[][][] gridContent
) {
    fill(WHITE);

    drawEmptyGrid(coordinates, gridDimensions, cellSize);

    int[][] obstaclesPositions = gridContent[0];
    drawObstaclesByPositions(
        obstaclesPositions,
        coordinates,
        cellSize
    );

    int[][] playersPositions = gridContent[2];
    drawPlayersByPositions(
        playersPositions,
        coordinates,
        cellSize
    );

    // TODO create custom array method for this
    int[][][] blocksPositions = (int[][][]) subset(gridContent, 3);
    int[] colors = {
        RED, // player 1 color
        BLUE // player 2 color
    };

    drawAllBlocks(
        blocksPositions,
        coordinates,
        cellSize,
        colors
    );
}
