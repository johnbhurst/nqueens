import Data.Bits

data Board = Board {
  size :: Int,
  rows :: Int,
  pos :: [Int],
  cols :: Integer,
  diag1 :: Integer,
  diag2 :: Integer
} deriving (Show)

-- Creates a n x n empty board to start solving the problem.
start :: Int -> Board
start n = Board {
  size = n, 
  rows = 0, 
  pos = [],
  cols = 0 :: Integer,
  diag1 = 0 :: Integer,
  diag2 = 0 :: Integer
}

-- Tells whether a queen may be placed on the next row in the given column.
ok :: Board -> Int -> Bool
ok (Board {size = size, rows = rows, cols = cols, diag1 = diag1, diag2 = diag2}) j = 
  not ((testBit cols j) || (testBit diag1 (j-(rows+1)+size)) || (testBit diag2 (rows+1+j)))

-- Returns the columns that a queen may be placed in on the next row.
nextCols :: Board -> [Int]
nextCols board@(Board {size = size}) = filter (ok board) [1..size]

-- Returns the board resulting from placing a queen on the next row in the given column.
place :: Board -> Int -> Board
place (Board {size = size, rows = rows, pos = pos, cols = cols, diag1 = diag1, diag2 = diag2}) j =
  Board {
    size = size,
    rows = rows + 1,
    pos = j : pos,
    cols = setBit cols j,
    diag1 = setBit diag1 (j - (rows + 1) + size),
    diag2 = setBit diag2 (rows + 1 + j)
  }

-- Returns all the boards possible from the current board by placing a queen on the next row.
placeNextCols :: Board -> [Board]
placeNextCols board = map (place board) (nextCols board)

-- Returns all the boards possible from a list of current boards.
nextBoards :: [Board] -> [Board]
nextBoards boards = foldr1 (++) $ map placeNextCols boards

-- Returns all the solutions for a puzzle of size n.
solve :: Int -> [Board]
solve n = head $ drop n $ iterate nextBoards [start n]

-- Returns the first solution for a puzzle of size n.
solve1 :: Int -> Board
solve1 n = head $ solve n

-- Returns a string showing the board positions.
toString :: Board -> String
toString (Board {pos = pos}) = unlines $ map f pos
  where f n = (replicate (n-1) ' ') ++ "*"

