import java.util.ArrayList;
import java.util.List;
// $Id: Board.java 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

public class Board {
  private int size;
  private List<Integer> pos;
  private List<Boolean> col;
  private List<Boolean> diag1;
  private List<Boolean> diag2;

  public Board(int size) {
    this.size = size;
    this.pos = new ArrayList<Integer>(size);
    this.col = new ArrayList<Boolean>(size);
    for (int i = 0; i < size; i++) {
      this.pos.add(-1);
      this.col.add(false);
    }
    this.diag1 = new ArrayList<Boolean>(2 * size + 1);
    this.diag2 = new ArrayList<Boolean>(2 * size + 1);
    for (int i = 0; i < 2 * size + 1; i++) {
      this.diag1.add(false);
      this.diag2.add(false);
    }
  }

  public int getSize() {
    return size;
  }

  public void place(int row, int col) {
    pos.set(row, col);
    this.col.set(col, true);
    diag1.set(col - row + size, true);
    diag2.set(col + row, true);
  }

  public int unplace(int row) {
    int col = pos.get(row);
    pos.set(row, -1);
    this.col.set(col, false);
    diag1.set(col - row + size, false);
    diag2.set(col + row, false);
    return col;
  }

  public boolean isOk(int row, int col) {
    return !(this.col.get(col) || diag1.get(col - row + size) || diag2.get(col + row));
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
    return pos.get(row);
  }
}

