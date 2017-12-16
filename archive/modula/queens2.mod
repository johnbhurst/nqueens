MODULE Queens2;
(*****************************************************************************)
(* Queens2       : N queens problem.  Faster solution.                       *)
(* Author        : John Hurst                                                *)
(* Date          : 25/03/88                                                  *)
(* Input         : N, the number of queens to solve the problem for.         *)
(* Output        : An NxN chessboard with N queens placed upon it such that  *)
(*                 none attacks any other.                                   *)
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
    placement = ARRAY rows OF cols;    (* a board setup                      *)
    testarray = ARRAY cols OF BOOLEAN; (* quick check whether a column placed*)


  VAR
    size  : CARDINAL;                  (* board size for this run            *)
    row   : rows;                      (* row variable                       *)
    column: cols;                      (* column variable                    *)
    queens: placement;                 (* the board setup                    *)
    solved: BOOLEAN;                   (* TRUE when finished successfully    *)
    failed: BOOLEAN;                   (* TRUE when finished unsuccessfully  *)
    columnused : testarray;            (* quick check array vertical attacks *)


(* What we'll do is work through the rows, placing queens in each row,       *)
(* ie. selecting a column for each row.  Therefore, there is no              *)
(* possibility of placing more than one queen in any row.  The OK            *)
(* function thus has to check only for more than one queen in a              *)
(* given column, and for diagonal attacks.                                   *)


PROCEDURE Ok() : BOOLEAN;              (* latest queen safe from others?     *)
  VAR
    r1, r2 : rows;
    c1, c2 : cols;
    OkResult: BOOLEAN;

  BEGIN
    OkResult := TRUE;
    r1 := row;
    c1 := queens[row];

    r2 := 1;
    WHILE (r2 < row) AND OkResult DO   (* look at all the other queens       *)
      c2 := queens[r2];

      IF ABS(INTEGER(r1)-INTEGER(r2)) = ABS(INTEGER(c1)-INTEGER(c2))
        THEN OkResult := FALSE         (* diagonal attack                    *)
      END;

      INC(r2);

    END;
    RETURN OkResult;
  END Ok;



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
    WriteString('No solution found to problem. ');
    WriteLn;

  END WriteFailed;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN                                  (* MAIN                               *)

  WriteString('What size chessboard to solve for ? ');
  ReadCardinal(size);


  FOR column := 1 TO size DO           (* initialise test array              *)
    columnused[column] := FALSE;
  END;

  row := 1;
  column := 1;
  solved := FALSE;
  failed := FALSE;


  WHILE (row <= size) AND  NOT (solved) AND NOT (failed) DO

    queens[row] := column;             (* can we place a queen here ?        *)
    IF (NOT columnused[column]) AND Ok() THEN
      columnused[column] := TRUE;      (* this queen is OK (for the moment)  *)
      IF row < size THEN               (* check whether problem solved       *)
        INC(row);                      (* next row if there are any more     *)
        column := 1;
      ELSE
        WriteSolution;                 (* ... or else we've done it          *)
      END;
    ELSE                               (* this queen cannot be placed here   *)
      IF column < size THEN
        INC(column);                   (* try the next column                *)
      ELSE                             (* otherwise backtrack some rows      *)
        WHILE (queens[row] = size) AND (row > 1) DO
          DEC(row, 1);
          columnused[queens[row]] := FALSE;
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

END Queens2.

