Integer getPlayerIndexByKeyCode(int keyCode) {
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

    return isPlayer1KeyCode ? 0 : 1;
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
// TODO merge rowCanBePushed and movePlayer (if that makes sense)?
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

boolean positionsAreInSameRow(
    int[] position1,
    int[] position2,
    int oppositeDimensionIndex
) {
    return (
        position1[oppositeDimensionIndex] == position2[oppositeDimensionIndex]
    );
}

boolean positionIsInPushedRow(
    int[] position,
    int[] pushStartPosition,
    int dimensionIndex,
    int deltaDimension
) {
    int dimension = position[dimensionIndex];
    int pushStartDimension = pushStartPosition[dimensionIndex];

    return (
        (deltaDimension < 0 && dimension <= pushStartDimension) ||
        (deltaDimension > 0 && dimension >= pushStartDimension)
    );
}

int[] getPositionPushedBy(
    int[] position,
    int dimension,
    int dimensionIndex,
    int deltaDimension
) {
    int[] positionPushedBy = copyIntegerArray(position);
    positionPushedBy[dimensionIndex] = dimension - deltaDimension;

    return positionPushedBy;
}

boolean subrowContainsEmptyPosition(
    int[] position,
    int[] pushStartPosition,
    int dimensionIndex,
    int deltaDimension,
    int[][][] gridContent
) {
    for (
        int dimension = position[dimensionIndex];
        dimension != pushStartPosition[dimensionIndex];
        dimension -= deltaDimension
    ) {
        int[] positionPushedBy = getPositionPushedBy(
            position,
            dimension,
            dimensionIndex,
            deltaDimension
        );

        if (positionIsEmpty(positionPushedBy, gridContent)) {
            return true;
        }
    }

    return false;
}

int[][][] movePlayer(int[] position, int[] newPosition, int[][][] gridContent) {
    println("moving player from position");
    println(position);
    println("to position");
    println(newPosition);

    int[][][] newGridContent = copyGridContent(gridContent);

    int dimensionIndex = changedDimensionIsColumn(position, newPosition)
        ? 0
        : 1;
    int oppositeDimensionIndex = dimensionIndex == 0 ? 1 : 0;

    int deltaDimension = newPosition[dimensionIndex] - position[dimensionIndex];

    // gridContentIndex starts at 2 because indices 0 and 1 are for the
    // obstacles and electric fields, and those cannot be moved so it doesn't
    // make sense to include them here.
    for (
        int gridContentIndex = 2;
        gridContentIndex < gridContent.length;
        gridContentIndex++
    ) {
        int[][] positions = newGridContent[gridContentIndex];

        for (
            int positionIndex = 0;
            positionIndex < positions.length;
            positionIndex++
        ) {
            int[] currentPosition = positions[positionIndex];

            if (
                positionsAreInSameRow(
                    currentPosition,
                    newPosition,
                    oppositeDimensionIndex
                ) &&
                positionIsInPushedRow(
                    currentPosition,
                    position,
                    dimensionIndex,
                    deltaDimension
                ) &&
                !subrowContainsEmptyPosition(
                    currentPosition,
                    position,
                    dimensionIndex,
                    deltaDimension,
                    gridContent
                )
            ) {
                currentPosition[dimensionIndex] += deltaDimension;
            }
        }
    }

    return newGridContent;
}
