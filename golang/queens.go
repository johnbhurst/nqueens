// Copyright 2016 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2016-06-12

package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

type Board struct {
	size int
	pos []int
	col []bool
	diag1 []bool
	diag2 []bool
}

func New(size int) *Board {
	return &Board{
		size: size,
		pos: make([]int, size),
		col: make([]bool, size),
		diag1: make([]bool, 2*size-1),
		diag2: make([]bool, 2*size-1) }
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

func (this *Board) Print() {
	fmt.Printf("\u250F" + strings.Join(strings.Split(strings.Repeat("\u2501", this.size), ""), "\u2533") + "\u2513" + "\n")
	for i, pos := range this.pos {
		if i > 0 {
			fmt.Printf("\u2523" + strings.Join(strings.Split(strings.Repeat("\u2501", this.size), ""), "\u254B") + "\u252B" + "\n")
		}
		for j := 0; j < pos; j++ {
			fmt.Printf("\u2503 ")
		}
		fmt.Printf("\u2503\u2655") // Queen
		for j := pos+1; j < this.size; j++ {
			fmt.Printf("\u2503 ")
		}
		fmt.Printf("\u2503\n")
	}
	fmt.Printf("\u2517" + strings.Join(strings.Split(strings.Repeat("\u2501", this.size), ""), "\u253B") + "\u251B" + "\n")
}

func main() {
	size, _ := strconv.Atoi(os.Args[1])
	start := time.Now()
	board := New(size)
	row := 0
	col := 0
	for row < size {
		if board.Ok(row, col) {
			board.Place(row, col)
			row++
			col = 0
		} else {
			col++
			for col == size {
				row--
				col = board.Remove(row) + 1
			}
		}
	}
	seconds := time.Since(start) / time.Second
	board.Print()
	fmt.Printf("Duration: %d seconds\n", seconds)
}
