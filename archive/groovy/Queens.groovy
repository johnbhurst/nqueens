// $Id: Queens.groovy 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

if (args.length == 0) {
  println("I need a number.")
  System.exit(-1)
}
size = Integer.parseInt(args[0])
Board b = new Board(size)
long start = new Date().getTime()
if (b.solve()) {
  long elapsed = new Date().getTime() - start
  for (i in 0..<size) {
    int col = b.getCol(i)
    for (j in 0..<col) {
      print(" ")
    }
    println("*")
  }
  println("" + elapsed/1000 + " seconds.")
}


