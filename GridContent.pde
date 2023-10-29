int[][][] addEmptyArrayToGridContent(int[][][] gridContent) {
    int[][] emptyArray = {};
    // return (int[][][]) append(gridContent, emptyArray);
    return appendTo3DArray(gridContent, emptyArray);
}

int[] getRandomGridPosition(int[] gridDimensions) {
    int columnAmount = gridDimensions[0];
    int rowAmount = gridDimensions[1];

    int column = int(random(columnAmount));
    int row = int(random(rowAmount));

    return new int[] {column, row};
}

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
    Integer gridContentIndex = getGridContentIndexOfPosition(position, gridContent);
    return gridContentIndex == null;
}

// boolean positionsAreEmpty(int[][] positions, int[][][] gridContent) {
//     for (int positionIndex = 0; positionIndex < positions.length; positionIndex++) {
//         int[] position = positions[positionIndex];

//         if (!positionIsEmpty(position, gridContent)) {
//             return false;
//         }
//     }

//     return true;
// }

boolean gridContentIndexIsObstacle(int gridContentIndex) {
    int obstacleIndex = 0;
    return gridContentIndex == obstacleIndex;
}

boolean gridContentIndexIsElectricField(int gridContentIndex) {
    int electricFieldIndex = 1;
    return gridContentIndex == electricFieldIndex;
}

boolean gridContentIndexIsPlayer(int gridContentIndex) {
    int playerIndex = 2;
    return gridContentIndex == playerIndex;
}

boolean positionHasPlayer(int[] position, int[][][] gridContent) {
    int gridContentIndex = getGridContentIndexOfPosition(position, gridContent);
    return gridContentIndexIsPlayer(gridContentIndex);
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
    // gridContent[gridContent.length - 1] = (int[][]) append(
    //     gridContent[gridContent.length - 1],
    //     position
    // );
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
            // adjacentPositions = (int[][]) append(
            //     adjacentPositions,
            //     currentPosition
            // );
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
        
        // allAdjacentPositions = (int[][]) concat(
        //     allAdjacentPositions,
        //     adjacentPositions
        // );
        allAdjacentPositions = concat2DArray(
            allAdjacentPositions,
            adjacentPositions
        );
    }

    // return (int[][][]) append(gridContent, allAdjacentPositions);
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

    gridContent = addRandomPositionsToGridContent(
        obstacleAmount,
        gridDimensions,
        gridContent
    );

    int[][] obstaclesPositions = gridContent[gridContent.length - 1];

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

int[] getPlayerPosition(int playerNumber, int[][][] gridContent) {
    int[][] playersPositions = gridContent[2];
    return playersPositions[playerNumber - 1];
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
                int dimension =
                    gridContent[gridContentIndex][positionIndex][dimensionIndex];

                gridContentCopy[gridContentIndex][positionIndex][
                    dimensionIndex
                ] = dimension;
            }
        }
    }

    return gridContentCopy;
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
