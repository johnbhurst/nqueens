import java.util.Date;
// $Id: Queens.java 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

public class Queens {
  public static void main(String[] args) {
    if (args.length == 0) {
      System.err.println("I need a number.");
      System.exit(-1);
    }
    int size = Integer.parseInt(args[0]);
    Board b = new Board(size);
    long start = new Date().getTime();
    if (b.solve()) {
      long elapsed = new Date().getTime() - start;
      for (int i = 0; i < size; i++) {
        int col = b.getCol(i);
        for (int j = 0; j < col; j++) {
          System.out.print(" ");
        }
        System.out.println("*");
      }
      System.out.println("" + elapsed/1000 + " seconds.");
    }
  }
}

