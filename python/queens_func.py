# # Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-12-22

import datetime
import sys

class Board(object):
    """A puzzle board"""
    def __init__(self, size, row=0, cols=0, diags1=0, diags2=0):
        self.size = size
        self.row = row
        self.cols = cols
        self.diags1 = diags1
        self.diags2 = diags2

    def place(self, col):
        """Place a queen at (current row, given col)."""
        return Board(
            self.size,
            self.row + 1,
            self.cols | (1 << col),
            self.diags1 | (1 << self.row + col),
            self.diags2 | (1 << self.row - col + self.size - 1)
        )

    def is_ok(self, col):
        """Return true if position (current row, given col) is not currently attacked."""
        return (self.cols & (1 << col) == 0 and
                self.diags1 & (1 << self.row + col) == 0 and
                self.diags2 & (1 << self.row - col + self.size - 1) == 0)

    def solve(self):
        """Return the number of solutions possible on the board as configured."""
        if self.row == self.size:
            return 1
        else:
            result = 0
            for col in range(self.size):
                if self.is_ok(col):
                    result += self.place(col).solve()
            return result

FIRST = int(sys.argv[1])
LAST = int(sys.argv[2])

for size in range(FIRST, LAST+1):
    start = datetime.datetime.now()
    count = Board(size).solve()
    end = datetime.datetime.now()
    diff = end - start
    print("Board size {} has {} solutions. Calculated in {} seconds." \
      .format(size, count, diff.total_seconds()))
