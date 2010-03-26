// $Id$
// Copyright 2008 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2008-12-24

def now = new java.util.Date().getTime()

val size = args(0).toInt
val board = new Board(size)
val start = now
if (board.solve) {
  val elapsed = now - start
  println(board.toString)
  println("" + elapsed/1000 + " seconds.");
}

