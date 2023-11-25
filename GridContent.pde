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

boolean equalGridContents(int[][][] gridContent1, int[][][] gridContent2) {
    if (gridContent1.length != gridContent2.length) {
        return false;
    }

    for (
        int gridContentIndex = 0;
        gridContentIndex < gridContent1.length;
        gridContentIndex++
    ) {
        int[][] positions1 = gridContent1[gridContentIndex];
        int[][] positions2 = gridContent2[gridContentIndex];

        if (positions1.length != positions2.length) {
            return false;
        }

        for (
            int positionIndex = 0;
            positionIndex < positions1.length;
            positionIndex++
        ) {
            int[] position1 = positions1[positionIndex];
            int[] position2 = positions2[positionIndex];

            if (!equalIntArrays(position1, position2)) {
                return false;
            }
        }
    }

    return true;
}