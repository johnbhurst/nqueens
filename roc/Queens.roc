# Copyright 2026 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2026-11-07

app [main!] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.26.0/GddgvsGjiNXrHFW6au5i5dUDbTs8FinQdrgE2Gqmw53t.tar.zst" }

import pf.Monotonic
import pf.OsStr
import pf.Stdout

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
        cols = List.from_iter((0..<board.size).iter())
        List.fold(cols, 0, |count, col| {
            if ok(board, col) count + solve(place(board, col))
            else count
        })
    }
}

parse_int : OsStr -> I32
parse_int = |os_str| {
    str = match os_str.to_str_try() {
        Ok(s) => s
        Err(_) => crash "Invalid integer argument"
    }
    match I32.from_str(str) {
        Ok(n) => n
        Err(_) => crash "Invalid integer argument"
    }
}

main! = |args| {
    (from, to) = match args {
        [a, b] => (parse_int(a), parse_int(b))
        [a] => {
            n = parse_int(a)
            (n, n)
        }
        [] => (8, 8)
        _ => crash "Invalid arguments"
    }

    for size in from..=to {
        start = Monotonic.now!()
        solutions = solve(new(size))
        elapsed_ms = start.elapsed!().to_millis()
        elapsed_s = elapsed_ms.to_f64() / 1000.0
        _ = Stdout.line!("${size.to_str()},${solutions.to_str()},${elapsed_s.to_str()}")
    }
    Ok({})
}
