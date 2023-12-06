void showEndScreen() {
    screenIndex = 2;
}

int[] getEndScreenContentSize(
    int availableWidth,
    int[] heights
) {
    int width = availableWidth;
    int height = sumArray(heights);

    return new int[] {width, height};
}

int[] drawEndScreenTitle(
    int wonPlayerIndex,
    int _textSize,
    int[] coordinates
) {
    int wonPlayerNumber = wonPlayerIndex + 1;
    String title = "Van harte gefeliciteerd speler " + str(wonPlayerNumber) + "!";

    return drawCenteredText(title, _textSize, coordinates);
}

int[] drawEndScreenSubtitle(int score, int _textSize, int[] coordinates) {
    String subtitle = "Je hebt maarliefst " + str(score) + " punten behaald.";
    return drawCenteredText(subtitle, _textSize, coordinates);
}

void drawEndScreen(int wonPlayerIndex, int score) {
    int width = 600;
    int height = 600;

    int[] size = {width, height};

    int marginX = 60;
    int marginY = 60;

    int[] margin = {marginX, marginY};

    int endButtonTextMarginX = 24;
    int endButtonTextMarginY = 8;

    int[] endButtonTextMargin = {endButtonTextMarginX, endButtonTextMarginY};

    int[] coordinates = centerInFullScreen(size, margin);
    drawWhiteRectangle(coordinates);

    int availableWidth = getWidth(coordinates, getNoMargin());

    int titleTextSize = 32;

    int subtitleMarginTop = 12;
    int subtitleTextSize = 20;

    int endButtonMarginTop = 36;
    int endButtonTextSize = 16;

    int endButtonHeight = addMarginToLength(
        endButtonTextSize,
        endButtonTextMarginY
    );

    int[] heights = {
        titleTextSize,
        subtitleMarginTop,
        subtitleTextSize,
        endButtonMarginTop,
        endButtonHeight
    };
    size = getEndScreenContentSize(availableWidth, heights);

    coordinates = centerBoth(coordinates, size, getNoMargin());
    coordinates = drawEndScreenTitle(
        wonPlayerIndex,
        titleTextSize,
        coordinates
    );

    coordinates = subtractMarginTop(subtitleMarginTop, coordinates);
    coordinates = drawEndScreenSubtitle(
        score,
        subtitleTextSize,
        coordinates
    );

    coordinates = subtractMarginTop(endButtonMarginTop, coordinates);
    drawButton(
        "Opnieuw spelen",
        endButtonTextSize,
        endButtonTextMargin,
        coordinates
    );
}
