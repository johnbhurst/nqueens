// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-09-19

public class Board {

  private int size;
  private int[] pos;
  private long col;
  private long diag1;
  private long diag2;

  Board(int size) {
    this.size = size;
    this.pos = new int[size];
  }

  private void place(int row, int col) {
    this.pos[row] = col;
    this.col |= 1 << col;
    this.diag1 |= 1 << (row + col);
    this.diag2 |= 1 << (row - col + this.size - 1);
  }

  private int remove(int row) {
    int col = this.pos[row];
    this.col = this.col & ~(1 << col);
    this.diag1 = this.diag1 & ~(1 << row + col);
    this.diag2 = this.diag2 & ~(1 << row - col + this.size - 1);
    return col;
  }

  private boolean ok(int row, int col) {
    return (this.col & (1 << col)) == 0 &&
      (this.diag1 & (1 << row + col)) == 0 &&
      (this.diag2 & (1 << row - col + this.size - 1)) == 0;
  }

  private Pair backtrack(int row, int col) {
    while (col == this.size && row >= 0) {
      row--;
      if (row >= 0) {
        col = this.remove(row) + 1;
      }
    }
    return new Pair(row, col);
  }

  public int solve() {
    int row = 0;
    int col = 0;
    int result = 0;
    while (row >= 0) {
      if (this.ok(row, col)) {
        this.place(row, col);
        if (row < this.size - 1) {
          row++;
          col = 0;
        }
        else {
          result++;
          col = this.remove(row) + 1;
          if (col == this.size) {
            Pair pair = this.backtrack(row, col);
            row = pair.row;
            col = pair.col;
          }
        }
      }
      else {
        col++;
        if (col == this.size) {
          Pair pair = this.backtrack(row, col);
          row = pair.row;
          col = pair.col;
        }
      }
    }
    return result;
  }

  static class Pair {
    Pair(int row, int col) {
      this.row = row;
      this.col = col;
    }

    int row;
    int col;
  }
}