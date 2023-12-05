void drawButton(String _text, int _textSize, int[] textMargin, int[] coordinates) {
    textSize(_textSize);

    int textBoxWidth = round(textWidth(_text));
    int textBoxHeight = _textSize;

    int[] textBoxSize = {textBoxWidth, textBoxHeight};
    int[] size = addMarginToSize(textBoxSize, textMargin);

    coordinates = centerBoth(coordinates, size, getNoMargin());

    drawWhiteRectangle(coordinates);

    int[] textCoordinates = centerBoth(coordinates, textBoxSize, textMargin);

    int x = textCoordinates[0];
    int y = textCoordinates[1];

    fill(BLACK);
    text(_text, x, y + _textSize);

    buttonsCoordinates = appendTo2DArray(buttonsCoordinates, coordinates);
}
