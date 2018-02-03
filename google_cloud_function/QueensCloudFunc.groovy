// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-08

import java.time.Duration
import java.time.Instant

import groovyx.gpars.GParsPool

import static java.lang.Integer.parseInt

int from = args.length >= 1 ? parseInt(args[0]) : 0
int to = args.length >= 2 ? parseInt(args[1]) : from


for (int size = from; size <= to; size++) {
  Instant start = Instant.now()
  int count = new Board(size: size).solve()
  Instant end = Instant.now()
  Duration duration = Duration.between(start, end)
  println("Board size $size has $count solutions. Calculated in $duration.")
}

class Board {
  private static final int MAX_POOL_SIZE = 2000
  private static final int DEPTH = 4
  private static final int FETCH_ATTEMPTS = 1
  private static final int INITIAL_DELAY_MILLIS = 500
  private static final BigDecimal DELAY_MULTIPLIER = 1.5

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

  private String toURL() {
    return String.format(
      "https://us-central1-nqueens-gcp.cloudfunctions.net/queensGET?size=%d&row=%d&cols=%d&diags1=%d&diags2=%d",
      size, row, cols, diags1, diags2
    )
  }

  private static  List<Board> getBoards(int size, int row, List<Board> boards) {
    if (row >= DEPTH) {
      return boards
    }
    else {
      List<Board> newBoards = boards.collect {board ->
        (0..<size)
          .findAll {board.ok(it)}
          .collect {board.place(it)}
      }.flatten()
      return getBoards(size, row+1, newBoards)
    }
  }

  private int fetchSolution() {
    String url = toURL()
    int delayMillis = INITIAL_DELAY_MILLIS
    for (i in 1..FETCH_ATTEMPTS) {
      try {
        return new URL(url).text as Integer
      }
      catch (Throwable ex) {
        System.err.println("HTTP failure on $url: $ex")
        System.err.println(ex.getClass())
        ex.printStackTrace()
        Thread.sleep(delayMillis)
        delayMillis *= DELAY_MULTIPLIER
      }
    }
    System.err.println("Retries exceeded for $url, quitting")
    throw new RuntimeException("Retries exceeded for $url, quitting")
  }

  public int solve() {
    List<Board> boards = getBoards(this.size, 0, [this])
    println("Number to evaluate: ${boards.size()}")
    int poolSize = Math.min(boards.size(), MAX_POOL_SIZE)
    GParsPool.withPool(poolSize) {
      return boards.collectParallel {it.fetchSolution()}.sum(0)
    }
  }
}

