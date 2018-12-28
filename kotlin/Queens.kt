// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-01

import java.time.Duration
import java.time.Instant

import java.time.temporal.ChronoUnit.NANOS
import java.time.temporal.ChronoUnit.SECONDS

class Board(
  val size: Int = 0,   // size of board
  val row: Int = 0,    // current row placed
  val cols: Int = 0,   // bits indicating occupied columns
  val diags1: Int = 0, // bits indicating occupied diagonal
  val diags2: Int = 0  // bits indicating occupied diagonal
) {
  fun ok(col: Int) =
    (cols and (1 shl col)) or
    (diags1 and (1 shl row + col)) or
    (diags2 and (1 shl row - col + size - 1)) == 0

  fun place(col: Int) = Board(
    size = this.size,
    row = this.row + 1,
    cols = this.cols or (1 shl col),
    diags1 = this.diags1 or (1 shl this.row + col),
    diags2 = this.diags2 or (1 shl this.row - col + this.size - 1)
  )

  fun solve(): Int =
    if (row == size) 1 else
      (0 until size)
        .filter(::ok)
        .map { place(it).solve() }
        .sum()
}

fun main(args: Array<String>) {
  val from = if (args.size > 0) Integer.parseInt(args[0]) else 8
  val to = if (args.size > 1) Integer.parseInt(args[1]) else from
  for (size in from..to) {
    val start = Instant.now()
    val result = Board(size).solve()
    val end = Instant.now()
    val duration = Duration.between(start, end)
    val seconds = duration.get(SECONDS) + duration.get(NANOS)/1000000000.0
    println("$size,$result,$seconds")
  }
}
