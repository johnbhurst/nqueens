// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

import java.time.Duration
import java.time.Instant

import static java.lang.Integer.parseInt

class QueensFunc {
  static void main(String[] args) {
    int from = args.length >= 1 ? parseInt(args[0]) : 0
    int to = args.length >= 2 ? parseInt(args[1]) : from

    for (int size = from; size <= to; size++) {
      Instant start = Instant.now()
      int count = new Board(size: size).solve()
      Instant end = Instant.now()
      Duration duration = Duration.between(start, end)
      println("Board size $size has $count solutions. Calculated in $duration.")
    }
  }
}

class Board {
  private int size
  private int placed
  private long col
  private long diag1
  private long diag2

  private Board place(int col) {
    int row = this.placed
    return new Board(
      size: this.size,
      placed: this.placed + 1,
      col: this.col | 1 << col,
      diag1: this.diag1 | 1 << (row + col),
      diag2: this.diag2 | 1 << (row - col + this.size - 1)
    )
  }

  private boolean ok(int col) {
    int row = this.placed
    return (this.col & (1 << col)) == 0 &&
      (this.diag1 & (1 << row + col)) == 0 &&
      (this.diag2 & (1 << row - col + this.size - 1)) == 0
  }

  public int solve() {
    return this.placed == this.size ? 1 :
      (0..<this.size)
        .findAll {ok(it)}
        .collect {place(it).solve()}
        .sum(0)
  }
}

