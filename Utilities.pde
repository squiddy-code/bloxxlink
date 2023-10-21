int[] getAvailableSize(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];
    
    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int availableWidth = x2 - x1;
    int availableHeight = y2 - y1;

    return new int[] {
        availableWidth,
        availableHeight
    };
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
