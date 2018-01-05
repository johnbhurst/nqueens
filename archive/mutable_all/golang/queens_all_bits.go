// Copyright 2016 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-08-12

package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

type Board struct {
	size  int
	pos   []int
	col   int // 64-bits
	diag1 int
	diag2 int
}

func New(size int) *Board {
	return &Board{
		size: size,
		pos:  make([]int, size)}
}

func (this *Board) Place(row, col int) {
	this.pos[row] = col
	this.col |= (1 << uint(col))
	this.diag1 |= (1 << uint(row+col))
	this.diag2 |= (1 << uint(row-col+this.size-1))
}

func (this *Board) Remove(row int) int {
	col := int(this.pos[row])
	this.col &^= (1 << uint(col))
	this.diag1 &^= (1 << uint(row+col))
	this.diag2 &^= (1 << uint(row-col+this.size-1))
	return col
}

func (this *Board) Ok(row, col int) bool {
	return this.col&(1<<uint(col)) == 0 &&
		this.diag1&(1<<uint(row+col)) == 0 &&
		this.diag2&(1<<uint(row-col+this.size-1)) == 0
}

func (this *Board) Backtrack(row, col int) (int, int) {
	for col == this.size && row >= 0 { // backtrack if reached end of row
		row--
		if row >= 0 {
			col = this.Remove(row) + 1
		}
	}
	return row, col
}

func (this *Board) Solve() int {
	row := 0
	col := 0
	count := 0

	for row >= 0 {
		if this.Ok(row, col) {
			this.Place(row, col)
			if row < this.size-1 { // still more rows to fill
				row++
				col = 0
			} else { // filled last row: solution found
				count++
				col = this.Remove(row) + 1
				if col == this.size {
					row, col = this.Backtrack(row, col)
				}
			}
		} else { // cannot place at current position, try next one
			col++
			if col == this.size {
				row, col = this.Backtrack(row, col)
			}
		}
	}
	return count
}

func Usage() {
	fmt.Printf("queens_all size1 [size2]\n")
	os.Exit(1)
}

func main() {
	if len(os.Args) < 2 || len(os.Args) > 3 {
		Usage()
	}
	from, err1 := strconv.Atoi(os.Args[1])
	to, err2 := strconv.Atoi(os.Args[len(os.Args)-1])
	if err1 != nil || err2 != nil || from > to || from < 4 || to < 4 {
		Usage()
	}

	for size := from; size <= to; size++ {
		start := time.Now()
		count := New(size).Solve()
		duration := time.Now().Sub(start)
		fmt.Printf("Board size %d has %d solutions. Calculated in %v.\n", size, count, duration)
	}
}
