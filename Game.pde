void drawCurrentScreen(
    int screenIndex,
    int[] gridDimensions,
    int[][][] gridContent,
    int[] scores,
    int winnerIndex
) {
    switch (screenIndex) {
        case 0:
            resetScores();
            drawHomeScreen();
            break;
        case 1:
            drawMainGameScreen(gridDimensions, gridContent, scores);
            break;
        case 2:
            drawEndScreen(winnerIndex, scores[winnerIndex]);
            break;
        default:
            break;
    }
}

int[][][] startGame() {
    int[][][] newGridContent = getRandomGridContent(
        gridDimensions,
        gridContentAmounts
    );

    showMainGameScreen();
    return newGridContent;
}
