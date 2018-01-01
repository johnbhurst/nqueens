// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-09-19

import java.time.Duration;
import java.time.Instant;

public class QueensArr {

  public static void main(String[] args) {
    if (args.length != 1 && args.length != 2) {
      usage();
    }
    int from = Integer.parseInt(args[0]);
    int to = args.length == 1 ? from : Integer.parseInt(args[1]);
    for (int size = from; size <= to; size++) {
      Instant start = Instant.now();
      Board board = new Board(size);
      int count = board.solve();
      Instant end = Instant.now();
      Duration duration = Duration.between(start, end);
      System.out.println("Board size " + size + " has " + count + " solutions. Calculated in " + duration + ".");
    }
  }

  private static void usage() {
    System.err.println("Usage: Queens fromSize [toSize]");
    System.exit(1);
  }

  static class Board {

    private int size;
    private int[] pos;
    private long cols;
    private long diags1;
    private long diags2;

    Board(int size) {
      this.size = size;
      this.pos = new int[size];
    }

    private void place(int row, int col) {
      this.pos[row] = col;
      this.cols |= 1 << col;
      this.diags1 |= 1 << (row + col);
      this.diags2 |= 1 << (row - col + this.size - 1);
    }

    private int remove(int row) {
      int col = this.pos[row];
      this.cols = this.cols & ~(1 << col);
      this.diags1 = this.diags1 & ~(1 << row + col);
      this.diags2 = this.diags2 & ~(1 << row - col + this.size - 1);
      return col;
    }

    private boolean ok(int row, int col) {
      return (this.cols & (1 << col)) == 0 &&
        (this.diags1 & (1 << row + col)) == 0 &&
        (this.diags2 & (1 << row - col + this.size - 1)) == 0;
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

