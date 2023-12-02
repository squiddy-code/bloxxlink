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
