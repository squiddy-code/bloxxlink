int[] getGridPosition(int[] position, int scoreCounterHeight) {
    int x1 = position[0];
    int y1 = position[1] + scoreCounterHeight;

    int x2 = position[2];
    int y2 = position[3];

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

    int numberOfColumns = gridDimensions[0];
    int numberOfRows = gridDimensions[1];

    int maxCellWidth = availableGridWidth / numberOfColumns;
    int maxCellHeight = availableGridHeight / numberOfRows;

    return min(maxCellWidth, maxCellHeight);
}

int[] getGridSize(int gridCellSize, int[] gridDimensions) {
    int numberOfColumns = gridDimensions[0];
    int numberOfRows = gridDimensions[1];

    int width = gridCellSize * numberOfColumns;
    int height = gridCellSize * numberOfRows;

    return new int[] {
        width,
        height
    };
}

void drawGrid(int[] position, int[] gridDimensions, int[][][] gridContent) {
    fill(WHITE);

    int x1 = position[0];
    int y1 = position[1];
    
    int x2 = position[2];
    int y2 = position[3];

    int availableWidth = x2 - x1;
    int availableHeight = y2 - y1;

    int[] availableGridSize = {availableWidth, availableHeight};
    int cellSize = getGridCellSize(availableGridSize, gridDimensions);

    int numberOfColumns = gridDimensions[0];
    int numberOfRows = gridDimensions[1];

    for (int rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
        for (int columnIndex = 0; columnIndex < numberOfColumns; columnIndex++) {
            int cellX = x1 + columnIndex * cellSize;
            int cellY = y1 + rowIndex * cellSize;
            rect(cellX, cellY, cellSize, cellSize);
        }
    }
}
