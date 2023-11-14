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
