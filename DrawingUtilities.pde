void clearScreen() {
    background(WHITE);
}

void drawRectangle(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int width = x2 - x1;
    int height = y2 - y1;

    rect(x1, y1, width, height);
}
