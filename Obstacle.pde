void drawObstacle(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    fill(BLACK);
    triangle(x, y + size, x + size / 2, y, x + size, y + size);
}

void drawObstaclesByCoordinates(int[][] coordinates, int size) {
    for (int obstacleIndex = 0; obstacleIndex < coordinates.length; obstacleIndex++) {
        int[] obstacleCoordinates = coordinates[obstacleIndex];
        drawObstacle(obstacleCoordinates, size);
    }
}

void drawObstaclesByPositions(
    int[] gridCoordinates,
    int[][] positions,
    int cellSize,
    int padding
) {
    int[][] obstaclesCoordinates = cellsPositionsToCoordinates(
        gridCoordinates,
        positions,
        cellSize,
        padding
    );

    int obstacleSize = addPaddingToSize(cellSize, padding);
    drawObstaclesByCoordinates(obstaclesCoordinates, obstacleSize);
}
