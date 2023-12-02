int[] negateMargin(int[] margin) {
    int marginX = margin[0];
    int marginY = margin[1];

    return new int[] {-marginX, -marginY};
}

int addMarginToLength(int length, int margin) {
    return length + 2 * margin;
}

int[] addMarginToSize(int[] size, int[] margin) {
    int width = size[0];
    int height = size[1];

    int marginX = margin[0];
    int marginY = margin[1];

    width = addMarginToLength(width, marginX);
    height = addMarginToLength(height, marginY);

    return new int[] {width, height};
}

int subtractMarginFromLength(int length, int margin) {
    return addMarginToLength(length, -margin);
}

int[] subtractMarginFromSize(int[] size, int[] margin) {
    int[] negatedMargin = negateMargin(margin);
    return addMarginToSize(size, negatedMargin);
}

int getMarginToCenter(int length, int availableLength) {
    return (availableLength - length) / 2;
}

int[] getMarginToCenterBoth(int[] size, int[] availableSize) {
    int width = size[0];
    int height = size[1];

    int availableWidth = availableSize[0];
    int availableHeight = availableSize[1];

    int marginToCenterX = getMarginToCenter(width, availableWidth);
    int marginToCenterY = getMarginToCenter(height, availableHeight);

    return new int[] {marginToCenterX, marginToCenterY};
}

int[] addMarginToMargin(int[] margin1, int[] margin2) {
    int margin1X = margin1[0];
    int margin1Y = margin1[1];

    int margin2X = margin2[0];
    int margin2Y = margin2[1];

    int marginX = margin1X + margin2X;
    int marginY = margin1Y + margin2Y;

    return new int[] {marginX, marginY};
}

int[] addMarginToCenterBoth(int[] size, int[] availableSize, int[] margin) {
    int[] sizeWithMargin = addMarginToSize(size, margin);
    int[] marginToCenterBoth =
        getMarginToCenterBoth(sizeWithMargin, availableSize);

    return addMarginToMargin(margin, marginToCenterBoth);
}

int[] subtractMarginFromCoordinates(int[] coordinates, int[] margin) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int marginX = margin[0];
    int marginY = margin[1];

    x1 += marginX;
    y1 += marginY;

    x2 -= marginX;
    y2 -= marginY;

    return new int[] {x1, y1, x2, y2};
}
