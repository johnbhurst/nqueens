import Data.Array
import Data.Bits

data Board = Board {
  size :: Int,
  rows :: Int,
  pos :: Array Int Int,
	cols :: Integer,
	diag1 :: Integer,
	diag2 :: Integer
} deriving (Show)

start :: Int -> Board
start n = Board {
  size = n, 
  rows = 0, 
  pos = array (1, n) [(i, 0) | i <- [1..n]],
  cols = 0 :: Integer,
  diag1 = 0 :: Integer,
  diag2 = 0 :: Integer
}

ok :: Board -> Int -> Int -> Bool
ok (Board {size = size, rows = rows, pos = pos, cols = cols, diag1 = diag1, diag2 = diag2}) i j = 
	not ((testBit cols j) || (testBit diag1 (j-i+size)) || (testBit diag2 (i+j)))

nextCols :: Board -> [Int]
nextCols board@(Board {size = size, rows = rows}) = filter okNext [1..size] 
  where okNext = ok board (rows+1)

place :: Board -> Int -> Board
place (Board {size = size, rows = rows, pos = pos, cols = cols, diag1 = diag1, diag2 = diag2}) j =
	Board {
		size = size,
		rows = rows + 1,
		pos = array (1, size) ([(i, pos!i) | i <- [1..rows]] ++ [(rows+1, j)] ++ [(i, 0) | i <- [rows+2..size]]),
		cols = setBit cols j,
		diag1 = setBit diag1 (j - (rows + 1) + size),
		diag2 = setBit diag2 (rows + 1 + j)
	}

nextBoards :: [Board] -> [Board]
nextBoards boards = foldl1 (++) allmap
  where bc board = (board, nextCols board)
  	bcps = map bc boards
  	pl (board, cols) = map p1 cols where p1 = place board
  	allmap = map pl bcps

solve :: Int -> [Board]
solve n = last $ take (n+1) $ iterate nextBoards [start n]

solve1 :: Int -> Board
solve1 n = head $ solve n

toString :: Board -> String
toString (Board {size = size, pos = pos}) = unlines $ map f [pos!i | i <- [1..size]]
  where f n = (replicate (n-1) ' ') ++ "*"

