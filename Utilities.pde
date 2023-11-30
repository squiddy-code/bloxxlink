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

    return new int[] {
        subtractMarginFromLength(width, marginX),
        subtractMarginFromLength(height, marginY)
    };
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
