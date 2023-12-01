void clearScreen() {
    background(WHITE);
}

int subtractMarginFromLength(int length, int margin) {
    return length - 2 * margin;
}

int[] subtractMarginFromSize(int[] size, int[] margin) {
    int width = size[0];
    int height = size[1];

    int marginX = margin[0];
    int marginY = margin[1];

    width = subtractMarginFromLength(width, marginX);
    height = subtractMarginFromLength(height, marginY);

    return new int[] {width, height};
}

int getMarginToCenter(int length, int availableLength) {
    return (availableLength - length) / 2;
}

int[] getMarginToCenterBoth(int[] size, int[] availableSize) {
    int _width = size[0];
    int _height = size[1];

    int availableWidth = availableSize[0];
    int availableHeight = availableSize[1];

    int marginToCenterX = getMarginToCenter(_width, availableWidth);
    int marginToCenterY = getMarginToCenter(_height, availableHeight);

    return new int[] {marginToCenterX, marginToCenterY};
}

int[] addMarginToCenterBoth(int[] size, int[] availableSize, int[] margin) {
    int _width = size[0];
    int _height = size[1];

    int marginX = margin[0];
    int marginY = margin[1];

    int widthWithMargin = _width + marginX * 2;
    int heightWithMargin = _height + marginY * 2;

    int[] sizeWithMargin = {widthWithMargin, heightWithMargin};

    int[] marginToCenterBoth =
        getMarginToCenterBoth(sizeWithMargin, availableSize);

    int marginToCenterX = marginToCenterBoth[0];
    int marginToCenterY = marginToCenterBoth[1];

    marginX += marginToCenterX;
    marginY += marginToCenterY;

    margin = new int[] {
        marginX,
        marginY
    };

    return margin;
}
