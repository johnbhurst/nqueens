(*****************************************************************************)
(* QueensP1.PAS  : N Queens Problem Backtracking Algorithm - Turbo Pascal    *)
(* Author        : John Hurst                                                *)
(* Date          : 20/04/90                                                  *)
(* Input         : InFile : parameter file giving:                           *)
(*                 N1     : smallest board to solve                          *)
(*                 N2     : largest board to solve                           *)
(*                 MODE   : 'ALL' or 'ONE'                                   *)
(*                 PMODE  : 'PRINT' OR 'NOPRINT'                             *)
(* Output        : Solutions and timing statistics for solutions             *)
(* Parameters    : @1     : InFile name                                      *)
(*                 @2     : OutFile name                                     *)
(* Modifications : NONE                                                      *)
(*                                                                           *)
(*****************************************************************************)

PROGRAM QueensP1;

USES JHTimes;


CONST
  MaxSize = 100;
  MaxSize2 = 2*MaxSize-1;


VAR
  InFile    : TEXT;
  OutFile   : TEXT;
  N, N1, N2 : INTEGER;
  NS        : INTEGER;
  Mode      : String;
  PrintMode : String;
  Queens    : ARRAY[ 1..MaxSize ] OF INTEGER;
  Col       : ARRAY[ 1..MaxSize ] OF BOOLEAN;
  Diag1     : ARRAY[ 1..MaxSize2 ] OF BOOLEAN;
  Diag2     : ARRAY[ 1..MaxSize2 ] OF BOOLEAN;


PROCEDURE Init( VAR N1, N2 : INTEGER; VAR Mode : String );
BEGIN
  Assign( InFile, ParamStr( 1 ) );
  Reset( InFile );
  ReadLn( InFile, N1 );
  ReadLn( InFile, N2 );
  ReadLn( InFile, Mode );
  ReadLn( InFile, PrintMode );
  Close( InFile );
  Assign( OutFile, ParamStr( 2 ) );
  ReWrite( OutFile );
  WriteLn( OutFile, 'QueensP1: ' );
  WriteLn( OutFile, 'N1   = ', N1:5 );
  WriteLn( OutFile, 'N2   = ', N2:5 );
  WriteLn( OutFile, 'Mode = ', Mode );
  WriteLn( OutFile );
END;

PROCEDURE Epilog;
BEGIN
  Close( OutFile );
END;

PROCEDURE Setup( N : INTEGER );
VAR
  j : INTEGER;
BEGIN
  FOR j := 1 TO N DO BEGIN
    Col[ j ] := TRUE;
  END;
  FOR j := 1 TO 2*N - 1 DO BEGIN
    Diag1[ j ] := TRUE;
    Diag2[ j ] := TRUE;
  END;
END;


FUNCTION Ok( i, j, N : INTEGER ) : BOOLEAN;
BEGIN
  Ok := Col[ j ] AND Diag1[ j - i + N ] AND Diag2[ i + j - 1 ];
END;


PROCEDURE Place( i, j, N : INTEGER );
BEGIN
  Queens[ i ] := j;
  Col[ j ] := FALSE;
  Diag1[ j - i + N ] := FALSE;
  Diag2[ i + j - 1 ] := FALSE;
END;


PROCEDURE Remove( i, j, N : INTEGER );
BEGIN
  Col[ j ] := TRUE;
  Diag1[ j - i + N ] := TRUE;
  Diag2[ i + j - 1 ] := TRUE;
END;


PROCEDURE WriteSolution( N : INTEGER );
VAR
  i, j : INTEGER;
BEGIN
  Write( OutFile, 'Ú' );
  FOR j := 1 TO N-1 DO
    Write( OutFile, 'ÄÄÄÂ' );
  Write( OutFile, 'ÄÄÄ¿' );
  WriteLn( OutFile );
  FOR i := 1 TO N-1 DO BEGIN
    Write( OutFile, '³' );
    FOR j := 1 TO Queens[ i ]-1 DO
      Write( OutFile, '   ³' );
    Write( OutFile, ' Q ³' );
    FOR j := Queens[ i ]+1 TO N DO
      Write( OutFile, '   ³' );
    WriteLn( OutFile );
    Write( OutFile, 'Ã' );
    FOR j := 1 TO N-1 DO
      Write( OutFile, 'ÄÄÄÅ' );
    Write( OutFile, 'ÄÄÄ´' );
    WriteLn( OutFile );
  END;
  Write( OutFile, '³' );
  FOR j := 1 TO Queens[ N ]-1 DO
    Write( OutFile, '   ³' );
  Write( OutFile, ' Q ³' );
  FOR j := Queens[ N ]+1 TO N DO
    Write( OutFile, '   ³' );
  WriteLn( OutFile );
  Write( OutFile, 'À' );
  FOR j := 1 TO N-1 DO
    Write( OutFile, 'ÄÄÄÁ' );
  Write( OutFile, 'ÄÄÄÙ' );
  WriteLn( OutFile );
END;


PROCEDURE Solve( N : INTEGER; Mode : String; VAR NS : INTEGER );
VAR
  i, j   : INTEGER;
  Failed : BOOLEAN;
BEGIN
  Setup( N );
  i := 1;
  j := 1;
  Failed := FALSE;
  NS := 0;
  REPEAT
    WHILE ( i <= N ) AND NOT Failed DO
      IF Ok( i, j, N ) THEN BEGIN
        Place( i, j, N );
        INC( i );
        j := 1;
      END ELSE BEGIN
        WHILE ( 1 < i ) AND ( j = N ) DO BEGIN
          DEC( i );
          j := Queens[ i ];
          Remove( i, j, N );
        END;
        IF j < N THEN
          INC( j )
        ELSE
          Failed := TRUE;
      END;
    IF NOT Failed THEN BEGIN
      INC( NS );
      IF PrintMode = 'PRINT' THEN
        WriteSolution( N );
      DEC( i );
      j := Queens[ i ];
      Remove( i, j, N );
      WHILE ( 1 < i ) AND ( j = N ) DO BEGIN
        DEC( i );
        j := Queens[ i ];
        Remove( i, j, N );
      END;
      IF j < N THEN
        INC( j )
      ELSE
        Failed := TRUE;
    END;
  UNTIL Failed OR ( Mode = 'ONE' );
END;


BEGIN
  Init( N1, N2, Mode );
  FOR N := N1 TO N2 DO BEGIN
    JHResetTime;
    JHStartTime;
    Solve( N, Mode, NS );
    JHStopTime;
    IF NS = 1 THEN
      Write( OutFile, NS:6, ' solution  for N =', N:4, ' took ' )
    ELSE
      Write( OutFile, NS:6, ' solutions for N =', N:4, ' took ' );
    WriteLn( OutFile, JHStringTime( JHReadTime ), '.' );
  END;
  Epilog;
END.
