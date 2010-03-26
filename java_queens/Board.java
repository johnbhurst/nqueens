// $Id: Board.java 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

public class Board {
  private int size;
  private int[] pos;
  private boolean[] col;
  private boolean[] diag1;
  private boolean[] diag2;

  public Board(int size) {
    this.size = size;
    this.pos = new int[size];
    for (int i = 0; i < size; i++) {
      pos[i] = -1;
    }
    this.col = new boolean[size];
    this.diag1 = new boolean[2 * size + 1];
    this.diag2 = new boolean[2 * size + 1];
  }

  public int getSize() {
    return size;
  }

  public void place(int row, int col) {
    pos[row] = col;
    this.col[col] = true;
    diag1[col - row + size] = true;
    diag2[col + row] = true;
  }

  public int unplace(int row) {
    int col = pos[row];
    pos[row] = -1;
    this.col[col] = false;
    diag1[col - row + size] = false;
    diag2[col + row] = false;
    return col;
  }

  public boolean isOk(int row, int col) {
    return !(this.col[col] || diag1[col - row + size] || diag2[col + row]);
  }

  public boolean solve() {
    int row = 0;
    int col = 0;
    while (row >= 0 && row < size) {
      while (col < size && !isOk(row, col)) {
        col++;
      }
      if (col < size) {
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
    return row == size;
  }

  public int getCol(int row) {
    return pos[row];
  }
}

