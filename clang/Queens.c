// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-22

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
  int size;
  int row;
  long cols;
  long diags1;
  long diags2;
} Board;

Board new(int size) {
  return (Board){size, 0, 0, 0, 0};
}

int ok(Board* board, int col) {
  return (board->cols & (1 << col)) == 0 &&
         (board->diags1 & (1 << (board->row + col))) == 0 &&
         (board->diags2 & (1 << (board->row - col + board->size - 1))) == 0;
}

Board place(Board* board, int col) {
  return (Board){
    board->size,
    board->row + 1,
    board->cols | 1 << col,
    board->diags1 | 1 << (board->row + col),
    board->diags2 | 1 << (board->row - col + board->size - 1)
  };
}

int solve(Board* board) {
  if (board->row == board->size) {
    return 1;
  }
  else {
    int result = 0;
    for (int col = 0; col < board->size; col++) {
      if (ok(board, col)) {
        Board newBoard = place(board, col);
        result += solve(&newBoard);
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
    Board board = new(size);
    int result = solve(&board);
    clock_t end = clock();
    float elapsed = (end - start) / 1000000.0;
    printf("%d,%d,%0.3f\n", size, result, elapsed);
  }
}



