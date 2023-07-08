// Copyright 2023 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2023-07-08

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct {
  // int size;
  // int row;
  long cols;
  long diags1;
  long diags2;
} Board;

static int size;

static inline int ok(Board* board, int row, int col) {
  return ((board->cols & (1 << col)) |
         (board->diags1 & (1 << (row + col))) |
         (board->diags2 & (1 << (row - col + size - 1)))) == 0;
}

static inline void place(Board* board, Board* newBoard, int row, int col) {
  newBoard->cols = board->cols | 1 << col;
  newBoard->diags1 = board->diags1 | 1 << (row + col);
  newBoard->diags2 = board->diags2 | 1 << (row - col + size - 1);
}

int solve(Board* board, int row) {
  int result = 0;
  for (int col = 0; col < size; col++) {
    if (ok(board, row, col)) {
      if (row+1 == size) {
        result++;
      }
      else {
        Board* newBoard = board + 1;
        memcpy(newBoard, board, sizeof(Board));
        place(board, newBoard, row, col);
        result += solve(newBoard, row+1);

      }
    }
  }
  return result;
}

int main(int argc, char** argv) {
  int from = argc < 2 ? 8 : atoi(argv[1]);
  int to = argc < 3 ? from : atoi(argv[2]);

  for (size = from; size <= to; size++) {
    clock_t start = clock();
    Board* boards = malloc((size+1) * sizeof(Board));
    memset(boards, 0, sizeof(Board) * size);

    int result = solve(boards, 0);

    free(boards);
    clock_t end = clock();
    float elapsed = (end - start) / 1000000.0;
    printf("%d,%d,%0.3f\n", size, result, elapsed);

  }
}



