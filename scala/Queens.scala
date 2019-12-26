// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-12-28

import java.time.Duration
import java.time.Instant

import java.time.temporal.ChronoUnit.NANOS
import java.time.temporal.ChronoUnit.SECONDS

class Board(s: Int, r: Int, c: Int, d1: Int, d2: Int) {
  private val size = s
  private val row = r
  private val cols = c
  private val diags1 = d1
  private val diags2 = d2

  def this(s: Int) = this(s, 0, 0, 0, 0)

  def ok(col: Int): Boolean = {
    return ((cols & (1 << col)) |
           (diags1 & (1 << row + col)) |
           (diags2 & (1 << row - col + size - 1))) == 0
  }

  def place(col: Int): Board = {
    return new Board(
      size,
      row + 1,
      cols | (1 << col),
      diags1 | (1 << row + col),
      diags2 | (1 << row - col + size - 1)
    )
  }

  def solve(): Int = {
    return if (row == size) 1 else
    //   (for (col <- 0 until size; if (ok(col)))
    //     yield place(col).solve
    //   ).sum
      (0 until size)
        .withFilter(col => ok(col))
        .map(col => place(col).solve)
        .sum
  }
}

object Queens {
  def main(args: Array[String]) = {
    val from = if (args.length > 0) args(0).toInt else 8
    val to = if (args.length > 1) args(1).toInt else from
    for (size <- from to to) {
      val start = Instant.now()
      val result = new Board(size).solve
      val end = Instant.now()
      val duration = Duration.between(start, end)
      val seconds = duration.get(SECONDS) + duration.get(NANOS)/1000000000.0
    println(size + "," + result + "," + seconds)
    }
  }
}

