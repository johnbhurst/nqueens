// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

import java.time.Duration;
import java.time.Instant;

import static java.lang.Integer.parseInt;

public class QueensFunc {

  public static void main(String[] args) {
    int from = args.length >= 1 ? parseInt(args[0]) : 0;
    int to = args.length >= 2 ? parseInt(args[1]) : from;

    for (int size = from; size <= to; size++) {
      Instant start = Instant.now();
      Board board = new Board(size);
      int count = board.solve();
      Instant end = Instant.now();
      Duration duration = Duration.between(start, end);
      System.out.println("Board size " + size + " has " + count + " solutions. Calculated in " + duration + ".");
    }
  }

  static class Board {

    private int size;
    private int row;
    private long cols;
    private long diags1;
    private long diags2;

    Board(int size) {
      this.size = size;
    }

    private Board place(int col) {
      Board result = new Board(this.size);
      result.row = this.row + 1;
      result.cols = this.cols | 1 << col;
      result.diags1 = this.diags1 | 1 << (this.row + col);
      result.diags2 = this.diags2 | 1 << (this.row - col + this.size - 1);
      return result;
    }

    private boolean ok(int col) {
      return (this.cols & (1 << col)) == 0 &&
        (this.diags1 & (1 << this.row + col)) == 0 &&
        (this.diags2 & (1 << this.row - col + this.size - 1)) == 0;
    }

    public int solve() {
      if (this.row == this.size) {
        return 1;
      }
      else {
        int result = 0;
        for (int col = 0; col < this.size; col++) {
          if (ok(col)) {
            result += place(col).solve();
          }
        }
        return result;
      }
    }
  }

}

