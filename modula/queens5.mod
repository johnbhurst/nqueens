MODULE Queens5;
(*****************************************************************************)
(* Queens5       : N queens problem.  MIN solution.                          *)
(* Author        : John Hurst                                                *)
(* Date          : 25/03/88                                                  *)
(* Input         : N, the number of queens to solve the problem for.         *)
(* Output        : An NxN chessboard with N queens placed upon it such that  *)
(*                 none attacks any other.                                   *)
(*                                                                           *)
(* Version 1 was the basic backtracking algorithm                            *)
(* Version 2 introduced the boolean array for the columns                    *)
(* Version 3 introduced the boolean arrays for the diagonals                 *)
(* Version 4 was a real time display version of version 3.                   *)
(* Version 5 introduced the MIN strategy discussed in IBM J. of R & D.       *)
(*           (versions 1 through 4 used the LEX strategy.)                   *)
(*                                                                           *)
(*****************************************************************************)
(*                                                                           *)
(* Basic library modules required :                                          *)
(*                                                                           *)

  FROM Terminal
    IMPORT WriteString, WriteLn;
  FROM CardinalIO
    IMPORT ReadCardinal;
  IMPORT Break;
  IMPORT DebugPMD;


  CONST
    MaxSize = 20;                      (* upper limit on board size          *)


  TYPE

    ColIndex  = [1..MaxSize];          (* column index                       *)
    RowIndex  = [1..MaxSize];          (* row index                          *)
    Diag1     = [2..2 * MaxSize];      (* diagonal index 1                   *)
    Diag2     = [1-MaxSize..MaxSize-1];(* diagonal index 2                   *)

    Cols      = POINTER TO ColNode;
    ColNode   = RECORD
                  Col   : ColIndex;
                  Next  : Cols;
                END;
    Rows      = POINTER TO RowNode;
    RowNode   = RECORD
                  Row   : RowIndex;
                  VCols : Cols;
                  NCols : CARDINAL;
                  Next  : Rows;
                END;


    Placement = ARRAY RowIndex OF ColIndex;      (* a board setup            *)
    TestCols  = ARRAY ColIndex OF BOOLEAN;       (* check whether column plac*)
    TestDiag1 = ARRAY Diag1 OF BOOLEAN;(* quick check whether a diag placed  *)
    TestDiag2 = ARRAY Diag2 OF BOOLEAN;(* quick check whether a diag placed  *)


  VAR
    Size       : CARDINAL;             (* board size for this run            *)
    Column     : ColIndex;             (* column variable                    *)
    Diagonal1  : Diag1;                (* diagonal type 1 variable           *)
    Diagonal2  : Diag2;                (* diagonal type 2 variable           *)
    Queens     : Placement;            (* the board setup                    *)
    Solved     : BOOLEAN;              (* TRUE when finished successfully    *)
    Failed     : BOOLEAN;              (* TRUE when finished unsuccessfully  *)
    ColumnUsed : TestCols;             (* quick check array vertical attacks *)
    DiagUsed1  : TestDiag1;            (* quick check array diagonal 1       *)
    DiagUsed2  : TestDiag2;            (* quick check array diagonal 2       *)
    Row        : Rows;                 (* row variable                       *)
    RowsToPlace: Rows;                 (* remaining rows                     *)
    RowsPlaced : Rows;                 (* completed rows                     *)


(*                                                                           *)
(* The MIN strategy says that the next row to pick a column in should be the *)
(* row with the least choice.  We will select row one as the first row, then *)
(* follow the following algorithm :                                          *)
(*   for each remaining row to be processed, find the list of valid columns. *)
(*   select that row with the smallest list.                                 *)
(*   put a queen in the first available column.                              *)
(*   repeat process                                                          *)
(* if at any point we find that any row has no possible columns, we must     *)
(* backtrack.  The technique of backtracking will be:                        *)
(*   go back to the last row processed.                                      *)
(*   drop the column we picked there.                                        *)
(*   if there are any more possible columns to pick, pick the next one.      *)
(*   otherwise repeat backtrack.                                             *)
(*   if we run out of backtracks, there is no solution.                      *)
(*   (quite possibly the only N for which there is no solution are 2 and 3.) *)
(*                                                                           *)


PROCEDURE WriteSolution;               (* writes out the solution board      *)

  VAR
    Row    : RowIndex;
    Column : INTEGER;

  BEGIN

    Solved := TRUE;                    (* set solved flag for run            *)

    WriteLn;
    WriteString('Solution found : ');
    WriteLn;
    WriteLn;

    WriteString('   Ú');               (* write out the top line             *)
    FOR Column := 1 TO Size - 1 DO
      WriteString('ÄÄÄÂ');
    END;
    WriteString('ÄÄÄ¿');
    WriteLn;

    FOR Row := 1 TO Size DO            (* write out each row                 *)
      WriteString('   ³');
      FOR Column := 1 TO Queens[Row] - 1 DO
        WriteString('   ³')
      END;
      WriteString(' Q ³');
      FOR Column := Queens[Row] + 1 TO Size DO
        WriteString('   ³')
      END;
      WriteLn;
      IF Row < Size THEN
        WriteString('   Ã');
        FOR Column := 1 TO Size - 1 DO
          WriteString('ÄÄÄÅ');
        END;
        WriteString('ÄÄÄ´');
        WriteLn;
      ELSE
        WriteString('   À');           (* bottom row                         *)
        FOR Column := 1 TO Size - 1 DO
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
    Failed := TRUE;
    WriteLn;
    WriteString('No solution found to problem. ');
    WriteLn;
  END WriteFailed;


