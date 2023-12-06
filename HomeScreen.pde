int[] getNumberInputsSize(
    int availableWidth,
    int inputAmount,
    int inputHeight,
    int inputMarginY
) {
    int width = availableWidth;
    int height = inputAmount * inputHeight + (inputAmount - 1) * inputMarginY;

    return new int[] {width, height};
}

void drawInputLabel(String label, int height, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    text(label, x, y + height);
}

int[] getArrowCoordinates(int arrowSize, int marginRight, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    x -= arrowSize + marginRight;

    return new int[] {x, y};
}

void drawNumberInputArrow(int[] coordinates, int size, boolean isLeftArrow) {
    int x = coordinates[0];
    int y = coordinates[1];

    int baseX = x + int(isLeftArrow) * size;
    int pointX = x + int(!isLeftArrow) * size;

    int base1Y = y;
    int base2Y = base1Y + size;

    int pointY = base1Y + size / 2;

    triangle(baseX, base1Y, baseX, base2Y, pointX, pointY);

    coordinates = dualToQuadCoordinates(coordinates, size);

    buttonsCoordinates = appendTo2DArray(buttonsCoordinates, coordinates);
}

int[] getNumberInputCounterCoordinates(
    int value,
    int marginRight,
    int[] coordinates
) {
    int x = coordinates[0];
    int y = coordinates[1];

    int valueTextWidth = round(textWidth(str(value)));
    x -= valueTextWidth + marginRight;

    return new int[] {x, y};
}

void drawNumberInputCounter(int value, int height, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    text(value, x, y + height);
}

void drawNumberInput(int value, int height, int[] coordinates) {
    int arrowSize = height;
    int marginRight = 0;

    coordinates = getArrowCoordinates(arrowSize, marginRight, coordinates);
    boolean isLeftArrow = false;
    drawNumberInputArrow(coordinates, arrowSize, isLeftArrow);

    marginRight = 6;
    coordinates = getNumberInputCounterCoordinates(
        value,
        marginRight,
        coordinates
    );
    drawNumberInputCounter(value, height, coordinates);

    coordinates = getArrowCoordinates(arrowSize, marginRight, coordinates);
    isLeftArrow = true;
    drawNumberInputArrow(coordinates, arrowSize, isLeftArrow);
}

void drawNumberInputWithLabel(
    String label,
    int value,
    int height,
    int[] coordinates
) {
    fill(BLACK);
    textSize(height);

    int[] inputLabelCoordinates = alignTopLeft(coordinates);
    drawInputLabel(label, height, inputLabelCoordinates);

    int[] numberInputCoordinates = alignTopRight(coordinates);
    drawNumberInput(value, height, numberInputCoordinates);
}

int[] addNumberInputHeightToCoordinates(
    int inputHeight,
    int inputMarginY,
    boolean isLastInput,
    int[] coordinates
) {
    int currentInputMarginY = !isLastInput ? inputMarginY : 0;

    int x1 = coordinates[0];
    int y1 = coordinates[1] + inputHeight + currentInputMarginY;

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    return new int[] {x1, y1, x2, y2};
}

int[] drawNumberInputsWithLabel(
    String[] labels,
    int[] values,
    int inputHeight,
    int[] coordinates
) {
    if (labels.length != values.length) {
        return coordinates;
    }

    int marginX = 16;
    int marginY = 16;

    int[] margin = {marginX, marginY};

    int availableWidth = getWidth(coordinates, margin);

    int inputAmount = labels.length;
    int inputMarginY = 12;

    int[] size = getNumberInputsSize(
        availableWidth,
        inputAmount,
        inputHeight,
        inputMarginY
    );

    coordinates = centerBoth(coordinates, size, margin);

    for (int inputIndex = 0; inputIndex < inputAmount; inputIndex++) {
        String label = labels[inputIndex];
        int value = values[inputIndex];

        drawNumberInputWithLabel(label, value, inputHeight, coordinates);

        boolean isLastInput = inputIndex == inputAmount - 1;
        coordinates = addNumberInputHeightToCoordinates(
            inputHeight,
            inputMarginY,
            isLastInput,
            coordinates
        );
    }

    return coordinates;
}

int[] drawHomeScreenInputs(
    int[] gridContentAmounts,
    int inputHeight,
    int[] coordinates
) {
    String[] inputLabels = {
        "Aantal spelers",
        "Aantal blokken per speler",
        "Aantal obstakels"
    };

    int[] inputValues = {
        gridContentAmounts[1], // # of players
        gridContentAmounts[2], // # of blocks per player
        gridContentAmounts[0]  // # of obstacles
    };

    return drawNumberInputsWithLabel(
        inputLabels,
        inputValues,
        inputHeight,
        coordinates
    );
}

int[] getPlayButtonCoordinates(
    int inputsCoordinatesY1,
    int[] homeScreenCoordinates
) {
    int x1 = homeScreenCoordinates[0];
    int y1 = inputsCoordinatesY1;

    int x2 = homeScreenCoordinates[2];
    int y2 = homeScreenCoordinates[3];

    return new int[] {x1, y1, x2, y2};
}

void drawHomeScreen() {
    resetButtonsCoordinates();

    int width = 400;
    int height = 400;

    int[] size = {width, height};

    int marginX = 60;
    int marginY = 60;

    int[] margin = {marginX, marginY};

    int[] coordinates = centerInFullScreen(size, margin);
    drawWhiteRectangle(coordinates);

    int inputHeight = 16;
    int _textSize = inputHeight;

    textSize(_textSize);

    int[] inputsCoordinates = drawHomeScreenInputs(
        gridContentAmounts,
        inputHeight,
        coordinates
    );

    int inputsCoordinatesY1 = inputsCoordinates[1];
    coordinates = getPlayButtonCoordinates(inputsCoordinatesY1, coordinates);

    int playButtonTextMarginX = 24;
    int playButtonTextMarginY = 8;

    int[] playButtonTextMargin = {
        playButtonTextMarginX,
        playButtonTextMarginY
    };

    drawButton("Spelen!", _textSize, playButtonTextMargin, coordinates);
}

void showHomeScreen() {
    screenIndex = 0;
}
