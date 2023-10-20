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
