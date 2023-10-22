void drawBlock(int[] coordinates, int size, int _color) {
    int x = coordinates[0];
    int y = coordinates[1];

    fill(_color);
    rect(x, y, size, size);
}

void drawBlocksByCoordinates(int[][] coordinates, int size, int _color) {
    for (int blockIndex = 0; blockIndex < coordinates.length; blockIndex++) {
        int[] blockCoordinates = coordinates[blockIndex];
        drawBlock(blockCoordinates, size, _color);
    }
}

void drawBlocksByPositions(
    int[] gridCoordinates,
    int[][] positions,
    int cellSize,
    int _color
) {
    int margin = 0;
    int[][] blocksCoordinates = cellsPositionsToCoordinates(
        gridCoordinates,
        positions,
        cellSize,
        margin
    );

    drawBlocksByCoordinates(blocksCoordinates, cellSize, _color);
}
