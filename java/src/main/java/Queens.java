// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-09-19

import java.time.Duration;
import java.time.Instant;

public class Queens {

  public static void main(String[] args) {
    if (args.length != 1 && args.length != 2) {
      usage();
    }
    int from = Integer.parseInt(args[0]);
    int to = args.length == 1 ? from : Integer.parseInt(args[1]);
    for (int size = from; size <= to; size++) {
      Instant start = Instant.now();
      Board board = new Board(size);
      int count = board.solve();
      Instant end = Instant.now();
      Duration duration = Duration.between(start, end);
      System.out.println("Board size " + size + " has " + count + " solutions. Calculated in " + duration + ".");
    }
  }

  private static void usage() {
    System.err.println("Usage: Queens fromSize [toSize]");
    System.exit(1);
  }
}
