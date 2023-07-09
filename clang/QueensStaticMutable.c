// Copyright 2023 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2023-07-08

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct {
  int col;
  long cols;
  long diags1;
  long diags2;
} Board;

inline int ok(Board* board, int row, int col, int size) {
  return ((board->cols & (1 << col)) |
         (board->diags1 & (1 << (row + col))) |
         (board->diags2 & (1 << (row - col + size - 1)))) == 0;
}

inline void place1(Board* newBoard, int row, int col, int size) {
  newBoard->col = col;
  newBoard->cols = 1 << col;
  newBoard->diags1 = 1 << (row + col);
  newBoard->diags2 = 1 << (row - col + size - 1);
}

inline void place(Board* board, Board* newBoard, int row, int col, int size) {
  newBoard->col = col;
  newBoard->cols = board->cols | 1 << col;
  newBoard->diags1 = board->diags1 | 1 << (row + col);
  newBoard->diags2 = board->diags2 | 1 << (row - col + size - 1);
}

int solve(Board* board, int size) {
  int row = 0;
  int col = 0;
  int result = 0;
  while (row >= 0) {
    if (row == size) {
      result++;
      do {
        row--;
      } while (row >= 0 && board[row].col == size - 1);
      if (row >= 0) {
        col = board[row].col + 1;
      }
    }
    else {
      if (row == 0) {
        place1(&board[row], row, col, size);
        row++;
        col = 0;
      }
      else {
        if (ok(&board[row-1], row, col, size)) {
          place(&board[row-1], &board[row], row, col, size);
          row++;
          col = 0;
        }
        else {
          col++;
          if (col == size) {
            do {
              row--;
            } while (row >= 0 && board[row].col == size - 1);
            if (row >= 0) {
              col = board[row].col + 1;
            }
          }
        }
      }
    }
  }
  return result;
}

int main(int argc, char** argv) {
  int from = argc < 2 ? 8 : atoi(argv[1]);
  int to = argc < 3 ? from : atoi(argv[2]);

  for (int size = from; size <= to; size++) {
    clock_t start = clock();
    Board* boards = malloc((size+1) * sizeof(Board));
    memset(boards, 0, sizeof(Board) * size);

    int result = solve(boards, size);

    free(boards);
    clock_t end = clock();
    float elapsed = (end - start) / 1000000.0;
    printf("%d,%d,%0.3f\n", size, result, elapsed);

  }
}



// Set row<-0;
// Set col<-0;
// OK, so place Q(0,0). row++ (row==1), col<-0;
// not OK, so col++ (col==1).
// not OK, so col++ (col==2).
// OK, so place(1,2). row++ (row==2), col<-0;
// not OK, so col++ (col==1).
// not OK, so col++ (col==2).
// not OK, so col++ (col==3).
// not OK, so col++ (col==4).
// col==size, so row-- (row==1), col<-board[row].col+1 (col==3).
// OK, so place(1,3). row++ (row==2), col<-0;
// not OK, so col++ (col==1).
// OK, so place(2,1). row++ (row==3), col<-0;
// not OK, so col++ (col==1).
// not OK, so col++ (col==2).
// not OK, so col++ (col==3).
// not OK, so col++ (col==4).
// col==size, so row-- (row==2), col<-board[row].col+1 (col==4).
// col==size, so row-- (row==1), col<-board[row].col+1 (col==4).


//if (row == 0) {
//printf("row=%d, col=%d, board.col=%d, board.cols=%ld, board.diags1=%ld, board.diags2=%ld\n", row, col, board[row].col, board[row].cols, board[row].diags1, board[row].diags2);
//}
//else {
//printf("row=%d, col=%d, board.col=%d, board.cols=%ld, board.diags1=%ld, board.diags2=%ld\n", row, col, board[row-1].col, board[row-1].cols, board[row-1].diags1, board[row-1].diags2);
//}
