Integer getPlayerNumberByKeyCode(int keyCode) {
    int[] player1KeyCodes = {
        87, // w
        65, // a
        83, // s
        68  // d
    };

    int[] player2KeyCodes = {
        38, // up arrow
        37, // left arrow
        40, // down arrow
        39  // right arrow
    };
    
    boolean isPlayer1KeyCode = integerIsInArray(keyCode, player1KeyCodes);
    boolean isPlayer2KeyCode = integerIsInArray(keyCode, player2KeyCodes);

    if (!isPlayer1KeyCode && !isPlayer2KeyCode) {
        return null;
    }

    return isPlayer1KeyCode ? 1 : 2;
}

int[] getNewPlayerPosition(int keyCode, int[] currentPosition) {
    int currentColumn = currentPosition[0];
    int currentRow = currentPosition[1];

    int newColumn = currentColumn;
    int newRow = currentRow;

    switch (keyCode) {
        case 87: // w
        case 38: // up arrow
            newRow--;
            break;
        
        case 65: // a
        case 37: // left arrow
            newColumn--;
            break;
        
        case 83: // s
        case 40: // down arrow
            newRow++;
            break;
        
        case 68: // d
        case 39: // right arrow
            newColumn++;
            break;

        default:
            break;
    }

    return new int[] {newColumn, newRow};
}

boolean changedDimensionIsColumn(int[] position, int[] newPosition) {
    int column = position[0];
    int row = position[1];

    int newColumn = newPosition[0];
    int newRow = newPosition[1];

    return newColumn != column && newRow == row;
}

boolean dimensionIsInsideGrid(
    int dimension,
    int dimensionAmount
) {
    return dimension >= 0 && dimension < dimensionAmount;
}

boolean dimensionIsOnEdge(int dimension, int dimensionAmount) {
    return dimension == 0 || dimension + 1 == dimensionAmount;
}

boolean positionIsOutsideGrid(int[] position, int[] gridDimensions) {
    int column = position[0];
    int row = position[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    return column < 0 || row < 0 || column >= columnAmount || row >= rowAmount;
}

boolean canMoveToPosition(
    int[] position,
    int[] gridDimensions,
    int[][][] gridContent,
    boolean canEnterElectricField
) {
    println("can move to position");
    println(position);

    if (positionIsOutsideGrid(position, gridDimensions)) {
        println("I SHOULD NEVER HAVE BEEN CALLED");
        println("cannot move to position (position is outside grid 2)");
        println(position);

        return false;
    }

    Integer gridContentIndex = getGridContentIndexOfPosition(
        position,
        gridContent
    );

    if (gridContentIndex == null) {
        println("can move to position (position is empty 2)");
        println(position);

        return true;
    }

    boolean positionHasObstacle = gridContentIndexIsObstacle(gridContentIndex);
    boolean positionHasElectricField = gridContentIndexIsElectricField(
        gridContentIndex
    );

    return (
        !positionHasObstacle &&
        (canEnterElectricField || !positionHasElectricField)
    );
}

// TODO fix potential bug: player cannot move because there's an obstacle in the same row
boolean rowCanBePushed(
    int[] position,
    int[] newPosition,
    int[] gridDimensions,
    int[][][] gridContent
) {
    if (positionIsOutsideGrid(newPosition, gridDimensions)) {
        return false;
    }

    // TODO make function getDimensionIndex?
    int dimensionIndex = changedDimensionIsColumn(position, newPosition)
        ? 0
        : 1;

    int newDimension = newPosition[dimensionIndex];
    int dimensionAmount = gridDimensions[dimensionIndex];
    int deltaDimension = newPosition[dimensionIndex] - position[dimensionIndex];

    int[] currentPosition = copyIntegerArray(position);

    for (
        int currentDimension = newDimension;
        dimensionIsInsideGrid(currentDimension, dimensionAmount);
        currentDimension += deltaDimension
    ) {
        currentPosition[dimensionIndex] = currentDimension;

        if (positionIsEmpty(currentPosition, gridContent)) {
            println("position is empty so row can be pushed");
            println(currentPosition);

            return true;
        }

        boolean isFirstMove = currentDimension == newDimension;

        if (
            dimensionIsOnEdge(currentDimension, dimensionAmount) ||
            !canMoveToPosition(
                currentPosition,
                gridDimensions,
                gridContent,
                isFirstMove
            )
        ) {
            println("row cannot be pushed");
            println(currentPosition);

            return false;
        }
    }

    return true;
}

int[][][] movePlayer(
    int[] position,
    int[] newPosition,
    int[] gridDimensions,
    int[][][] gridContent
) {
    println("trying to move player from position");
    println(position);
    println("to position");
    println(newPosition);

    int[][][] newGridContent = copyGridContent(gridContent);

    // TODO clean this up
    int dimensionIndex = changedDimensionIsColumn(position, newPosition)
        ? 0
        : 1;
    int oppositeDimensionIndex = dimensionIndex == 0 ? 1 : 0;

    int deltaDimension = newPosition[dimensionIndex] - position[dimensionIndex];

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
            int[] newCurrentPosition = copyIntegerArray(currentPosition);
    
            boolean isSameOppositeDimension =
                currentPosition[oppositeDimensionIndex] ==
                newPosition[oppositeDimensionIndex];

            int currentDeltaDimension =
                currentPosition[dimensionIndex] - position[dimensionIndex];

            int[] previousPosition = copyIntegerArray(currentPosition);
            previousPosition[dimensionIndex] -= deltaDimension;

            if (
                isSameOppositeDimension &&
                currentDeltaDimension * deltaDimension >= 0 &&
                (
                    !positionIsEmpty(previousPosition, gridContent) ||
                    positionHasPlayer(currentPosition, gridContent)
                )
            ) {
                println("changing position from");
                println(newCurrentPosition);

                newCurrentPosition[dimensionIndex] += deltaDimension;

                println("to");
                println(newCurrentPosition);
            }

            newGridContent[gridContentIndex][
                positionIndex
            ] = newCurrentPosition;
        }
    }

    return newGridContent;
}
