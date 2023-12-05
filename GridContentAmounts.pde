int[] gridContentAmounts = {
    4, // # of obstacles
    2, // # of players
    8  // # of blocks per player
};

int[][] gridContentAmountsRanges = {
    { // obstacles
        0, // min
        10 // max
    },
    { // players
        1, // min
        2  // max
    },
    { // blocks per player
        0, // min
        10 // max
    }
};

Integer getGridContentAmountsIndex(int buttonsCoordinatesIndex) {
    switch (buttonsCoordinatesIndex) {
        // player
        case 0:
        case 1:
            return 1;
        // block
        case 2:
        case 3:
            return 2;
        // obstacle
        case 4:
        case 5:
            return 0;
        default:
            return null;
    }
}

int getGridContentAmountToAdd(int buttonsCoordinatesIndex) {
    boolean buttonsCoordinatesIndexIsEven = buttonsCoordinatesIndex % 2 == 0;
    return buttonsCoordinatesIndexIsEven ? 1 : -1;
}

void addAmountToGridContentAmount(
    int amountToAdd,
    int gridContentAmountsIndex
) {
    int range[] = gridContentAmountsRanges[gridContentAmountsIndex];

    int minAmount = range[0];
    int maxAmount = range[1];

    int amount = gridContentAmounts[gridContentAmountsIndex];
    int newAmount = amount + amountToAdd;

    println(newAmount);
    println(minAmount);
    println(maxAmount);

    if (newAmount >= minAmount && newAmount <= maxAmount) {
        gridContentAmounts[gridContentAmountsIndex] = newAmount;
    }
}

void onGridContentAmountButtonPressed(int buttonsCoordinatesIndex) {
    Integer gridContentAmountsIndex = getGridContentAmountsIndex(buttonsCoordinatesIndex);
    if (gridContentAmountsIndex == null) {
        return;
    }

    int gridContentAmountToAdd = getGridContentAmountToAdd(buttonsCoordinatesIndex);
    addAmountToGridContentAmount(gridContentAmountToAdd, gridContentAmountsIndex);
}
