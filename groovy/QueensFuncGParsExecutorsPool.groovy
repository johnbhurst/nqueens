// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

import java.time.Duration
import java.time.Instant

import groovyx.gpars.GParsExecutorsPool

import static java.lang.Integer.parseInt

class QueensFuncGParsExecutorsPool {
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
  private int row
  private long cols
  private long diags1
  private long diags2

  private Board place(int col) {
    return new Board(
      size: this.size,
      row: this.row + 1,
      cols: this.cols | 1 << col,
      diags1: this.diags1 | 1 << (this.row + col),
      diags2: this.diags2 | 1 << (this.row - col + this.size - 1)
    )
  }

  private boolean ok(int col) {
    return (this.cols & (1 << col)) == 0 &&
      (this.diags1 & (1 << row + col)) == 0 &&
      (this.diags2 & (1 << row - col + this.size - 1)) == 0
  }

  public int solve() {
    if (this.row == this.size) {
      return 1
    }
    else if (this.row == 0) {
      return GParsExecutorsPool.withPool {
        (0..<this.size)
          .findAll {ok(it)}
          .collectParallel {place(it).solve()}
          .sum(0)
      }
    }
    else {
      return (0..<this.size)
        .findAll {ok(it)}
        .collect {place(it).solve()}
        .sum(0)
    }
  }
}

