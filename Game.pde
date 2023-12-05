void startGame() {
    gridContent = getRandomGridContent(
        gridDimensions,
        gridContentAmounts
    );

    showMainGameScreen();
}

void endGame() {
    resetScores();
    showHomeScreen();
}
