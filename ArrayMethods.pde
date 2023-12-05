int[] copyIntArray(int[] array) {
    int[] arrayCopy = new int[array.length];

    for (int index = 0; index < array.length; index++) {
        arrayCopy[index] = array[index];
    }

    return arrayCopy;
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

boolean equalIntArrays(int[] array1, int[] array2) {
    if (array1.length != array2.length) {
        return false;
    }

    for (int index = 0; index < array1.length; index++) {
        if (array1[index] != array2[index]) {
            return false;
        }
    }

    return true;
}

boolean arrayIsIn2DArray(int[] array, int[][] _2DArray) {
    for (
        int _2DArrayIndex = 0;
        _2DArrayIndex < _2DArray.length;
        _2DArrayIndex++
    ) {
        int[] currentArray = _2DArray[_2DArrayIndex];

        if (equalIntArrays(currentArray, array)) {
            return true;
        }
    }
    
    return false;
}

int[][] concat2DArray(
    int[][] array1,
    int[][] array2,
    boolean preventDuplicates
) {
    int[][] concatenatedArray = array1;

    for (int array2Index = 0; array2Index < array2.length; array2Index++) {
        int[] array2Item = array2[array2Index];

        if (!preventDuplicates || !arrayIsIn2DArray(array2Item, array1)) {
            concatenatedArray = appendTo2DArray(concatenatedArray, array2Item);
        }
    }

    return concatenatedArray;
}

int[][][] subset3DArray(int[][][] array, int startIndex) {
    int[][][] newArray = new int[array.length - startIndex][][];

    for (int index = startIndex; index < array.length; index++) {
        newArray[index - startIndex] = array[index];
    }

    return newArray;
}

boolean intIsInArray(int _int, int[] array) {
    for (int index = 0; index < array.length; index++) {
        int currentInt = array[index];

        if (currentInt == _int) {
            return true;
        }
    }

    return false;
}

int sumArray(int[] array) {
    int sum = 0;

    for (int index = 0; index < array.length; index++) {
        sum += array[index];
    }

    return sum;
}
