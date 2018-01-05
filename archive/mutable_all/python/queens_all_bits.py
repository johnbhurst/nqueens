# Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-09-19

import datetime
import sys

class Board:
    def __init__(self, size):
        self.size = size
        self.pos = [0] * size
        self.col = 0
        self.diag1 = 0
        self.diag2 = 0

    def place(self, row, col):
        self.pos[row] = col
        self.col |= (1 << col)
        self.diag1 |= (1 << row+col)
        self.diag2 |= (1 << row-col+self.size-1)

    def remove(self, row):
        col = self.pos[row]
        self.col &= ~(1 << col)
        self.diag1 &= ~(1 << row+col)
        self.diag2 &= ~(1 << row-col+self.size-1)
        return col

    def ok(self, row, col):
        return (self.col & (1 << col) == 0 and
                self.diag1 & (1 << row+col) == 0 and
                self.diag2 & (1 << row-col+self.size-1) == 0)

    def backtrack(self, row, col):
        while col == self.size and row >= 0:
            row -= 1
            if row >= 0:
                col = self.remove(row) + 1
        return (row, col)

    def solve(self):
        row = 0
        col = 0
        count = 0
        while row >= 0:
            if self.ok(row, col):
                self.place(row, col)
                if row < self.size-1:
                    row += 1
                    col = 0
                else:
                    count += 1
                    col = self.remove(row) + 1
                    if col == self.size:
                        row, col = self.backtrack(row, col)
            else:
                col += 1
                if col == self.size:
                    row, col = self.backtrack(row, col)
        return count


first = int(sys.argv[1])
last = int(sys.argv[2])

for size in range(first, last+1):
    start = datetime.datetime.now()
    board = Board(size)
    count = board.solve()
    end = datetime.datetime.now()
    diff = end - start
    print "Board size {} has {} solutions. Calculated in {} seconds.".format(size, count, diff.total_seconds())
