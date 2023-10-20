int[] getGridCoordinates(int[] coordinates, int scoreCounterHeight) {
    int x1 = coordinates[0];
    int y1 = coordinates[1] + scoreCounterHeight;

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    return new int[] {
        x1,
        y1,
        x2,
        y2
    };
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

    return new int[] {
        width,
        height
    };
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
    int cellSize
) {
    int gridX = gridCoordinates[0];
    int gridY = gridCoordinates[1];

    int column = cellPosition[0];
    int row = cellPosition[1];

    int x = gridX + column * cellSize;
    int y = gridY + row * cellSize;

    return new int[] {
        x,
        y
    };
}

int[][] cellPositionsToCoordinates(
    int[] gridCoordinates,
    int[][] cellPositions,
    int cellSize
) {
    int[][] cellsCoordinates = {};

    for (int cellIndex = 0; cellIndex < cellPositions.length; cellIndex++) {
        int[] cellPosition = cellPositions[cellIndex];
        int[] cellCoordinates = cellPositionToCoordinates(
            gridCoordinates,
            cellPosition,
            cellSize
        );
        
        // type cast is necessary so it doesn't get converted to Object
        cellsCoordinates = (int[][]) append(cellsCoordinates, cellCoordinates);
    }

    return cellsCoordinates;
}

void drawGrid(int[] coordinates, int[] gridDimensions, int[][][] gridContent) {
    fill(WHITE);

    int x1 = coordinates[0];
    int y1 = coordinates[1];
    
    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int availableWidth = x2 - x1;
    int availableHeight = y2 - y1;

    int[] availableGridSize = {availableWidth, availableHeight};
    int cellSize = getGridCellSize(availableGridSize, gridDimensions);

    drawEmptyGrid(coordinates, gridDimensions, cellSize);

    int[][] playersPositions = gridContent[0];
    int[][] playersCoordinates = cellPositionsToCoordinates(
        coordinates,
        playersPositions,
        cellSize
    );

    drawPlayers(playersCoordinates, cellSize);
}
