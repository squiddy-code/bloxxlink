void clearScreen() {
    background(WHITE);
}

// TODO move all margin related functions to seperate file

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

int[] coordinatesToSize(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int width = x2 - x1;
    int height = y2 - y1;

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

    margin = new int[] {marginX, marginY};

    return margin;
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

int[] getCoordinatesToCenterBoth(
    int[] size,
    int[] coordinates,
    int[] margin
) {
    int[] availableSize = coordinatesToSize(coordinates);
    int[] marginToCenter = addMarginToCenterBoth(size, availableSize, margin);

    return subtractMarginFromCoordinates(coordinates, marginToCenter);
}

int[] centerInFullScreen(int[] size, int[] margin) {
    int availableWidth = width;
    int availableHeight = height;

    int x1 = 0;
    int y1 = 0;

    int x2 = availableWidth;
    int y2 = availableHeight;

    int[] coordinates = {x1, y1, x2, y2};

    return getCoordinatesToCenterBoth(size, coordinates, margin);
}
