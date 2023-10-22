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
        positions = (int[][]) append(positions, position);
    }

    return positions;
}

int[][][] addPositionsToGridContent(
    int amount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    int[][] positions = getRandomGridPositionsWithoutDuplicates(
        amount,
        gridDimensions,
        gridContent
    );
    gridContent = (int[][][]) append(gridContent, positions);

    return gridContent;
}

int[][][] addBlocksPositionsToGridContent(
    int blockAmount,
    int playerAmount,
    int[] gridDimensions,
    int[][][] gridContent
) {
    for (int playerCount = 0; playerCount < playerAmount; playerCount++) {
        gridContent = addPositionsToGridContent(
            blockAmount,
            gridDimensions,
            gridContent
        );
    }

    return gridContent;
}

int[][][] getRandomGridContent(int[] gridDimensions, int[] amounts) {
    int playerAmount = amounts[0];
    int obstacleAmount = amounts[1];
    int blockAmount = amounts[2];

    int[][][] gridContent = {};

    gridContent = addPositionsToGridContent(
        playerAmount,
        gridDimensions,
        gridContent
    );

    gridContent = addPositionsToGridContent(
        obstacleAmount,
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
