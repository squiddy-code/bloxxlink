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
    int[] gridCoordinates,
    int[] cellPosition,
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
    int[] gridCoordinates,
    int[][] cellsPositions,
    int cellSize,
    int margin
) {
    int[][] cellsCoordinates = {};

    for (int cellIndex = 0; cellIndex < cellsPositions.length; cellIndex++) {
        int[] cellPosition = cellsPositions[cellIndex];
        int[] cellCoordinates = cellPositionToCoordinates(
            gridCoordinates,
            cellPosition,
            cellSize,
            margin
        );
        
        // type cast is necessary so it doesn't get converted to Object
        cellsCoordinates = (int[][]) append(cellsCoordinates, cellCoordinates);
    }

    return cellsCoordinates;
}

void drawGrid(int[] coordinates, int[] gridDimensions, int[][][] gridContent) {
    fill(WHITE);

    int[] availableGridSize = getAvailableSize(coordinates);
    int cellSize = getGridCellSize(availableGridSize, gridDimensions);

    drawEmptyGrid(coordinates, gridDimensions, cellSize);

    int[][] playersPositions = gridContent[0];
    drawPlayersByPositions(
        coordinates,
        playersPositions,
        cellSize
    );

    int[][] obstaclesPositions = gridContent[1];
    drawObstaclesByPositions(
        coordinates,
        obstaclesPositions,
        cellSize
    );
}
