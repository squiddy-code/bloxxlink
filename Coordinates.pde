int[] coordinatesToSize(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int width = x2 - x1;
    int height = y2 - y1;

    return new int[] {width, height};
}

int[] centerBoth(int[] coordinates, int[] size, int[] margin) {
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

    return centerBoth(coordinates, size, margin);
}

int getAxisLength(int axisIndex, int[] coordinates, int[] margin) {
    int axis1 = coordinates[axisIndex];
    int axis2 = coordinates[axisIndex + 2];

    int length = axis2 - axis1;
    int axisMargin = margin[axisIndex];

    return subtractMarginFromLength(length, axisMargin);
}

int getWidth(int[] coordinates, int[] margin) {
    int xIndex = 0;
    return getAxisLength(xIndex, coordinates, margin);
}

int[] alignTopLeft(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x = x1;
    int y = y1;

    return new int[] {x, y};
}

int[] alignTopRight(int[] coordinates) {
    int y1 = coordinates[1];
    int x2 = coordinates[2];

    int x = x2;
    int y = y1;

    return new int[] {x, y};
}

int[] dualToQuadCoordinates(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    int x1 = x;
    int y1 = y;

    int x2 = x + size;
    int y2 = y + size;

    return new int[] {x1, y1, x2, y2};
}
