# # Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-12-22

import datetime
import sys

class Board(object):
    """A puzzle board"""
    def __init__(self, size, placed=0, col=0, diag1=0, diag2=0):
        self.size = size
        self.placed = placed
        self.col = col
        self.diag1 = diag1
        self.diag2 = diag2

    def place(self, row, col):
        """Place a queen at (row, col)."""
        return Board(
            self.size,
            self.placed + 1,
            self.col | (1 << col),
            self.diag1 | (1 << row + col),
            self.diag2 | (1 << row - col + self.size - 1)
        )

    def is_ok(self, row, col):
        """Return true if position (row, col) is not currently attacked."""
        return (self.col & (1 << col) == 0 and
                self.diag1 & (1 << row+col) == 0 and
                self.diag2 & (1 << row-col+self.size-1) == 0)

    def solve(self):
        """Return the number of solutions possible on the board as configured."""
        if self.placed == self.size:
            return 1
        else:
            row = self.placed
            result = 0
            for col in range(self.size):
                if self.is_ok(row, col):
                    result += self.place(row, col).solve()
            return result

FIRST = int(sys.argv[1])
LAST = int(sys.argv[2])

for size in range(FIRST, LAST+1):
    start = datetime.datetime.now()
    count = Board(size).solve()
    end = datetime.datetime.now()
    diff = end - start
    print "Board size {} has {} solutions. Calculated in {} seconds." \
      .format(size, count, diff.total_seconds())
