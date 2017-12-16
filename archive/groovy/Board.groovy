// $Id: Board.groovy 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

class Board {
  int size
  private int[] pos
  private boolean[] col
  private boolean[] diag1
  private boolean[] diag2

  Board(int size) {
    this.size = size
    this.pos = new int[size]
    for (i in 0..<size) {
      pos[i] = -1
    }
    this.col = new boolean[size]
    this.diag1 = new boolean[2 * size + 1]
    this.diag2 = new boolean[2 * size + 1]
  }

  void place(int row, int col) {
    pos[row] = col
    this.col[col] = true
    diag1[col - row + size] = true
    diag2[col + row] = true
  }

  int unplace(int row) {
    int col = pos[row]
    pos[row] = -1
    this.col[col] = false
    diag1[col - row + size] = false
    diag2[col + row] = false
    return col
  }

  boolean isOk(int row, int col) {
    return !(this.col[col] || diag1[col - row + size] || diag2[col + row])
  }

  boolean solve() {
    int row = 0
    int col = 0
    while (row >= 0 && row < size) {
      while (col < size && !isOk(row, col)) {
        col++;
      }
      if (col < size) {
        place(row, col)
        row++
        col = 0
      }
      else {
        row--
        if (row >= 0) {
          col = unplace(row) + 1
        }
      }
    }
    return row == size
  }

  int getCol(int row) {
    return pos[row]
  }
}
