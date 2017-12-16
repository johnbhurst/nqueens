PROGRAM Queens3;
(*****************************************************************************)
(* Queens3       : N queens problem.  Even Faster solution.                  *)
(*                 Turbo Pascal Version Adapted from original Modula-2/86.   *)
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

USES Crt;

  CONST
    maxsize =  20;                     (* upper limit on board size          *)
    maxsiz2 =  40;
    maxsim1 =  19;
    maxsi1m = -19;


  TYPE
    rows      = 1..maxsize;            (* row index                          *)
    cols      = 1..maxsize;            (* column index                       *)
    diag1     = 2..maxsiz2;            (* diagonal index 1                   *)
    diag2     = maxsi1m..maxsim1;      (* diagonal index 2                   *)
    placement = ARRAY [rows] OF cols;      (* a board setup                      *)
    testcols  = ARRAY [cols] OF BOOLEAN;   (* quick check whether a column pl*)
    testdiag1 = ARRAY [diag1] OF BOOLEAN;  (* quick check whether a diag plac*)
    testdiag2 = ARRAY [diag2] OF BOOLEAN;  (* quick check whether a diag plac*)


  VAR
    size       : INTEGER;              (* board size for this run            *)
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
    DummyCode  : INTEGER;

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
    Write('Solution found : ');
    WriteLn;
    WriteLn;

    Write('   Ú');                     (* write out the top line             *)
    FOR column := 1 TO size-1 DO
      Write('ÄÄÄÂ');

    Write('ÄÄÄ¿');
    WriteLn;

    FOR row := 1 TO size DO BEGIN      (* write out each row                 *)
      Write('   ³');
      FOR column := 1 TO queens[row]-1 DO
        Write('   ³');

      Write(' Q ³');
      FOR column := queens[row]+1 TO size DO
        Write('   ³');

      WriteLn;
      IF row < size THEN BEGIN
        Write('   Ã');
        FOR column := 1 TO size-1 DO
          Write('ÄÄÄÅ');

        Write('ÄÄÄ´');
        WriteLn;
        END
      ELSE BEGIN
        Write('   À');                 (* bottom row                         *)
        FOR column := 1 TO size-1 DO
          Write('ÄÄÄÁ');

        Write('ÄÄÄÙ');
        WriteLn;
      END;
    END;

    WriteLn;
    WriteLn;
    WriteLn;

  END;


PROCEDURE WriteFailed;                 (* reports our lack of success        *)

  BEGIN

    failed := TRUE;

    WriteLn;
    Write('No solution found to problem. ');
    WriteLn;

  END;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN                                  (* MAIN                               *)

  IF ParamCount = 1 THEN
    Val(ParamStr(1), Size, DummyCode)

  ELSE BEGIN
    Write('What size chessboard to solve for ? ');
    ReadLn(Size);
  END;

  FOR column := 1 TO size DO
    columnused[column] := FALSE;       (* initialise test column array       *)

  FOR diagonal1 := 2 TO 2 * INTEGER(size) DO
    diagused1[diagonal1] := FALSE;     (* initialise test diagonal array 1   *)

  FOR diagonal2 := 1 - INTEGER(size) TO INTEGER(size) - 1 DO
    diagused2[diagonal2] := FALSE;     (* initialise test diagonal array 2   *)


  row := 1;
  column := 1;
  solved := FALSE;
  failed := FALSE;


  WHILE (row <= size) AND  NOT (solved) AND NOT (failed) DO BEGIN

    queens[row] := column;             (* can we place a queen here ?        *)
    IF      (NOT columnused[column])
        AND (NOT diagused1[INTEGER(row) + INTEGER(column)])
        AND (NOT diagused2[INTEGER(row) - INTEGER(column)]) THEN BEGIN
      columnused[column] := TRUE;      (* this queen is OK (for the moment)  *)
      diagused1[INTEGER(row) + INTEGER(column)] := TRUE;
      diagused2[INTEGER(row) - INTEGER(column)] := TRUE;
      IF row < size THEN BEGIN         (* check whether problem solved       *)
        row := row + 1;                (* next row if there are any more     *)
        column := 1;
        END
      ELSE
        WriteSolution                  (* ... or else we've done it          *)
    END
    ELSE                               (* this queen cannot be placed here   *)
      IF column < size THEN
        column := column + 1           (* try the next column                *)
      ELSE BEGIN                       (* otherwise backtrack some rows      *)
        WHILE (queens[row] = size) AND (row > 1) DO BEGIN
          row := row - 1;
          columnused[queens[row]] := FALSE;
          diagused1[INTEGER(row) + INTEGER(queens[row])] := FALSE;
          diagused2[INTEGER(row) - INTEGER(queens[row])] := FALSE;
        END;
        IF queens[row] = size THEN     (* exhausted all the possibilities    *)
          WriteFailed
        ELSE
          column := queens[row] + 1;   (* start from scratch on that column  *)

      END;

  END;                                 (* WHILE                              *)

END.

