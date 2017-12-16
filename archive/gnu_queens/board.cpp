// $Id: board.cpp 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-25 

#include "board.h"

Board::Board(int size) :
  size_(size), pos_(size, -1), col_(size, false), diag1_(2*size+1, false), diag2_(2*size+1, false) {
}

int Board::size() {
  return size_;
}

void Board::place(int row, int col) {
  pos_[row] = col;
  col_[col] = true;
  diag1_[col-row+size_] = true;
  diag2_[col+row] = true;
}

int Board::unplace(int row) {
  int col = pos_[row];
  pos_[row] = -1;
  col_[col] = false;
  diag1_[col-row+size_] = false;
  diag2_[col+row] = false;
  return col;
}

bool Board::is_ok(int row, int col) {
  return !(col_[col] || diag1_[col-row+size_] || diag2_[col+row]);
}

bool Board::solve() {
  int row = 0;
  int col = 0;
  while (row >= 0 && row < size_) {
    while (col < size_ && !is_ok(row, col)) {
      col++;
    }
    if (col < size_) {
      place(row, col);
      row++;
      col = 0;
    }
    else {
      row--;
      if (row >= 0) {
        col = unplace(row) + 1;
      }
    }
  }
  return row == size_;
}

int Board::col(int row) {
  return pos_[row];
}

