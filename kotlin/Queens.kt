// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-01

import java.time.Duration
import java.time.Instant

fun main(args: Array<String>) {
  val from = if (args.size > 0) Integer.parseInt(args[0]) else 8
  val to = if (args.size > 1) Integer.parseInt(args[1]) else from

  for (size in from..to) {
    val start = Instant.now()
    val count = Board(size).solve()
    val end = Instant.now()
    val duration = Duration.between(start, end)
    println("Board size $size has $count solutions. Calculated in $duration.")
  }
}

class Board(
  val size: Int = 0,
  val placed: Int = 0,
  val col: Int = 0,
  val diag1: Int = 0,
  val diag2: Int = 0
) {
  fun place(col: Int) = Board(
      size = this.size,
      placed = this.placed + 1,
      col = this.col or (1 shl col),
      diag1 = this.diag1 or (1 shl this.placed + col),
      diag2 = this.diag2 or (1 shl this.placed - col + this.size - 1)
    )

  fun ok(col: Int) =
      (this.col and (1 shl col)) == 0 &&
      (this.diag1 and (1 shl this.placed + col)) == 0 &&
      (this.diag2 and (1 shl this.placed - col + this.size - 1)) == 0

  fun solve(): Int =
    if (placed == size) 1 else
      (0 until this.size)
        .filter(::ok)
        .map(::place)
        .map { it.solve() }
        .sum()
}
