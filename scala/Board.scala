// $Id$
// Copyright 2008 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2008-12-24

class Board(s: Int) {
  require(s >= 4)
  val size = s
  private val pos = new Array[Int](size)
  private val col = new Array[Boolean](size)
  private val diag1 = new Array[Boolean](2 * size + 1)
  private val diag2 = new Array[Boolean](2 * size + 1)
  for (i <- 0 until size) pos(i) = -1

  def place(row: Int, col: Int) = {
    pos(row) = col
    this.col(col) = true
    diag1(col - row + size) = true
    diag2(col + row) = true
  }

  def unplace(row: Int) = {
    val col = pos(row)
    pos(row) = -1
    this.col(col) = false
    diag1(col - row + size) = false
    diag2(col + row) = false
    col
  }

  def isOk(row: Int, col: Int) =
    !(this.col(col) || diag1(col - row + size) || diag2(col + row))

  def solve = {
    var row = 0
    var col = 0
    while ((0 until size).contains(row)) {
      while (col < size && !isOk(row, col)) {
        col += 1
      }
      if (col < size) {
        place(row, col)
        row += 1
        col = 0
      }
      else {
        row -= 1
        if (row >= 0) {
          col = unplace(row) + 1
        }
      }
    }
    row == size
  }

  override def toString = (
    for (row <- 0 until size)
      yield " " * pos(row) + "*"
    ).mkString("\n")
}

