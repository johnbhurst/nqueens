# Copyright 2026 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2026-11-07

Board := { size: I32, row: I32, cols: I32, diags1: I32, diags2: I32 }

new : I32 -> Board
new = |size| Board.{ size: size, row: 0, cols: 0, diags1: 0, diags2: 0 }

ok : Board, I32 -> Bool
ok = |board, col| {
    board.cols.bitwise_and(I32.shl_wrap(1, I32.to_u8_wrap(col))) == 0 and
    board.diags1.bitwise_and(I32.shl_wrap(1, I32.to_u8_wrap(board.row + col))) == 0 and
    board.diags2.bitwise_and(I32.shl_wrap(1, I32.to_u8_wrap(board.size + board.row - col - 1))) == 0
}

place : Board, I32 -> Board
place = |board, col| Board.{
    size: board.size,
    row: board.row + 1,
    cols: board.cols.bitwise_or(I32.shl_wrap(1, I32.to_u8_wrap(col))),
    diags1: board.diags1.bitwise_or(I32.shl_wrap(1, I32.to_u8_wrap(board.row + col))),
    diags2: board.diags2.bitwise_or(I32.shl_wrap(1, I32.to_u8_wrap(board.size + board.row - col - 1)))
}

solve : Board => U32
solve = |board| {
    if board.row == board.size 1
    else {
        next_cols = List.from_iter((0..<board.size).iter()).keep_if(|col| ok(board, col))
        next_boards = next_cols.map(|col| place(board, col))
        List.fold(next_boards, 0, |count, next_board| count + solve(next_board))
    }
}

main! = |args| {
    (from, to) = match args {
        [a, b] => (I32.from_str(a)?, I32.from_str(b)?)
        [a] => {
            n = I32.from_str(a)?
            (n, n)
        }
        [] => (8, 8)
        _ => crash "Invalid arguments"
    }

    for size in from..=to {
        board = new(size)
        solutions = solve(board)
        echo!("${size.to_str()},${solutions.to_str()}\n")
    }
    Ok({})
}
