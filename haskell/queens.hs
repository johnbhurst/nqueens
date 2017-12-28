-- Copyright 2017 John Hurst
-- John Hurst (john.b.hurst@gmail.com)
-- 2017-12-25

import Data.Bits
import System.CPUTime
import System.Environment
import Text.Printf

data Board = Board {
  size :: Int,
  placed :: Int,
  cols :: Int,
  diag1 :: Int,
  diag2 :: Int
}

-- Create empty n x n board.
new :: Int -> Board
new n = Board {
  size = n,
  placed = 0,
  cols = 0,
  diag1 = 0,
  diag2 = 0
}

-- Tells whether a queen may be placed on the next row in the given column.
ok :: Board -> Int -> Bool
ok (Board {size = size, placed = row, cols = cols, diag1 = diag1, diag2 = diag2}) col =
  not ((testBit cols col) ||
       (testBit diag1 (row + col)) ||
       (testBit diag2 (row - col + size - 1)))

-- Returns the board resulting from placing a queen on the next row in the given column.
place :: Board -> Int -> Board
place (Board {size = size, placed = row, cols = cols, diag1 = diag1, diag2 = diag2}) col =
  Board {
    size = size,
    placed = row + 1,
    cols = setBit cols col,
    diag1 = setBit diag1 (row + col),
    diag2 = setBit diag2 (row - col + size - 1)
  }

-- Returns the number of solutions for the given (partially filled) board.
solve :: Board -> Int
solve board@(Board {size = size, placed = placed, cols = cols, diag1 = diag1, diag2 = diag2}) =
  if placed == size then 1
  else sum $ map solve boards
    where boards = map (place board) cols
          cols = filter (ok board) [0..size-1]

-- Solves board of given size and prints result and time to compute.
timeSolution :: Int -> IO ()
timeSolution size = do
  start <- getCPUTime
  let result = solve $ new size
  printf "Board size %d has %d solutions. " size result
  end <- getCPUTime
  let diff = quot (end - start) (10^9)
  printf "Calculated in: %dms\n" diff
  return ()

-- Returns the range of boards to solve, derived from command-line arguments.
sizes :: [String] -> [Int]
sizes args = [start..end]
  where start = if length args < 1 then 8 else read (head args) :: Int
        end = if length args < 2 then start else read (head (tail args)) :: Int

main = do
  args <- getArgs
  mapM timeSolution $ sizes args
