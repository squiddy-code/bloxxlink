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

    // if (positionIsOnEdge(position, gridDimensions)) {
    //     println("cannot move to position (position is on edge)");
    //     println(position);

    //     return false;
    // }

    boolean positionHasObstacle = gridContentIndexIsObstacle(gridContentIndex);
    boolean positionHasElectricField = gridContentIndexIsElectricField(
        gridContentIndex
    );

    return (
        !positionHasObstacle &&
        (canEnterElectricField || !positionHasElectricField)
    );
}

// boolean rowCanBePushed(
//     int[] position,
//     int[] newPosition,
//     int[] gridDimensions,
//     int[][][] gridContent
// ) {
//     int column = position[0];
//     int row = position[1];

//     int newColumn = newPosition[0];
//     int newRow = newPosition[1];

//     int columnAmount = gridDimensions[0];
//     int rowAmount = gridDimensions[1];

//     boolean changedDimensionIsColumn = newColumn != column && newRow == row;

//     int newDimension = changedDimensionIsColumn ? newColumn : newRow;
//     int dimensionAmount = changedDimensionIsColumn ? columnAmount : rowAmount;

//     for (
//         int currentDimension = newDimension;
//         currentDimension < dimensionAmount;
//         currentDimension++
//     ) {
//         int currentColumn = changedDimensionIsColumn
//             ? currentDimension
//             : newColumn;

//         int currentRow = !changedDimensionIsColumn ? currentDimension : newRow;

//         int[] currentPosition = {currentColumn, currentRow};
//         if (positionIsEmpty(currentPosition, gridContent)) {
//             println("position is empty 1");
//             println(newPosition);

//             return true;
//         }

//         boolean isFirstMove = currentDimension == newDimension;

//         if (
//             !canMoveToPosition(
//                 currentPosition,
//                 gridDimensions,
//                 gridContent,
//                 isFirstMove
//             )
//         ) {
//             println("cannot move to position");
//             println(newPosition);

//             return false;
//         }
//     }

//     return true;
// }

// TODO fix potential bug: player cannot move because there's an obstacle in the same row
boolean rowCanBePushed(
    int[] position,
    int[] newPosition,
    int[] gridDimensions,
    int[][][] gridContent
) {
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

// int[][][] tryToMovePlayer(
//     int[] position,
//     int[] newPosition,
//     int[] gridDimensions,
//     int[][][] gridContent
// ) {
//     println("trying to move player from position");
//     println(position);
//     println("to position");
//     println(newPosition);

//     if (
//         !rowCanBePushed(
//             position,
//             newPosition,
//             gridDimensions,
//             gridContent
//         )
//     ) {
//         println("player cannot be moved (row cannot be pushed)");
//         println(newPosition);

//         return gridContent;
//     }

//     int[][][] newGridContent = copyGridContent(gridContent);

//     int column = newPosition[0];
//     int row = newPosition[1];

//     int previousColumn = position[0];
//     int previousRow = position[1];

//     int deltaColumn = column - previousColumn;
//     int deltaRow = row - previousRow;

//     boolean dimensionIsColumn = column != previousColumn;

//     for (
//         int gridContentIndex = 0;
//         gridContentIndex < gridContent.length;
//         gridContentIndex++
//     ) {
//         int[][] positions = gridContent[gridContentIndex];

//         for (
//             int positionIndex = 0;
//             positionIndex < positions.length;
//             positionIndex++
//         ) {
//             int[] currentPosition = positions[positionIndex];

//             int currentColumn = currentPosition[0];
//             int currentRow = currentPosition[1];

//             int newColumn = currentColumn;
//             int newRow = currentRow;

//             if (
//                 currentRow == row &&
//                 (
//                     currentColumn == column - deltaColumn ||
//                     (deltaColumn < 0 && currentColumn <= column) ||
//                     (deltaColumn > 0 && currentColumn >= column)
//                 )
//             ) {
//                 newColumn += deltaColumn;
//             }

//             if (
//                 currentColumn == column &&
//                 // (
//                 //     currentRow == previousRow ||
//                 //     currentRow == previousRow - 1 ||
//                 //     currentRow == previousRow + 1 ||
//                 //     (deltaRow < 0 && currentRow <= row) ||
//                 //     (deltaRow > 0 && currentRow >= row)
//                 // )
//                 (
//                     currentRow == row - deltaRow ||
//                     (deltaRow < 0 && currentRow <= row) ||
//                     (deltaRow > 0 && currentRow >= row)
//                 )
//             ) {
//                 newRow += deltaRow;
//             }

//             int[] newPosition = {newColumn, newRow};

//             boolean isPlayerMoveToEmptyPosition = 
//                 gridContentIndex == 2 &&
//                 positionIsEmpty(newPosition, gridContent);

//             newGridContent[gridContentIndex][positionIndex] = newPosition;

//             if (isPlayerMoveToEmptyPosition) {
//                 return newGridContent;
//             }
//         }
//     }

//     return newGridContent;
// }

// int[][] getPositionsBetweenPositions(
//     int[] positionA,
//     int[] positionB,
//     int dimensionIndex
// ) {
//     if (positionA[dimensionIndex] > positionB[dimensionIndex]) {
//         int[] previousPositionA = copyIntegerArray(positionA);

//         positionA = copyIntegerArray(positionB);
//         positionB = previousPositionA;
//     }

//     int[][] positions = {};

//     for (
//         int currentDimension = positionA[dimensionIndex];
//         currentDimension <= positionB[dimensionIndex];
//         currentDimension++
//     ) {
//         int[] position = copyIntegerArray(positionA);
//         position[dimensionIndex] = currentDimension;

//         positions = (int[][]) append(positions, position);
//     }

//     return positions;
// }

int[][][] tryToMovePlayer(
    int[] position,
    int[] newPosition,
    int[] gridDimensions,
    int[][][] gridContent
) {
    println("trying to move player from position");
    println(position);
    println("to position");
    println(newPosition);

    if (
        !rowCanBePushed(
            position,
            newPosition,
            gridDimensions,
            gridContent
        )
    ) {
        println("player cannot be moved (row cannot be pushed)");
        println(newPosition);

        return gridContent;
    }

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

            // int[][] positionsInBetween = getPositionsBetweenPositions(
            //     newPosition,
            //     currentPosition,
            //     dimensionIndex
            // );

            // println("----");
            // for (int i = 0; i < positionsInBetween.length; i++) {
            //     println(positionsInBetween[i]);
            // }
            // println("----");

            if (
                isSameOppositeDimension &&
                currentDeltaDimension * deltaDimension >= 0 &&
                (
                    !positionIsEmpty(previousPosition, gridContent) ||
                    // !positionsAreEmpty(positionsInBetween, gridContent) ||
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

            // if (positionIsEmpty(newCurrentPosition, gridContent)) {
            //     println("new current position is empty, done moving player");
            //     println(newCurrentPosition);

            //     return newGridContent;
            // }
        }
    }

    return newGridContent;
}
