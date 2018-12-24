// Copyright 2016 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-18

package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

type Board struct {
	size   int
  row    int
	cols   int // 64-bits
	diags1 int
	diags2 int
}

func New(size int) Board {
	return Board{size: size}
}

func Ok(board Board, col int) bool {
  return board.cols & (1 << uint(col)) == 0 &&
    board.diags1 & (1 << uint(board.row + col)) == 0 &&
    board.diags2 & (1 << uint(board.row - col + board.size - 1)) == 0
}

func Place(board Board, col int) Board {
  return Board{
    size: board.size,
    row: board.row + 1,
    cols: board.cols | (1 << uint(col)),
    diags1: board.diags1 | (1 << uint(board.row + col)),
    diags2: board.diags2 | (1 << uint(board.row - col + board.size - 1))}
}

func Solve(board Board) int {
  if board.row == board.size {
    return 1
  } else {
    result := 0
    for col := 0; col < board.size; col++ {
      if Ok(board, col) {
        result += Solve(Place(board, col))
      }
    }
    return result
  }
}

func SolveForCol(board Board, col int, channel chan int) {
   channel <- Solve(Place(board, col))
}

func SolveSize(size int) int {
  chans := make([]chan int, size)
  board := New(size)
  for col := 0; col < size; col++ {
    chans[col] = make(chan int)
    go SolveForCol(board, col, chans[col])
  }
  result := 0
  for col := 0; col < size; col++ {
    result += <-chans[col]
  }
  return result
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
		count := SolveSize(size)
		duration := time.Now().Sub(start).Seconds()
		fmt.Printf("%d,%d,%0.3f\n", size, count, duration)
	}
}
