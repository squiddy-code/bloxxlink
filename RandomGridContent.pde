int[] getRandomGridPosition(int[] gridDimensions) {
    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int column = int(random(columnAmount));
    int row = int(random(rowAmount));

    return new int[] {column, row};
}

int[] getRandomGridPositionWithoutDuplicate(
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[] randomGridPosition = getRandomGridPosition(gridDimensions);

    if (!positionIsEmpty(randomGridPosition, gridContent)) {
        randomGridPosition = getRandomGridPositionWithoutDuplicate(
            gridDimensions,
            gridContent
        );
    }

    return randomGridPosition;
}

int[][][] addPositionToLastArrayOfGridContent(
    int[] position,
    int[][][] gridContent
) {
    gridContent[gridContent.length - 1] = appendTo2DArray(
        gridContent[gridContent.length - 1],
        position
    );

    return gridContent;
}

int[][][] addRandomPositionsToGridContent(
    int amount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    gridContent = addEmptyArrayToGridContent(gridContent);

    for (int count = 0; count < amount; count++) {
        int[] position = getRandomGridPositionWithoutDuplicate(
            gridDimensions,
            gridContent
        );

        gridContent = addPositionToLastArrayOfGridContent(
            position,
            gridContent
        );
    }

    return gridContent;
}

int[][] getAdjacentPositions(int[] position, int[] gridDimensions) {
    int[][] adjacentPositions = {};

    int column = position[0];
    int row = position[1];

    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int adjacentRowOffset = 1;
    int adjacentColumnOffset = 1;

    for (int rowOffset = -1; rowOffset <= adjacentRowOffset; rowOffset++) {
        int currentRow = row + rowOffset;
        if (currentRow < 0 || currentRow >= rowAmount) {
            continue;
        }

        for (
            int columnOffset = -1;
            columnOffset <= adjacentColumnOffset;
            columnOffset++
        ) {
            int currentColumn = column + columnOffset;
            boolean currentPositionIsPosition =
                columnOffset == 0 && rowOffset == 0;
            
            if (
                currentPositionIsPosition ||
                currentColumn < 0 ||
                currentColumn >= columnAmount
            ) {
                continue;
            }

            int[] currentPosition = {currentColumn, currentRow};
            adjacentPositions = appendTo2DArray(
                adjacentPositions,
                currentPosition
            );
        }
    }

    return adjacentPositions;
}

int[][][] addAdjacentPositionsToGridContent(
    int[][] positions,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][] allAdjacentPositions = {};

    for (
        int positionIndex = 0;
        positionIndex < positions.length;
        positionIndex++
    ) {
        int[] position = positions[positionIndex];
        int[][] adjacentPositions = getAdjacentPositions(
            position,
            gridDimensions
        );

        allAdjacentPositions = concat2DArray(
            allAdjacentPositions,
            adjacentPositions
        );
    }

    return (int[][][]) appendTo3DArray(gridContent, allAdjacentPositions);
}

int[][][] addBlocksPositionsToGridContent(
    int blockAmount,
    int playerAmount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    for (int playerCount = 0; playerCount < playerAmount; playerCount++) {
        gridContent = addRandomPositionsToGridContent(
            blockAmount,
            gridDimensions,
            gridContent
        );
    }

    return gridContent;
}

int[][][] getRandomGridContent(int[] gridDimensions, int[] amounts) {
    int obstacleAmount = amounts[0];
    int playerAmount = amounts[1];
    int blockAmount = amounts[2];

    int[][][] gridContent = {};

    // add the obstacles
    gridContent = addRandomPositionsToGridContent(
        obstacleAmount,
        gridDimensions,
        gridContent
    );

    int[][] obstaclesPositions = gridContent[gridContent.length - 1];

    // add the electric fields
    gridContent = addAdjacentPositionsToGridContent(
        obstaclesPositions,
        gridDimensions,
        gridContent
    );

    // add the players
    gridContent = addRandomPositionsToGridContent(
        playerAmount,
        gridDimensions,
        gridContent
    );

    // add the blocks
    gridContent = addBlocksPositionsToGridContent(
        blockAmount,
        playerAmount,
        gridDimensions,
        gridContent
    );

    return gridContent;
}
