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
