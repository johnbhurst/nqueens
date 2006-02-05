MODULE Queens4;
(*****************************************************************************)
(* Queens4       : N queens problem.  Fastest Lexicographical + Display      *)
(* Author        : John Hurst                                                *)
(* Date          : 25/03/88                                                  *)
(* Input         : N, the number of queens to solve the problem for.         *)
(* Output        : An NxN chessboard with N queens placed upon it such that  *)
(*                 none attacks any other.                                   *)
(*                                                                           *)
(* Version 1 was the basic backtracking algorithm                            *)
(* Version 2 introduced the boolean array for the columns                    *)
(* Version 3 introduced the boolean arrays for the diagonals (fastest LEX)   *)
(* Version 4 was created to show graphically what was happening              *)
(*                                                                           *)
(*****************************************************************************)
(*                                                                           *)
(* Basic library modules required :                                          *)
(*                                                                           *)

  FROM Terminal
    IMPORT WriteString, WriteLn;
  FROM CardinalIO
    IMPORT ReadCardinal;
  FROM JHANSI
    IMPORT SM, CO80, HVP;


  CONST
    MaxSize = 20;                      (* upper limit on board size          *)


  TYPE
    Rows      = [1..MaxSize];          (* row index                          *)
    Cols      = [1..MaxSize];          (* column index                       *)
    Diag1     = [2..2 * MaxSize];      (* diagonal index 1                   *)
    Diag2     = [1-MaxSize..MaxSize-1];(* diagonal index 2                   *)
    Placement = ARRAY Rows OF Cols;    (* a board setup                      *)
    TestCols  = ARRAY Cols OF BOOLEAN; (* quick check whether a column placed*)
    TestDiag1 = ARRAY Diag1 OF BOOLEAN;(* quick check whether a diag placed  *)
    TestDiag2 = ARRAY Diag2 OF BOOLEAN;(* quick check whether a diag placed  *)


  VAR
    Size       : CARDINAL;             (* board size for this run            *)
    Row        : Rows;                 (* row variable                       *)
    Column     : Cols;                 (* column variable                    *)
    Diagonal1  : Diag1;                (* diagonal type 1 variable           *)
    Diagonal2  : Diag2;                (* diagonal type 2 variable           *)
    Queens     : Placement;            (* the board setup                    *)
    Solved     : BOOLEAN;              (* TRUE when finished successfully    *)
    Failed     : BOOLEAN;              (* TRUE when finished unsuccessfully  *)
    ColumnUsed : TestCols;             (* quick check array vertical attacks *)
    DiagUsed1  : TestDiag1;            (* quick check array diagonal 1       *)
    DiagUsed2  : TestDiag2;            (* quick check array diagonal 2       *)

