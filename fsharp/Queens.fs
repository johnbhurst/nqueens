// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-28

open System
open System.Diagnostics

type Board = {
    Size: int;
    Row: int;
    Cols: int;
    Diags1: int;
    Diags2: int;
}

let empty size = {Size = size; Row = 0; Cols = 0; Diags1 = 0; Diags2 = 0}

let ok board col =
    ((board.Cols &&& (1 <<< col)) |||
     (board.Diags1 &&& (1 <<< board.Row + col)) |||
     (board.Diags2 &&& (1 <<< board.Row - col + board.Size - 1))) = 0

let place board col = {
    board with 
        Row = board.Row + 1 ; 
        Cols = board.Cols ||| (1 <<< col);
        Diags1 = board.Diags1 ||| (1 <<< board.Row + col);
        Diags2 = board.Diags2 ||| (1 <<< board.Row - col + board.Size - 1)
}

let rec solve board = 
    match board with
    | _ when board.Row = board.Size -> 1
    | _ -> seq { 0 .. board.Size - 1 }
        |> Seq.filter (ok board)
        |> Seq.map (place board)
        |> Seq.map solve
        |> Seq.sum

[<EntryPoint>]
let main argv =
    let (size0, size1) = 
        match argv with 
        | _ when argv.Length = 0 -> (8, 8)
        | _ when argv.Length = 1 -> (int argv.[0], int argv.[0])
        | _ -> (int argv.[0], int argv.[1])

    for size = size0 to size1 do
        let watch = Stopwatch.StartNew()
        let count = size |> empty |> solve
        watch.Stop()
        let ts = watch.Elapsed
        printfn "Board size %d has %d solutions.  Calculated in %02d:%02d:%02d.%03d." size count ts.Hours ts.Minutes ts.Seconds ts.Milliseconds
    0