PROCEDURE BuildAllRows(Number, Size : CARDINAL) : Rows;
                                       (* returns full list of all rows      *)
VAR
  ThisRow : Rows;
BEGIN (* BuildAllRows *)
  IF Number > 0 THEN
    New(ThisRow);
    ThisRow^.Row   := Size - Number + 1;
    ThisRow^.VCols := NIL;
    ThisRow^.Next  := BuildAllRows(Number - 1, Size);
    RETURN(ThisRow);
  ELSE
    RETURN(NIL);
  END;
END  BuildAllRows;



PROCEDURE AddCol(Col : Column; Column : ColIndex) : Column;
VAR                                    (* add a column number to a list      *)
  ThisCol : Column;
BEGIN (* AddCol *)
  IF Col = NIL THEN
    New(ThisCol);
    ThisCol^.Col := Column;
    ThisCol^.Next := NIL;
    RETURN(ThisCol);
  ELSE
    RETURN(AddCol(Col^.Next, Column));
  END;
END  AddCol ;



PROCEDURE BuildValidColumns(RowsToPlace : Rows);
                                       (* works out lists of valid columns   *)
VAR
  Column : ColIndex;
BEGIN (* BuildValidColumns *)
  IF RowsToPlace <> NIL THEN
    RowsToPlace^.NCols := 0;
    FOR Column := 1 TO Size DO
      IF Ok(RowsToPlace^.Row, Column) THEN
        RowsToPlace^.VCols := AddCol(RowsToPlace^.VCols, Column);
        INC(RowsToPlace^.NCols);
      END;
    END;
    BuildValidColumns(RowsToPlace^.Next);
  END;
END  BuildValidColumns ;



PROCEDURE SelectMIN(ThsRow : Row) : Row;
                                       (* applies magic strategy             *)
VAR
  NextRow : Rows;
BEGIN (* SelectMIN *)
  IF ThisRow = NIL THEN
    RETURN(NIL);
  ELSE
    NextRow := SelectMIN(ThisRow^.Next);
    IF NextRow = NIL THEN
      RETURN(ThisRow);
    ELSE
      IF ThisRow^.NCols < NextRow^.NCols THEN
        RETURN(ThisRow);
      ELSE
        RETURN(NextRow);
      END;
    END;
  END;
END  SelectMIN ;


PROCEDURE UseColumn(ThisRow : Row);
                                       (* marks first valid column as used   *)

BEGIN (* UseColumn *)
  *(************up to here
END  UseColumn ;



(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN                                  (* MAIN                               *)

  WriteString('What size chessboard to solve for ? ');
  ReadCardinal(Size);

  FOR Column := 1 TO Size DO
    ColumnUsed[Column] := FALSE;       (* initialise test column array       *)
  END;
  FOR Diagonal1 := 2 TO 2 * INTEGER(Size) DO
    DiagUsed1[Diagonal1] := FALSE;     (* initialise test diagonal array 1   *)
  END;
  FOR Diagonal2 := 1 - INTEGER(Size) TO INTEGER(Size) - 1 DO
    DiagUsed2[Diagonal2] := FALSE;     (* initialise test diagonal array 2   *)
  END;

  Solved := FALSE;
  Failed := FALSE;

  RowsToPlace := BuildAllRows(Size, Size);
  RowsPlaced  := NIL;

  WHILE (NOT Solved) AND (NOT Failed) DO
    IF BuildValidColumns(RowsToPlace) THEN
      Row := SelectMIN(RowsToPlace);
      UseColumn(Row);
      RowsToPlace := Remove(Row, RowsToPlace);
      RowsPlaced := Add(Row, RowsPlaced);
      IF Empty(RowsToPlace) THEN
        WriteSolved(RowsPlaced);
      END;
    ELSE
      FreeColumn(SelectLast(RowsPlaced));
      WHILE (NOT Empty(RowsPlaced)) AND NOT ValidColumns(RowsPlaced) DO
        Row := SelectLast(RowsPlaced);
        RowsPlaced := Remove(Row, RowsPlaced);
        RowsToPlace := Add(Row, RowsToPlace);
      IF ValidColumns(RowsPlaced) THEN
        UseColumn(RowsPlaced);
      ELSE
        WriteFailed;
      END;
    END;
  END;     (* WHILE *)




END Queens5.

