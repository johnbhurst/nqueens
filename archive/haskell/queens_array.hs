import Data.Array

data Board = Board {
  size :: Int,
  rows :: Int,
  pos :: Array Int Int,
	cols :: Array Int Bool,
	diag1 :: Array Int Bool,
	diag2 :: Array Int Bool
} deriving (Show)

makeFalse :: Int -> Array Int Bool
makeFalse n = array (1,n) [(i, False) | i <- [1..n]]

start :: Int -> Board
start n = Board {
  size = n, 
  rows = 0, 
  pos = array (1, n) [(i, 0) | i <- [1..n]],
  cols = makeFalse n,
  diag1 = makeFalse (2 * n),
  diag2 = makeFalse (2 * n)
}

ok :: Board -> Int -> Bool
ok (Board {size = size, rows = rows, pos = pos, cols = cols, diag1 = diag1, diag2 = diag2}) j = 
	not (cols!j || diag1!(j-(rows+1)+size) || diag2!(rows+1+j))

nextCols :: Board -> [Int]
nextCols board@(Board {size = size, rows = rows}) = filter (ok board) [1..size] 

place :: Board -> Int -> Board
place (Board {size = size, rows = rows, pos = pos, cols = cols, diag1 = diag1, diag2 = diag2}) j =
	Board {
		size = size,
		rows = rows + 1,
		pos = array (1, size) ([(i, pos!i) | i <- [1..rows]] ++ [(rows+1, j)] ++ [(i, 0) | i <- [rows+2..size]]),
		cols = array (1, size) [(i, cols!i || i == j) | i <- [1..size]],
		diag1 = array (1, 2 * size) [(i, diag1!i || i == j - (rows + 1) + size) | i <- [1..(2 * size)]],
		diag2 = array (1, 2 * size) [(i, diag2!i || i == (rows + 1) + j) | i <- [1..(2 * size)]]
	}

nextBoards :: [Board] -> [Board]
nextBoards boards = foldl1 (++) allmap
  where bc board = (board, nextCols board)
  	bcps = map bc boards
  	pl (board, cols) = map (place board) cols
  	allmap = map pl bcps

solve :: Int -> [Board]
solve n = head $ drop n $ iterate nextBoards [start n]

solve1 :: Int -> Board
solve1 n = head $ solve n

toString :: Board -> String
toString (Board {size = size, pos = pos}) = unlines $ map f [pos!i | i <- [1..size]]
  where f n = (replicate (n-1) ' ') ++ "*"