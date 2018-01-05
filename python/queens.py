# # Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-12-22

from datetime import datetime
from sys import argv

class Board(object):
    """A puzzle board"""
    def __init__(self, size, row=0, cols=0, diags1=0, diags2=0):
        self.size = size      # size of board
        self.row = row        # current row placed
        self.cols = cols      # bits indicating occupied column
        self.diags1 = diags1  # bits indicating occupied diagonal
        self.diags2 = diags2  # bits indicating occupied diagonal

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
        return 1 if self.row == self.size else sum(
            [self.place(col).solve() for col in range(self.size) if self.is_ok(col)]
        )

FIRST = int(argv[1]) if len(argv) >= 2 else 8
LAST = int(argv[2]) if len(argv) >= 3 else FIRST

for size in range(FIRST, LAST+1):
    start = datetime.now()
    count = Board(size).solve()
    end = datetime.now()
    diff = end - start
    print("Board size {} has {} solutions. Calculated in {} seconds." \
      .format(size, count, diff.total_seconds()))
