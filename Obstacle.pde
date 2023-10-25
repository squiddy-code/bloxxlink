void drawObstacle(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    fill(BLACK);
    triangle(x, y + size, x + size / 2, y, x + size, y + size);
}

void drawObstaclesByCoordinates(int[][] coordinates, int size) {
    for (
        int obstacleIndex = 0;
        obstacleIndex < coordinates.length;
        obstacleIndex++
    ) {
        int[] obstacleCoordinates = coordinates[obstacleIndex];
        drawObstacle(obstacleCoordinates, size);
    }
}

void drawObstaclesByPositions(
    int[][] positions,
    int[] gridCoordinates,
    int cellSize
) {
    int margin = 0;
    int[][] obstaclesCoordinates = cellsPositionsToCoordinates(
        positions,
        gridCoordinates,
        cellSize,
        margin
    );

    drawObstaclesByCoordinates(obstaclesCoordinates, cellSize);
}
