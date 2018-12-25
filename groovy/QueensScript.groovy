// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

import java.time.Duration
import java.time.Instant

import static java.lang.Integer.parseInt
import static java.time.temporal.ChronoUnit.NANOS
import static java.time.temporal.ChronoUnit.SECONDS

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
      (this.diags1 & (1 << this.row + col)) == 0 &&
      (this.diags2 & (1 << this.row - col + this.size - 1)) == 0
  }

  public int solve() {
    if (this.row == this.size) {
      return 1
    }
    else {
      int result = 0
      for (int col = 0; col < this.size; col++) {
        if (ok(col)) {
          result += place(col).solve()
        }
      }
      return result
    }
  }
}

int from = args.length >= 1 ? parseInt(args[0]) : 0
int to = args.length >= 2 ? parseInt(args[1]) : from

for (int size = from; size <= to; size++) {
  Instant start = Instant.now()
  int count = new Board(size: size).solve()
  Instant end = Instant.now()
  Duration duration = Duration.between(start, end)
  BigDecimal seconds = duration.get(SECONDS) +
    (duration.get(NANOS)/1000000000).setScale(3, BigDecimal.ROUND_HALF_UP)
  println("$size,$count,$seconds")
}

