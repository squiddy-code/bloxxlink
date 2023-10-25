int[] getGridCoordinates(int[] previousCoordinates, int scoreCounterHeight) {
    int x1 = previousCoordinates[0];
    int y1 = previousCoordinates[1] + scoreCounterHeight;

    int x2 = previousCoordinates[2];
    int y2 = previousCoordinates[3];

    return new int[] {x1, y1, x2, y2};
}

int[] getAvailableGridSize(int[] mainGameScreenSize, int scoreCounterHeight) {
    int mainGameScreenWidth = mainGameScreenSize[0];
    int mainGameScreenHeight = mainGameScreenSize[1];

    int availableGridWidth = mainGameScreenWidth;
    int availableGridHeight = mainGameScreenHeight - scoreCounterHeight;

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
        
        cellsCoordinates = (int[][]) append(cellsCoordinates, cellCoordinates);
    }

    return cellsCoordinates;
}

void drawGrid(int[] coordinates, int[] gridDimensions, int[][][] gridContent) {
    fill(WHITE);

    int[] availableGridSize = getSizeFromCoordinates(coordinates);
    int cellSize = getGridCellSize(availableGridSize, gridDimensions);

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

    // TODO combine these 2 into a single function

    int[][] player1BlocksPositions = gridContent[3];
    int player1Color = RED;
    drawBlocksByPositions(
        player1BlocksPositions,
        coordinates,
        cellSize,
        player1Color
    );

    int[][] player2BlocksPositions = gridContent[4];
    int player2Color = BLUE;
    drawBlocksByPositions(
        player2BlocksPositions,
        coordinates,
        cellSize,
        player2Color
    );
}
