void drawButton(String _text, int _textSize, int[] textMargin, int[] coordinates) {
    int[] textBoxSize = getTextBoxSize(_text, _textSize);
    int[] size = addMarginToSize(textBoxSize, textMargin);

    coordinates = centerBoth(coordinates, size, getNoMargin());

    drawWhiteRectangle(coordinates);
    drawCenteredBlackText(_text, _textSize, textMargin, coordinates);

    buttonsCoordinates = appendTo2DArray(buttonsCoordinates, coordinates);
}
