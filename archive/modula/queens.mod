MODULE Queens;

(*****************************************************************************)
(*                                                                           *)
(*  Program to find a solution to the n queens problem posed for COMP 303.   *)
(*                                                                           *)
(*  John Hurst, 28 May 1987.                                                 *)
(*                                                                           *)
(*  It actually works !!!                                                    *)
(*                                                                           *)
(*****************************************************************************)

(* Basic library modules required :                                          *)

  FROM Terminal
    IMPORT WriteString, WriteLn;
  FROM CardinalIO
    IMPORT ReadCardinal;




  CONST
    maxsize = 20;




  TYPE

    rows      = [1..maxsize];
    columns   = [1..maxsize];
    placement = ARRAY rows OF columns;




  VAR

    size  : CARDINAL;
    row   : rows;
    column: columns;
    queens: placement;
    solved: BOOLEAN;
    failed: BOOLEAN;


    (* What we'll do is work through the rows, placing queens in each row,   *)
    (* ie. selecting a column for each row.  Therefore, there is no          *)
    (* possibility of placing more than one queen in any row.  The OK        *)
    (* function thus has to check only for more than one queen in a          *)
    (* given column, and for diagonal attacks.                               *)




  (* Function finds out whether the latest queen added attacks any others.   *)

  PROCEDURE ok(VAR queens: placement;
               n: rows): BOOLEAN;

    VAR

      queen2, r1, r2, c1, c2 : INTEGER;
      okResult: BOOLEAN;

  BEGIN
    okResult := TRUE;
    r1 := n;
    c1 := queens[n];

    (* Look at all the other queens we have already. *)
    FOR queen2 := 1 TO n-1 DO

      r2 := queen2;
      c2 := queens[queen2];

      (* Have we got a diagonal attack ? *)
      IF ABS(r1-r2) = ABS(c1-c2)
        THEN okResult := FALSE
      END;

      (* Have we got two in one column ? *)
      IF c1 = c2
        THEN okResult := FALSE
      END;

    END; (*endfor*)
    RETURN okResult
  END ok;




  PROCEDURE writeSolution(VAR queens: placement);
  (* This procedure writes out the solution board all nice and pretty.  *)

    VAR
      row: rows;
      column: INTEGER;

  BEGIN (* write_solution *)

    WriteLn;
    WriteString('Solution found : ');
    WriteLn;
    WriteLn;

    (* Write out the top line *)
    WriteString('   Ú');
    FOR column := 1 TO size-1 DO
      WriteString('ÄÄÄÂ');
    END;
    WriteString('ÄÄÄ¿');
    WriteLn;

    (* Write out each Row *)
    FOR row := 1 TO size DO

      WriteString('   ³');
      FOR column := 1 TO queens[row]-1 DO
        WriteString('   ³')
      END;
      WriteString(' Q ³');
      FOR column := queens[row]+1 TO size DO
        WriteString('   ³')
      END;
      WriteLn;
      IF row < size
        THEN
            WriteString('   Ã');
            FOR column := 1 TO size-1 DO
              WriteString('ÄÄÄÅ');
            END;
            WriteString('ÄÄÄ´');
            WriteLn;
        ELSE
            (* Bottom row *)
            WriteString('   À');
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

  END writeSolution; (* write_solution *)




  PROCEDURE writefailed;
  (* Procedure reports our lack of success *)

  BEGIN (* writefailed *)
    WriteLn;
    WriteString('No solution found to problem. ');
    WriteLn;
  END writefailed;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN (* Queens(input, output) *)

  WriteString('What size chessboard to solve for ? ');
  ReadCardinal(size);


  row := 1;
  column := 1;
  solved := FALSE;
  failed := FALSE;


  WHILE (row <= size) AND  NOT (solved) AND NOT (failed) DO

    (* Place a queen in this row. *)
    queens[row] := column;

    (* Check whether we were allowed to. *)
    IF ok(queens, row)

    (* This queen is OK *)
    THEN IF row < size
         THEN
             (* Move onto the next row if there are any more... *)
             INC(row, 1);
             column := 1;
         ELSE
             (* ... or else we've done it. *)
             writeSolution(queens);
             solved := TRUE;
         END

    (* This queen is not OK, so backtrack *)
    ELSIF column < size

         (* Try the next column if we can... *)
         THEN INC(column, 1)
         ELSE
             (* Otherwise we have to go back one or more rows. *)
             WHILE (queens[row]=size) AND (row>1) DO
               DEC(row, 1);
             END;
             IF queens[row]=size
               (* We've exhausted all the possibilities. *)
               THEN
                 writefailed;
                 failed:=TRUE
               ELSE column := queens[row]+1;
             END;
    END;

  END; (* WHILE *)
END Queens.

