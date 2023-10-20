void drawScoreCounter(int[] coordinates, int textSize, int[] scores) {
    fill(BLACK);
    textSize(textSize);

    int x1 = coordinates[0];
    int y1 = coordinates[1];
    int x2 = coordinates[2];

    int width = x2 - x1;

    int playerScoreTextY = y1 + textSize;
    text("Speler 1: " + scores[0], x1, playerScoreTextY);

    String player2ScoreText = "Speler 2: " + scores[1];
    float player2ScoreTextWidth = textWidth(player2ScoreText);
    int player2ScoreTextX = x1 + width - ceil(player2ScoreTextWidth);

    text(player2ScoreText, player2ScoreTextX, playerScoreTextY);
}
