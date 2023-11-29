int[][] inputsCoordinates = {};

void drawNumberInputRightArrow(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    triangle(x + size, y + size / 2, x, y, x, y + size);

    int x2 = x + size;
    int y2 = y + size;

    coordinates = new int[] {x, y, x2, y2};

    inputsCoordinates = appendTo2DArray(inputsCoordinates, coordinates);
}

void drawNumberInputCounter(int value, int height, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    text(value, x, y + height);
}

void drawNumberInputLeftArrow(int[] coordinates, int size) {
    int x = coordinates[0];
    int y = coordinates[1];

    triangle(x, y + size / 2, x + size, y, x + size, y + size);

    int x2 = x + size;
    int y2 = y + size;

    coordinates = new int[] {x, y, x2, y2};

    inputsCoordinates = appendTo2DArray(inputsCoordinates, coordinates);
}

void drawNumberInput(int value, int height, int[] coordinates) {
    int arrowSize = height;

    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int x = x2 - arrowSize;
    int y = y1;

    coordinates = new int[] {x, y};

    drawNumberInputRightArrow(coordinates, arrowSize);

    int numberInputMarginX = 6;

    x -= textWidth(str(value)) + numberInputMarginX;

    coordinates = new int[] {x, y};

    drawNumberInputCounter(value, height, coordinates);

    x -= arrowSize + numberInputMarginX;

    coordinates = new int[] {x, y};

    drawNumberInputLeftArrow(coordinates, arrowSize);
}

void drawInputLabel(String label, int height, int[] coordinates) {
    int x = coordinates[0];
    int y = coordinates[1];

    text(label, x, y + height);
}

void drawNumberInputWithLabel(String label, int value, int height, int[] coordinates) {
    fill(BLACK);
    textSize(height);
    drawInputLabel(label, height, coordinates);
    drawNumberInput(value, height, coordinates);
}

int[] drawNumberInputsWithLabel(String[] labels, int[] values, int height, int[] coordinates) {
    if (labels.length != values.length) {
        return coordinates;
    }

    int inputAmount = labels.length;

    int x1 = coordinates[0];
    int y1 = coordinates[1];
    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int marginX = 16;
    int marginY = 16;

    int availableWidth = x2 - x1 - marginX * 2;
    int availableHeight = y2 - y1 - marginY * 2;

    int[] availableSize = {availableWidth, availableHeight};

    int inputMarginY = 12;

    int _width = availableWidth;
    int _height = inputAmount * height + (inputAmount - 1) * inputMarginY;

    int[] size = {
        _width,
        _height
    };

    int[] marginToCenter = getMarginToCenterBoth(size, availableSize);

    int marginToCenterX = marginToCenter[0];
    int marginToCenterY = marginToCenter[1];

    marginX += marginToCenterX;
    marginY += marginToCenterY;

    x1 += marginX;
    y1 += marginY;

    x2 -= marginX;
    y2 -= marginY;

    coordinates = new int[] {x1, y1, x2, y2};

    for (int inputIndex = 0; inputIndex < labels.length; inputIndex++) {
        String label = labels[inputIndex];
        int value = values[inputIndex];

        drawNumberInputWithLabel(label, value, height, coordinates);

        boolean isLastInput = inputIndex == labels.length - 1;
        int currentInputMarginY = !isLastInput ? inputMarginY : 0;

        x1 = coordinates[0];
        y1 = coordinates[1] + height + currentInputMarginY;

        x2 = coordinates[2];
        y2 = coordinates[3];

        coordinates = new int[] {x1, y1, x2, y2};
    }

    return coordinates;
}

int[] drawPlayButtonBackground(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int _width = 200;
    int _height = 24;

    int[] size = {_width, _height};

    int availableWidth = x2 - x1;
    int availableHeight = y2 - y1;

    int[] availableSize = {availableWidth, availableHeight};

    int[] marginToCenter = getMarginToCenterBoth(size, availableSize);

    int marginToCenterX = marginToCenter[0];
    int marginToCenterY = marginToCenter[1];

    int x = x1 + marginToCenterX;
    int y = y1 + marginToCenterY;

    fill(WHITE);
    rect(x, y, _width, _height);

    x2 = x + _width;
    y2 = y + _height;

    coordinates = new int[] {x, y, x2, y2};

    inputsCoordinates = appendTo2DArray(inputsCoordinates, coordinates);

    return coordinates;
}

void drawPlayButtonText(int _textSize, int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];

    int x2 = coordinates[2];
    int y2 = coordinates[3];

    String playButtonText = "Spelen!";

    int _width = round(textWidth(playButtonText));
    int _height = _textSize;

    int[] size = {_width, _height};

    int availableWidth = x2 - x1;
    int availableHeight = y2 - y1;

    int[] availableSize = {availableWidth, availableHeight};

    int[] marginToCenter = getMarginToCenterBoth(size, availableSize);

    int marginToCenterX = marginToCenter[0];
    int marginToCenterY = marginToCenter[1];

    x1 += marginToCenterX;
    y1 += marginToCenterY;

    x2 -= marginToCenterX;
    y2 -= marginToCenterY;

    fill(BLACK);
    text(playButtonText, x1, y1 + _textSize);
}

void drawPlayButton(int _textSize, int[] coordinates) {
    coordinates = drawPlayButtonBackground(coordinates);
    drawPlayButtonText(_textSize, coordinates);
}

void drawHomeScreen() {
    int[] margin = {
        60, // x
        60  // y
    };

    int[] size = {
        400,
        400
    };

    int[] sizeWithMargin = new int[] {
        margin[0] + size[0] + margin[0], // width
        margin[1] + size[1] + margin[1]  // height
    };

    int[] availableSize = {
        width,
        height
    };

    int[] marginToCenter =
        getMarginToCenterBoth(sizeWithMargin, availableSize);

    int[] coordinates = {
        margin[0] + marginToCenter[0],
        margin[1] + marginToCenter[1],
        margin[0] + marginToCenter[0] + size[0],
        margin[1] + marginToCenter[1] + size[1]
    };

    fill(WHITE);
    rect(
        coordinates[0],
        coordinates[1],
        coordinates[2] - coordinates[0],
        coordinates[3] - coordinates[1]
    );

    int inputHeight = 16;

    int _textSize = inputHeight;
    textSize(_textSize);

    int[] newCoordinates = drawNumberInputsWithLabel(
        new String[] {
            "Aantal spelers",
            "Aantal blokken per speler",
            "Aantal obstakels"
        },
        new int[] {
            gridContentAmounts[1],
            gridContentAmounts[2],
            gridContentAmounts[0]
        },
        inputHeight,
        coordinates
    );

    int x1 = newCoordinates[0];
    int y1 = newCoordinates[1];

    int x2 = newCoordinates[2];
    int y2 = coordinates[3];

    coordinates = new int[] {x1, y1, x2, y2};

    drawPlayButton(_textSize, coordinates);
}
