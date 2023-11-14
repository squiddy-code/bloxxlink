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

int[] getPlayerPosition(int playerNumber, int[][][] gridContent) {
    int[][] playersPositions = gridContent[2];
    return playersPositions[playerNumber - 1];
}

boolean gridContentIndexIsObstacle(int gridContentIndex) {
    int obstacleIndex = 0;
    return gridContentIndex == obstacleIndex;
}

boolean gridContentIndexIsElectricField(int gridContentIndex) {
    int electricFieldIndex = 1;
    return gridContentIndex == electricFieldIndex;
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
            // TODO use copyIntegerArray?

            int[] position = positions[positionIndex];
            gridContentCopy[gridContentIndex][positionIndex] =
                new int[position.length];

            for (
                int dimensionIndex = 0;
                dimensionIndex < position.length;
                dimensionIndex++
            ) {
                int dimension = gridContent[gridContentIndex][positionIndex][
                    dimensionIndex
                ];

                gridContentCopy[gridContentIndex][positionIndex][
                    dimensionIndex
                ] = dimension;
            }
        }
    }

    return gridContentCopy;
}

boolean gridContentIndexIsPlayer(int gridContentIndex) {
    int playerIndex = 2;
    return gridContentIndex == playerIndex;
}

boolean positionHasPlayer(int[] position, int[][][] gridContent) {
    int gridContentIndex = getGridContentIndexOfPosition(position, gridContent);
    return gridContentIndexIsPlayer(gridContentIndex);
}

void printGridContent(int[][][] gridContent) {
    for (
        int gridContentIndex = 0;
        gridContentIndex < gridContent.length;
        gridContentIndex++
    ) {
        println("grid content index");
        println(gridContentIndex);

        int[][] positions = gridContent[gridContentIndex];
        for (
            int positionIndex = 0;
            positionIndex < positions.length;
            positionIndex++
        ) {
            int[] position = positions[positionIndex];
            println(position);
        }
    }
}
