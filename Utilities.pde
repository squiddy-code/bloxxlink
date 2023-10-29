// back-end utilities
int[] copyIntegerArray(int[] array) {
    int[] arrayCopy = new int[array.length];

    for (int index = 0; index < array.length; index++) {
        arrayCopy[index] = array[index];
    }

    return arrayCopy;
}

boolean integerIsInArray(int integer, int[] array) {
    for (int integerIndex = 0; integerIndex < array.length; integerIndex++) {
        int currentInteger = array[integerIndex];

        if (currentInteger == integer) {
            return true;
        }
    }

    return false;
}

int[][] appendTo2DArray(int[][] array, int[] item) {
    int[][] newArray = new int[array.length + 1][];

    for (int index = 0; index < array.length; index++) {
        newArray[index] = array[index];
    }

    newArray[array.length] = item;

    return newArray;
}

int[][][] appendTo3DArray(int[][][] array, int[][] item) {
    int[][][] newArray = new int[array.length + 1][][];

    for (int index = 0; index < array.length; index++) {
        newArray[index] = array[index];
    }

    newArray[array.length] = item;

    return newArray;
}

int[][] concat2DArray(int[][] array1, int[][] array2) {
    int[][] concatenatedArray = new int[array1.length + array2.length][];

    for (int array1Index = 0; array1Index < array1.length; array1Index++) {
        concatenatedArray[array1Index] = array1[array1Index];
    }

    for (int array2Index = concatenatedArray.length - 1; array2Index < array2.length; array2Index++) {
        concatenatedArray[array2Index] = array2[array2Index];
    }

    return concatenatedArray;
}

// front-end utilities

void clearScreen() {
    background(WHITE);
}

int[] getSizeFromCoordinates(int[] coordinates) {
    int x1 = coordinates[0];
    int y1 = coordinates[1];
    
    int x2 = coordinates[2];
    int y2 = coordinates[3];

    int width = x2 - x1;
    int height = y2 - y1;

    return new int[] {width, height};
}

int subtractMarginFromLength(int length, int margin) {
    return length - 2 * margin;
}

int[] subtractMarginFromSize(int[] size, int[] margin) {
    int width = size[0];
    int height = size[1];

    int marginX = margin[0];
    int marginY = margin[1];

    return new int[] {
        subtractMarginFromLength(width, marginX),
        subtractMarginFromLength(height, marginY)
    };
}
