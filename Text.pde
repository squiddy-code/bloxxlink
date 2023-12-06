int[] getTextBoxSize(String _text, int _textSize) {
    textSize(_textSize);

    int width = round(textWidth(_text));
    int height = _textSize;

    return new int[] {width, height};
}

void drawBlackText(String _text, int _textSize, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    fill(BLACK);
    textSize(_textSize);
    text(_text, x, y + _textSize);
}

int[] drawCenteredBlackText(
    String _text,
    int _textSize,
    int[] textMargin,
    int[] coordinates
) {
    int[] textBoxSize = getTextBoxSize(_text, _textSize);
    int[] textCoordinates = centerBoth(
        coordinates,
        textBoxSize,
        textMargin
    );

    drawBlackText(_text, _textSize, textCoordinates);

    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    return new int[] {x1, y1 + _textSize, x2, y2};
}
