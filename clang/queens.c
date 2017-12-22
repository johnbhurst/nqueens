// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-22

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int size;
    int places;
    int col;
    int diag1;
    int diag2;
} Board;

Board new(int size) {
    Board result;
    result.size = size;
    result.places = 0;
    result.col = 0;
    result.diag1 = 0;
    result.diag2 = 0;
    return result;
}

int ok(Board board, int row, int col) {
    return (board.col & (1 << col)) == 0 &&
         (board.diag1 & (1 << (row + col))) == 0 &&
         (board.diag2 & (1 << (row - col + board.size - 1))) == 0;
}

Board place(Board board, int row, int col) {
    Board result;
    result.size = board.size;
    result.places = board.places + 1;
    result.col = board.col | 1 << col;
    result.diag1 = board.diag1 | 1 << (row + col);
    result.diag2 = board.diag2 | 1 << (row - col + board.size - 1);
    return result;
}

int solve(Board board) {
    if (board.places == board.size) {
        return 1;
    }
    else {
        int result = 0;
        int row = board.places;
        for (int col = 0; col < board.size; col++) {
            if (ok(board, row, col)) {
                result += solve(place(board, row, col));
            }
        }
        return result;
    }
}

int main(int argc, char** argv) {
    int from = argc < 2 ? 8 : atoi(argv[1]);
    int to = argc < 3 ? from : atoi(argv[2]);

    for (int size = from; size <= to; size++) {
        clock_t start = clock();
        int result = solve(new(size));
        clock_t end = clock();
        int elapsed = (end - start) / 1000;
        printf("%d: %d (%dms)\n", size, result, elapsed);
    }
}



