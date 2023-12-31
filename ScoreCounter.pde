int getScoreCounterHeight(int textSize) {
    int marginBottom = 20;
    return textSize + marginBottom;
}

String getPlayerScoreText(int playerNumber, int score) {
    return "Speler " + playerNumber + ": " + score;
}

void drawPlayer1ScoreText(int score, int x1, int y) {
    int playerNumber = 1;
    text(getPlayerScoreText(playerNumber, score), x1, y);
}

void drawPlayer2ScoreText(int score, int x2, int y) {
    int playerNumber = 2;

    String scoreText = getPlayerScoreText(playerNumber, score);
    int scoreTextWidth = ceil(textWidth(scoreText));
    int x = x2 - scoreTextWidth;

    text(scoreText, x, y);
}

void drawScoreCounter(int[] coordinates, int _textSize, int[] scores) {
    fill(BLACK);
    textSize(_textSize);

    int x1 = coordinates[0];
    int y1 = coordinates[1];
    int x2 = coordinates[2];

    int playerScoreTextY = y1 + _textSize;

    int player1Score = scores[0];
    int player2Score = scores[1];

    drawPlayer1ScoreText(player1Score, x1, playerScoreTextY);
    drawPlayer2ScoreText(player2Score, x2, playerScoreTextY);
}
