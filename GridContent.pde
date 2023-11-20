Integer getGridContentIndexOfPosition(int[] position, int[][][] gridContent) {
    int column = position[0];
    int row = position[1];

    for (
        int gridContentIndex = 0;
        gridContentIndex < gridContent.length;
        gridContentIndex++
    ) {
        int[][] positions = gridContent[gridContentIndex];

        for (
            int positionIndex = 0;
            positionIndex < positions.length;
            positionIndex++
        ) {
            int[] currentPosition = positions[positionIndex];

            int currentColumn = currentPosition[0];
            int currentRow = currentPosition[1];

            if (currentColumn == column && currentRow == row) {
                return gridContentIndex;
            }
        }
    }

    return null;
}

boolean positionIsEmpty(int[] position, int[][][] gridContent) {
    Integer gridContentIndex = getGridContentIndexOfPosition(
        position,
        gridContent
    );

    return gridContentIndex == null;
}

int[][][] addEmptyArrayToGridContent(int[][][] gridContent) {
    int[][] emptyArray = {};
    return appendTo3DArray(gridContent, emptyArray);
}

int[] getPlayerPosition(int playerIndex, int[][][] gridContent) {
    int[][] playersPositions = gridContent[2];
    return playersPositions[playerIndex];
}

int[][][] copyGridContent(int[][][] gridContent) {
    int[][][] gridContentCopy = new int[gridContent.length][][];

    for (
        int gridContentIndex = 0;
        gridContentIndex < gridContent.length;
        gridContentIndex++
    ) {
        int[][] positions = gridContent[gridContentIndex];
        gridContentCopy[gridContentIndex] = new int[positions.length][];

        for (
            int positionIndex = 0;
            positionIndex < positions.length;
            positionIndex++
        ) {
            int[] position = positions[positionIndex];
            gridContentCopy[gridContentIndex][positionIndex] =
                copyIntArray(position);
        }
    }

    return gridContentCopy;
}

boolean positionInPositions(int[] position, int[][] positions) {
    for (
        int positionIndex = 0;
        positionIndex < positions.length; 
        positionIndex++
    ) {
        int[] currentPosition = positions[positionIndex];

        if (equalIntArrays(currentPosition, position)) {
            return true;
        }
    }

    return false;
}

boolean positionHasObstacle(int[] position, int[][][] gridContent) {
    int obstacleGridContentIndex = 0;
    int[][] obstaclePositions = gridContent[obstacleGridContentIndex];

    return positionInPositions(position, obstaclePositions);
}

boolean positionHasElectricField(int[] position, int[][][] gridContent) {
    int electricFieldGridContentIndex = 1;
    int[][] electricFieldPositions = gridContent[electricFieldGridContentIndex];

    return positionInPositions(position, electricFieldPositions);
}
