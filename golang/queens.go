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

var rows []int

func Place(row, col int) {
	rows[row] = col
}

func Remove(row int) int {
	result := rows[row]
	rows[row] = -1
	return result
}

func Ok(row, col int) bool {
	for i := range rows {
		if i != row && rows[i] != -1 && rows[i] == col {
			return false
		}
		if i != row && rows[i] != -1 && i - rows[i] == row - col {
			return false
		}
		if i != row && rows[i] != -1 && i + rows[i] == row + col {
			return false
		}
	}
	return true
}

func Print() {
	for i := range rows {
		fmt.Printf("%s*\n", strings.Repeat(" ", rows[i]))
	}
}

func main() {
	size, _ := strconv.Atoi(os.Args[1])
	start := time.Now()
	rows = make([]int, size)
	for i := range rows {
		rows[i] = -1
	}
	row := 0
	col := 0
	for row < len(rows) {
		if Ok(row, col) {
			Place(row, col)
			row++
			col = 0
		} else {
			col++
			for col == len(rows) {
				row--
				col = Remove(row) + 1
			}
		}
	}
	seconds := time.Since(start) / time.Second
	Print()
	fmt.Printf("Duration: %d seconds\n", seconds)
}
