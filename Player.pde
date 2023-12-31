void drawPlayerHead(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    noFill();
    ellipseMode(CORNER);
    circle(x, y, size);
}

void drawPlayerEyes(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    int eyeMarginX = round(size * 0.3);

    int eyeRadius = round(size * 0.08);

    int leftEyeX = x + eyeMarginX;
    int rightEyeX = x + size - eyeMarginX - eyeRadius;

    int eyeY = y + round(size * 0.3);

    fill(BLACK);

    circle(leftEyeX, eyeY, eyeRadius);
    circle(rightEyeX, eyeY, eyeRadius);
}

void drawPlayerMouth(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    int mouthX = x + size / 2;
    int mouthY = y + round(size * 0.45);

    int mouthSize = round(size * 0.6);

    noFill();
    ellipseMode(CENTER);
    arc(mouthX, mouthY, mouthSize, mouthSize, QUARTER_PI, HALF_PI + QUARTER_PI);
}

void drawPlayer(int[] coordinates, int size) {
    int strokeWeight = round(size * 0.02);
    strokeWeight(strokeWeight);

    drawPlayerHead(coordinates, size);
    drawPlayerEyes(coordinates, size);
    drawPlayerMouth(coordinates, size);

    strokeWeight(1);
}

void drawPlayersByCoordinates(int[][] coordinates, int size) {
    for (int playerIndex = 0; playerIndex < coordinates.length; playerIndex++) {
        int[] playerCoordinates = coordinates[playerIndex];
        drawPlayer(playerCoordinates, size);
    }
}

void drawPlayersByPositions(
    int[][] positions,
    int[] gridCoordinates,
    int cellSize
) {
    int margin = 5;
    int[][] playersCoordinates = cellsPositionsToCoordinates(
        positions,
        gridCoordinates,
        cellSize,
        margin
    );

    int playerSize = subtractMarginFromLength(cellSize, margin);
    drawPlayersByCoordinates(playersCoordinates, playerSize);
}
