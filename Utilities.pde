void clearScreen() {
    background(WHITE);
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

int subtractMarginFromLength(int length, int margin) {
    return length - 2 * margin;
}
