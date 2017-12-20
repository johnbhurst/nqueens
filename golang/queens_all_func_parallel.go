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
  placed int
	col    int // 64-bits
	diag1  int
	diag2  int
}

func New(size int) Board {
	return Board{size: size}
}

func Place(board Board, row, col int) Board {
  return Board{
    size: board.size,
    placed: board.placed + 1,
    col: board.col | (1 << uint(col)),
    diag1: board.diag1 | (1 << uint(row+col)),
    diag2: board.diag2 | (1 << uint(row-col+board.size-1))}
}

func Ok(board Board, row, col int) bool {
	return board.col & (1 << uint(col)) == 0 &&
		board.diag1 & (1 << uint(row+col)) == 0 &&
    board.diag2 & (1 << uint(row-col+board.size-1)) == 0
  // fmt.Printf("Ok((%d, %d, %d, %d, %d), %d, %d): %v\n", board.size, board.placed, board.col, board.diag1, board.diag2, row, col, result)
  // return result
}

func Solve(board Board) int {
  if board.placed == board.size {
    return 1
  } else {
    row := board.placed
    result := 0
    for col := 0; col < board.size; col++ {
      if Ok(board, row, col) {
        result += Solve(Place(board, row, col))
      }
    }
    return result
  }
}

func SolveForCol(board Board, col int, channel chan int) {
   channel <- Solve(Place(board, 0, col))
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
		duration := time.Now().Sub(start)
		fmt.Printf("Board size %d has %d solutions. Calculated in %v.\n", size, count, duration)
	}
}
