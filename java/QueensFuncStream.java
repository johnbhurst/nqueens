// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

import java.time.Duration;
import java.time.Instant;

import static java.lang.Integer.parseInt;
import static java.util.stream.IntStream.range;

public class QueensFuncStream {

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
    private int placed;
    private long col;
    private long diag1;
    private long diag2;

    Board(int size) {
      this.size = size;
    }

    private Board place(int col) {
      Board result = new Board(this.size);
      int row = this.placed;
      result.placed = this.placed + 1;
      result.col = this.col | 1 << col;
      result.diag1 = this.diag1 | 1 << (row + col);
      result.diag2 = this.diag2 | 1 << (row - col + this.size - 1);
      return result;
    }

    private boolean ok(int col) {
      int row = this.placed;
      return (this.col & (1 << col)) == 0 &&
        (this.diag1 & (1 << row + col)) == 0 &&
        (this.diag2 & (1 << row - col + this.size - 1)) == 0;
    }

    public int solve() {
      return this.placed == this.size ? 1 :
        range(0, this.size)
          .filter(this::ok)
          .mapToObj(this::place)
          .mapToInt(Board::solve)
          .sum();
    }
  }

}

