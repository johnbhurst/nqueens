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
	size    int
	pos     []int
	col     []bool
	diag1   []bool
	diag2   []bool
	channel chan int
}

func New(size int, channel chan int) *Board {
	return &Board{
		size:    size,
		pos:     make([]int, size),
		col:     make([]bool, size),
		diag1:   make([]bool, 2*size-1),
		diag2:   make([]bool, 2*size-1),
		channel: channel}
}

func (this *Board) Place(row, col int) {
	this.pos[row] = col
	this.col[col] = true
	this.diag1[row+col] = true
	this.diag2[row-col+this.size-1] = true
}

func (this *Board) Remove(row int) int {
	col := this.pos[row]
	this.col[col] = false
	this.diag1[row+col] = false
	this.diag2[row-col+this.size-1] = false
	return col
}

func (this *Board) Ok(row, col int) bool {
	return !this.col[col] && !this.diag1[row+col] && !this.diag2[row-col+this.size-1]
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

func (this *Board) SolveForCol(col int) {
	this.Place(0, col)
	row := 1
	count := 0
	col = 0

	for row > 0 {
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
	this.channel <- count
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
		chans := make([]chan int, size)
		for col := 0; col < size; col++ {
			chans[col] = make(chan int)
			b := New(size, chans[col])
			go b.SolveForCol(col)
		}
		count := 0
		for col := 0; col < size; col++ {
			count += <-chans[col]
		}
		duration := time.Now().Sub(start)
		fmt.Printf("Board size %d has %d solutions. Calculated in %v.\n", size, count, duration)
	}
}