(* What we'll do is work through the rows, placing queens in each row,       *)
(* ie. selecting a column for each row.  Therefore, there is no              *)
(* possibility of placing more than one queen in any row.  The OK            *)
(* function thus has to check only for more than one queen in a              *)
(* given column, and for diagonal attacks.                                   *)

PROCEDURE ShowQueen(Row : Rows; Column : Cols);
                                       (* display a queen on the screen      *)
  VAR
    R, C : INTEGER;
  BEGIN
    R := 2 * INTEGER(Row);
    C := 4 * INTEGER(Column) + 2;
    HVP(R, C);
    WriteString('Q');
  END ShowQueen;


PROCEDURE NoshowQueen(Row : Rows; Column : Cols);
                                       (* remove a queen from the screen     *)
  VAR
    R, C : INTEGER;
  BEGIN
    R := 2 * INTEGER(Row);
    C := 4 * INTEGER(Column) + 2;
    HVP(R, C);
    WriteString(' ');
  END NoshowQueen;



PROCEDURE WriteSolution;               (* positions cursor after solution    *)

  BEGIN
    Solved := TRUE;

    HVP(2 * INTEGER(Size) + 2, 1);
    WriteLn;
    WriteString('Solution found : ');
    WriteLn;
    WriteLn;
  END WriteSolution;


PROCEDURE WriteSetup;                  (* writes out the board               *)

  VAR
    Row: Rows;
    Column: INTEGER;

  BEGIN

    WriteString('   Ú');               (* write out the top line             *)
    FOR Column := 1 TO Size-1 DO
      WriteString('ÄÄÄÂ');
    END;
    WriteString('ÄÄÄ¿');
    WriteLn;

    FOR Row := 1 TO Size DO            (* write out each row                 *)
      WriteString('   ³');
      FOR Column := 1 TO Size DO
        WriteString('   ³')
      END;
      WriteLn;
      IF Row < Size THEN
        WriteString('   Ã');
        FOR Column := 1 TO Size-1 DO
          WriteString('ÄÄÄÅ');
        END;
        WriteString('ÄÄÄ´');
        WriteLn;
      ELSE
        WriteString('   À');           (* bottom row                         *)
        FOR Column := 1 TO Size-1 DO
          WriteString('ÄÄÄÁ');
        END;
        WriteString('ÄÄÄÙ');
        WriteLn;
      END;
    END;

  END WriteSetup;


PROCEDURE WriteFailed;                 (* reports our lack of success        *)

  BEGIN

    Failed := TRUE;

    HVP(25,1);
    WriteLn;
    WriteString('No solution found to problem. ');
    WriteLn;

  END WriteFailed;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN                                  (* MAIN                               *)

  WriteString('What size chessboard to solve for ? ');
  ReadCardinal(Size);

  SM(CO80);
  WriteSetup;

  FOR Column := 1 TO Size DO
    ColumnUsed[Column] := FALSE;       (* initialise test column array       *)
  END;
  FOR Diagonal1 := 2 TO 2 * INTEGER(Size) DO
    DiagUsed1[Diagonal1] := FALSE;     (* initialise test diagonal array 1   *)
  END;
  FOR Diagonal2 := 1 - INTEGER(Size) TO INTEGER(Size) - 1 DO
    DiagUsed2[Diagonal2] := FALSE;     (* initialise test diagonal array 2   *)
  END;

  Row := 1;
  Column := 1;
  Solved := FALSE;
  Failed := FALSE;


  WHILE (Row <= Size) AND  NOT (Solved) AND NOT (Failed) DO

    Queens[Row] := Column;             (* can we place a queen here ?        *)
    ShowQueen(Row, Column);
    IF      (NOT ColumnUsed[Column])
        AND (NOT DiagUsed1[INTEGER(Row) + INTEGER(Column)])
        AND (NOT DiagUsed2[INTEGER(Row) - INTEGER(Column)]) THEN
      ColumnUsed[Column] := TRUE;      (* this queen is OK (for the moment)  *)
      DiagUsed1[INTEGER(Row) + INTEGER(Column)] := TRUE;
      DiagUsed2[INTEGER(Row) - INTEGER(Column)] := TRUE;
      IF Row < Size THEN               (* check whether problem solved       *)
        INC(Row);                      (* next row if there are any more     *)
        Column := 1;
      ELSE
        WriteSolution;                 (* ... or else we've done it          *)
      END;
    ELSE                               (* this queen cannot be placed here   *)
      IF Column < Size THEN
        NoshowQueen(Row, Column);
        INC(Column);                   (* try the next column                *)
      ELSE                             (* otherwise backtrack some rows      *)
        WHILE (Queens[Row] = Size) AND (Row > 1) DO
          NoshowQueen(Row, Queens[Row]);
          DEC(Row, 1);
          ColumnUsed[Queens[Row]] := FALSE;
          DiagUsed1[INTEGER(Row) + INTEGER(Queens[Row])] := FALSE;
          DiagUsed2[INTEGER(Row) - INTEGER(Queens[Row])] := FALSE;
        END;
        IF Queens[Row] = Size THEN     (* exhausted all the possibilities    *)
          WriteFailed;
          Failed := TRUE;
        ELSE
          NoshowQueen(Row, Queens[Row]);
          Column := Queens[Row] + 1;   (* start from scratch on that column  *)
        END;
      END;
    END;
  END;                                 (* WHILE                              *)

END Queens4.

