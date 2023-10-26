boolean positionIsOutsideGrid(int[] position, int[] gridDimensions) {
    int column = position[0];
    int row = position[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    return column >= columnAmount || row >= rowAmount;
}

boolean gridContentIndexIsObstacle(int gridContentIndex) {
    int obstacleIndex = 0;
    return gridContentIndex == obstacleIndex;
}

boolean gridContentIndexIsElectricField(int gridContentIndex) {
    int electricFieldIndex = 1;
    return gridContentIndex == electricFieldIndex;
}

boolean canMoveToPosition(
    int[] position,
    int[] gridDimensions,
    int[][][] gridContent,
    boolean canEnterElectricField
) {
    if (positionIsOutsideGrid(position, gridDimensions)) {
        return false;
    }

    Integer gridContentIndex = getGridContentIndexOfPosition(position, gridContent);
    if (gridContentIndex == null) {
        return true;
    }

    boolean positionHasObstacle = gridContentIndexIsObstacle(gridContentIndex);
    boolean positionHasElectricField = gridContentIndexIsElectricField(gridContentIndex);

    return (
        !positionHasObstacle &&
        (canEnterElectricField || !positionHasElectricField)
    );
}

boolean rowCanBePushed(
    int[] position,
    int[] previousPosition,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int column = position[0];
    int row = position[1];

    int previousColumn = previousPosition[0];
    int previousRow = previousPosition[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    boolean dimensionIsColumn = column != previousColumn;

    int dimension = dimensionIsColumn ? column : row;
    int dimensionAmount = dimensionIsColumn ? columnAmount : rowAmount;

    for (
        int currentDimension = dimension;
        currentDimension < dimensionAmount;
        currentDimension++
    ) {
        int currentColumn = dimensionIsColumn ? currentDimension : column;
        int currentRow = !dimensionIsColumn ? currentDimension : row;

        int[] currentPosition = {currentColumn, currentRow};

        boolean isFirstMove = currentDimension == dimension;

        if (
            !canMoveToPosition(
                currentPosition,
                gridDimensions,
                gridContent,
                isFirstMove
            )
        ) {
            return false;
        }
    }

    return true;
}

void movePlayer(
    int playerNumber,
    int[] position,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][] playersPositions = gridContent[2];
    int[] currentPosition = playersPositions[playerNumber - 1];

    if (
        !rowCanBePushed(
            position,
            currentPosition,
            gridDimensions,
            gridContent
        )
    ) {
        return;
    }
}
