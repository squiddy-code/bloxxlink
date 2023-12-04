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

void drawWhiteRectangle(int[] coordinates) {
    fill(WHITE);
    drawRectangle(coordinates);
}

int[] drawCenteredText(String _text, int _textSize, int[] coordinates) {
    textSize(_textSize);

    int width = round(textWidth(_text));
    int height = _textSize;

    int[] size = {width, height};

    int[] textCoordinates = centerBoth(coordinates, size, getNoMargin());

    int textX = textCoordinates[0];
    int textY = textCoordinates[1];

    fill(BLACK);
    text(_text, textX, textY);

    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    return new int[] {x1, y1 + _textSize, x2, y2};
}
