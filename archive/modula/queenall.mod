MODULE QueensAll;
(*****************************************************************************)
(* Queens3       : N queens problem.  Even Faster solution.                  *)
(* Author        : John Hurst                                                *)
(* Date          : 25/03/88                                                  *)
(* Input         : N, the number of queens to solve the problem for.         *)
(* Output        : An NxN chessboard with N queens placed upon it such that  *)
(*                 none attacks any other.                                   *)
(*                                                                           *)
(* Version 1 was the basic backtracking algorithm                            *)
(* Version 2 introduced the boolean array for the columns                    *)
(* Version 3 introduced the boolean arrays for the diagonals                 *)
(*                                                                           *)
(*****************************************************************************)
(*                                                                           *)
(* Basic library modules required :                                          *)
(*                                                                           *)

  FROM Terminal
    IMPORT WriteString, WriteLn;
  FROM CardinalIO
    IMPORT ReadCardinal;


  CONST
    maxsize = 20;                      (* upper limit on board size          *)


  TYPE
    rows      = [1..maxsize];          (* row index                          *)
    cols      = [1..maxsize];          (* column index                       *)
    diag1     = [2..2 * maxsize];      (* diagonal index 1                   *)
    diag2     = [1-maxsize..maxsize-1];(* diagonal index 2                   *)
    placement = ARRAY rows OF cols;    (* a board setup                      *)
    testcols  = ARRAY cols OF BOOLEAN; (* quick check whether a column placed*)
    testdiag1 = ARRAY diag1 OF BOOLEAN;(* quick check whether a diag placed  *)
    testdiag2 = ARRAY diag2 OF BOOLEAN;(* quick check whether a diag placed  *)


  VAR
    size       : CARDINAL;             (* board size for this run            *)
    row        : rows;                 (* row variable                       *)
    column     : cols;                 (* column variable                    *)
    diagonal1  : diag1;                (* diagonal type 1 variable           *)
    diagonal2  : diag2;                (* diagonal type 2 variable           *)
    queens     : placement;            (* the board setup                    *)
    solved     : BOOLEAN;              (* TRUE when finished successfully    *)
    failed     : BOOLEAN;              (* TRUE when finished unsuccessfully  *)
    columnused : testcols;             (* quick check array vertical attacks *)
    diagused1  : testdiag1;            (* quick check array diagonal 1       *)
    diagused2  : testdiag2;            (* quick check array diagonal 2       *)

(* What we'll do is work through the rows, placing queens in each row,       *)
(* ie. selecting a column for each row.  Therefore, there is no              *)
(* possibility of placing more than one queen in any row.  The OK            *)
(* function thus has to check only for more than one queen in a              *)
(* given column, and for diagonal attacks.                                   *)


PROCEDURE WriteSolution;               (* writes out the solution board      *)

  VAR
    row: rows;
    column: INTEGER;

  BEGIN

    solved := TRUE;                    (* set solved flag for run            *)

    WriteLn;
    WriteString('Solution found : ');
    WriteLn;
    WriteLn;

    WriteString('   Ú');               (* write out the top line             *)
    FOR column := 1 TO size-1 DO
      WriteString('ÄÄÄÂ');
    END;
    WriteString('ÄÄÄ¿');
    WriteLn;

    FOR row := 1 TO size DO            (* write out each row                 *)
      WriteString('   ³');
      FOR column := 1 TO queens[row]-1 DO
        WriteString('   ³')
      END;
      WriteString(' Q ³');
      FOR column := queens[row]+1 TO size DO
        WriteString('   ³')
      END;
      WriteLn;
      IF row < size THEN
        WriteString('   Ã');
        FOR column := 1 TO size-1 DO
          WriteString('ÄÄÄÅ');
        END;
        WriteString('ÄÄÄ´');
        WriteLn;
      ELSE
        WriteString('   À');           (* bottom row                         *)
        FOR column := 1 TO size-1 DO
          WriteString('ÄÄÄÁ');
        END;
        WriteString('ÄÄÄÙ');
        WriteLn;
      END;
    END;

    WriteLn;
    WriteLn;
    WriteLn;

  END WriteSolution;


PROCEDURE WriteFailed;                 (* reports our lack of success        *)

  BEGIN

    failed := TRUE;

    WriteLn;
    IF solved THEN
      WriteString('No more solutions found to problem. ');
    ELSE
      WriteString('No solution found to problem. ');
    END;
    WriteLn;

  END WriteFailed;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN                                  (* MAIN                               *)

  WriteString('What size chessboard to solve for ? ');
  ReadCardinal(size);


  FOR column := 1 TO size DO
    columnused[column] := FALSE;       (* initialise test column array       *)
  END;
  FOR diagonal1 := 2 TO 2 * INTEGER(size) DO
    diagused1[diagonal1] := FALSE;     (* initialise test diagonal array 1   *)
  END;
  FOR diagonal2 := 1 - INTEGER(size) TO INTEGER(size) - 1 DO
    diagused2[diagonal2] := FALSE;     (* initialise test diagonal array 2   *)
  END;

  row := 1;
  column := 1;
  solved := FALSE;
  failed := FALSE;


(*WHILE (row <= size) AND  NOT (solved) AND NOT (failed) DO *)
  WHILE (row <= size) AND  NOT (failed) DO

    queens[row] := column;             (* can we place a queen here ?        *)
    IF      (NOT columnused[column])
        AND (NOT diagused1[INTEGER(row) + INTEGER(column)])
        AND (NOT diagused2[INTEGER(row) - INTEGER(column)]) THEN
      columnused[column] := TRUE;      (* this queen is OK (for the moment)  *)
      diagused1[INTEGER(row) + INTEGER(column)] := TRUE;
      diagused2[INTEGER(row) - INTEGER(column)] := TRUE;
      IF row < size THEN               (* check whether problem solved       *)
        INC(row);                      (* next row if there are any more     *)
        column := 1;
      ELSE
        WriteSolution;                 (* ... or else we've done it          *)

                                       (* next sequence added for all solns  *)
        columnused[queens[row]] := FALSE;
        diagused1[INTEGER(row) + INTEGER(queens[row])] := FALSE;
        diagused2[INTEGER(row) - INTEGER(queens[row])] := FALSE;
        WHILE (queens[row] = size) AND (row > 1) DO
          DEC(row, 1);
          columnused[queens[row]] := FALSE;
          diagused1[INTEGER(row) + INTEGER(queens[row])] := FALSE;
          diagused2[INTEGER(row) - INTEGER(queens[row])] := FALSE;
        END;
        IF queens[row] = size THEN     (* exhausted all the possibilities    *)
          WriteFailed;
          failed := TRUE;
        ELSE
          column := queens[row] + 1;   (* start from scratch on that column  *)
        END;

      END;
    ELSE                               (* this queen cannot be placed here   *)
      IF column < size THEN
        INC(column);                   (* try the next column                *)
      ELSE                             (* otherwise backtrack some rows      *)
        WHILE (queens[row] = size) AND (row > 1) DO
          DEC(row, 1);
          columnused[queens[row]] := FALSE;
          diagused1[INTEGER(row) + INTEGER(queens[row])] := FALSE;
          diagused2[INTEGER(row) - INTEGER(queens[row])] := FALSE;
        END;
        IF queens[row] = size THEN     (* exhausted all the possibilities    *)
          WriteFailed;
          failed := TRUE;
        ELSE
          column := queens[row] + 1;   (* start from scratch on that column  *)
        END;
      END;
    END;
  END;                                 (* WHILE                              *)

END QueensAll.

