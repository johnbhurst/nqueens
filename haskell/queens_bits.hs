import Data.Bits

data Board = Board {
  size :: Int,
  rows :: Int,
  pos :: [Int],
  cols :: Integer,
  diag1 :: Integer,
  diag2 :: Integer
} deriving (Show)

start :: Int -> Board
start n = Board {
  size = n, 
  rows = 0, 
  pos = [],
  cols = 0 :: Integer,
  diag1 = 0 :: Integer,
  diag2 = 0 :: Integer
}

ok :: Board -> Int -> Bool
ok (Board {size = size, rows = rows, cols = cols, diag1 = diag1, diag2 = diag2}) j = 
  not ((testBit cols j) || (testBit diag1 (j-(rows+1)+size)) || (testBit diag2 (rows+1+j)))

nextCols :: Board -> [Int]
nextCols board@(Board {size = size}) = filter (ok board) [1..size]

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

nextBoards :: [Board] -> [Board]
nextBoards boards = foldr1 (++) allmap
  where bc board = (board, nextCols board)
        bcps = map bc boards
        pl (board, cols) = map (place board) cols
        allmap = map pl bcps

solve :: Int -> [Board]
solve n = head $ drop n $ iterate nextBoards [start n]

solve1 :: Int -> Board
solve1 n = head $ solve n

toString :: Board -> String
toString (Board {pos = pos}) = unlines $ map f pos
  where f n = (replicate (n-1) ' ') ++ "*"

