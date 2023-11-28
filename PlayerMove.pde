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
    
    boolean isPlayer1KeyCode = intIsInArray(keyCode, player1KeyCodes);
    boolean isPlayer2KeyCode = intIsInArray(keyCode, player2KeyCodes);

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

int getDimensionIndex(int[] position, int[] newPosition) {
    int column = position[0];
    int row = position[1];

    int newColumn = newPosition[0];
    int newRow = newPosition[1];

    boolean changedDimensionIsColumn = newColumn != column;

    int columnIndex = 0;
    int rowIndex = 1;

    return changedDimensionIsColumn ? columnIndex : rowIndex;
}

int getOppositeDimensionIndex(int dimensionIndex) {
    return dimensionIndex == 0 ? 1 : 0;
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

int[] copyPositionWithDimension(
    int[] position,
    int dimension,
    int dimensionIndex
) {
    int[] newPosition = copyIntArray(position);
    newPosition[dimensionIndex] = dimension;

    return newPosition;
}

// TODO remove dimension parameter since the dimension can be obtained with position[dimensionIndex]
int[] getPositionPushedBy(
    int[] position,
    int dimension,
    int dimensionIndex,
    int deltaDimension
) {
    int dimensionPushedBy = dimension - deltaDimension;
    return copyPositionWithDimension(
        position,
        dimensionPushedBy,
        dimensionIndex
    );
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

boolean dimensionIsOutsideGrid(
    int dimension,
    int dimensionIndex,
    int[] gridDimensions
) {
    return dimension < 0 || dimension >= gridDimensions[dimensionIndex];
}

int[][][] tryToMovePlayer(
    int[] position, 
    int[] newPosition, 
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][][] newGridContent = copyGridContent(gridContent);

    int dimensionIndex = getDimensionIndex(position, newPosition);
    int oppositeDimensionIndex = getOppositeDimensionIndex(dimensionIndex);

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

            // TODO clean this up
            if (
                !positionsAreInSameRow(
                    currentPosition,
                    newPosition,
                    oppositeDimensionIndex
                ) ||
                (
                    (
                        !positionIsInPushedRow(
                            currentPosition,
                            position,
                            dimensionIndex,
                            deltaDimension
                        ) ||
                        subrowContainsEmptyPosition(
                            currentPosition,
                            position,
                            dimensionIndex,
                            deltaDimension,
                            gridContent
                        )
                    ) &&
                    !equalIntArrays(
                        currentPosition,
                        getPositionPushedBy(
                            position,
                            position[dimensionIndex],
                            dimensionIndex,
                            deltaDimension
                        )
                    )
                )
            ) {
                continue;
            }

            int newDimension = currentPosition[dimensionIndex] + deltaDimension;

            if (
                dimensionIsOutsideGrid(
                    newDimension,
                    dimensionIndex,
                    gridDimensions
                )
            ) {
                return gridContent;
            }

            int[] newCurrentPosition = copyPositionWithDimension(
                currentPosition,
                newDimension,
                dimensionIndex
            );

            if (
                positionHasObstacle(newCurrentPosition, gridContent) ||
                positionHasElectricField(newCurrentPosition, gridContent)
            ) {
                return gridContent;
            }

            newGridContent[gridContentIndex][positionIndex] = newCurrentPosition;
        }
    }

    return newGridContent;
}

boolean playerHasWon(
    int playerIndex,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int playerBlocksIndex = 3 + playerIndex;
    int[][] blocksPositions = gridContent[playerBlocksIndex];

    int[][] connectedBlocksPositions = {blocksPositions[0]};

    for (
        int connectedBlocksPositionsIndex = 0;
        connectedBlocksPositionsIndex < connectedBlocksPositions.length;
        connectedBlocksPositionsIndex++
    ) {
        int[] currentPosition = 
            connectedBlocksPositions[connectedBlocksPositionsIndex];

        int[][] adjacentPositions = getAdjacentPositions(
            currentPosition,
            gridDimensions,
            playerBlocksIndex,
            false
        );

        connectedBlocksPositions =
            concat2DArray(connectedBlocksPositions, adjacentPositions, true);
    }

    return connectedBlocksPositions.length == blocksPositions.length;
}

Integer getWinnerIndex(int[] gridDimensions, int[][][] gridContent) {
    int playerAmount = gridContent[2].length;

    for (int playerIndex = 0; playerIndex < playerAmount; playerIndex++) {
        if (playerHasWon(playerIndex, gridDimensions, gridContent)) {
            return playerIndex;
        }        
    }

    return null;
}
