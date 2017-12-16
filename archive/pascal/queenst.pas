PROGRAM Queenst;

(*****************************************************************************)
(*                                                                           *)
(*  Program to find a solution to the n queens problem posed for COMP 303.   *)
(*                                                                           *)
(*  John Hurst, 28 May 1987.                                                 *)
(*                                                                           *)
(*  It actually works !!!                                                    *)
(*                                                                           *)
(*****************************************************************************)


  CONST
    maxsize = 20;

  TYPE

    rows      = 1..maxsize;
    columns   = 1..maxsize;
    placement = ARRAY [rows] OF columns;

  VAR

    size  : INTEGER;
    code  : INTEGER;    (* TURBO *)
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

  FUNCTION ok(VAR queens: placement;
                n: rows): BOOLEAN;

    VAR

      queen2, r1, r2, c1, c2 : INTEGER;

  BEGIN
    ok := TRUE;
    r1 := n;
    c1 := queens[n];

    (* Look at all the other queens we have already. *)
    FOR queen2 := 1 TO n-1 DO
      BEGIN

        r2 := queen2;
        c2 := queens[queen2];

        (* Have we got a diagonal attack ? *)
        IF ABS(r1-r2) = ABS(c1-c2)
          THEN ok := FALSE;

        (* Have we got two in one column ? *)
        IF c1 = c2
          THEN ok := FALSE;

    END; (*endfor*)
  END;




  PROCEDURE writeSolution(VAR queens: placement);
  (* This procedure writes out the solution board all nice and pretty.  *)

    VAR
      row: rows;
      column: INTEGER;

  BEGIN (* write_solution *)

    WriteLn;
    Write('Solution found : ');
    WriteLn;
    WriteLn;

    (* Write out the top line *)
    Write('   Ú');
    FOR column := 1 TO size-1 DO
      Write('ÄÄÄÂ');
    Write('ÄÄÄ¿');
    WriteLn;

    (* Write out each Row *)
    FOR row := 1 TO size DO
      BEGIN
        Write('   ³');
        FOR column := 1 TO queens[row]-1 DO
          Write('   ³');
        Write(' Q ³');
        FOR column := queens[row]+1 TO size DO
          Write('   ³');
        WriteLn;
        IF row < size
          THEN
            BEGIN
              Write('   Ã');
              FOR column := 1 TO size-1 DO
                Write('ÄÄÄÅ');
              Write('ÄÄÄ´');
              WriteLn;
            END
          ELSE
            BEGIN
              (* Bottom row *)
              Write('   À');
              FOR column := 1 TO size-1 DO
                Write('ÄÄÄÁ');
              Write('ÄÄÄÙ');
              WriteLn;
            END;
      END;

    WriteLn;
    WriteLn;
    WriteLn;

  END; (* write_solution *)




  PROCEDURE writefailed;
  (* Procedure reports our lack of success *)

  BEGIN (* writefailed *)
    WriteLn;
    Write('No solution found to problem. ');
    WriteLn;
  END;





(* Now for the real thing.  The ALGORITHM is included as the main program.   *)

BEGIN (* Queens(input, output) *)

  Val(paramstr(1), size, code);

  row := 1;
  column := 1;
  solved := FALSE;
  failed := FALSE;

  WHILE (row <= size) AND  NOT (solved) AND NOT (failed) DO
    BEGIN

      (* Place a queen in this row. *)
      queens[row] := column;

      (* Check whether we were allowed to. *)
      IF ok(queens, row)

        (* This queen is OK *)
        THEN
          IF row < size
            THEN
              BEGIN
                (* Move onto the next row if there are any more... *)
                row := row+1;
                column := 1;
              END
            ELSE
              BEGIN
                (* ... or else we've done it. *)
                writeSolution(queens);
                solved := TRUE;
              END

        (* This queen is not OK, so backtrack *)
        ELSE
          IF column < size

           (* Try the next column if we can... *)
           THEN
             column := column + 1
           ELSE
             BEGIN
               (* Otherwise we have to go back one or more rows. *)
               WHILE (queens[row]=size) AND (row>1) DO
                 row := row-1;
               IF queens[row]=size
                 (* We've exhausted all the possibilities. *)
                 THEN
                   BEGIN
                     writefailed;
                     failed:=TRUE;
                   END
                 ELSE column := queens[row]+1;
             END;

    END; (* WHILE *)

END.

