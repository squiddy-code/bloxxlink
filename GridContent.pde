int[] getRandomGridPosition(int[] gridDimensions) {
    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int column = int(random(columnAmount));
    int row = int(random(rowAmount));

    return new int[] {column, row};
}

boolean positionIsInGridContent(
    int[] position,
    int[][][] gridContent
) {
    int column = position[0];
    int row = position[1];

    for (
        int gridItemIndex = 0;
        gridItemIndex < gridContent.length;
        gridItemIndex++
    ) {
        int[][] gridItem = gridContent[gridItemIndex];

        for (
            int positionIndex = 0;
            positionIndex < gridItem.length;
            positionIndex++
        ) {
            int[] gridItemPosition = gridItem[positionIndex];

            int gridItemColumn = gridItemPosition[0];
            int gridItemRow = gridItemPosition[1];

            if (column == gridItemColumn && row == gridItemRow) {
                return true;
            }
        }
    }

    return false;
}

int[] getRandomGridPositionWithoutDuplicate(
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[] randomGridPosition = getRandomGridPosition(gridDimensions);

    if (positionIsInGridContent(randomGridPosition, gridContent)) {
        randomGridPosition = getRandomGridPositionWithoutDuplicate(
            gridDimensions,
            gridContent
        );
    }

    return randomGridPosition;
}

int[][] addPositionToPositions(int[] position, int[][] positions) {
    return (int[][]) append(positions, position);
}

int[][] getRandomGridPositionsWithoutDuplicates(
    int amount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][] positions = {};

    for (int count = 0; count < amount; count++) {
        int[] position = getRandomGridPositionWithoutDuplicate(
            gridDimensions,
            gridContent
        );
        positions = addPositionToPositions(position, positions);
    }

    return positions;
}

int[][][] addPositionsToGridContent(int[][] positions, int[][][] gridContent) {
    return (int[][][]) append(gridContent, positions);
}

int[][][] addRandomPositionsToGridContent(
    int amount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][] positions = getRandomGridPositionsWithoutDuplicates(
        amount,
        gridDimensions,
        gridContent
    );

    return addPositionsToGridContent(positions, gridContent);
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
                columnOffset == 0
                && rowOffset == 0;
            
            if (
                currentPositionIsPosition
                || currentColumn < 0
                || currentColumn >= columnAmount
            ) {
                continue;
            }

            int[] currentPosition = {currentColumn, currentRow};
            adjacentPositions = addPositionToPositions(
                currentPosition,
                adjacentPositions
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

    for (int positionIndex = 0; positionIndex < positions.length; positionIndex++) {
        int[] position = positions[positionIndex];
        int[][] adjacentPositions = getAdjacentPositions(position, gridDimensions);
        allAdjacentPositions = (int[][]) concat(allAdjacentPositions, adjacentPositions);
    }

    return addPositionsToGridContent(allAdjacentPositions, gridContent);
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

    int[][] obstaclesPositions = getRandomGridPositionsWithoutDuplicates(
        obstacleAmount,
        gridDimensions,
        gridContent
    );

    gridContent = addPositionsToGridContent(obstaclesPositions, gridContent);

    gridContent = addAdjacentPositionsToGridContent(
        obstaclesPositions,
        gridDimensions,
        gridContent
    );

    gridContent = addRandomPositionsToGridContent(
        playerAmount,
        gridDimensions,
        gridContent
    );

    gridContent = addBlocksPositionsToGridContent(
        blockAmount,
        playerAmount,
        gridDimensions,
        gridContent
    );

    return gridContent;
}
