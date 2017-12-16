/*****************************************************************************/
/* QueensC1.C    : N Queens Problem Backtracking Algorithm - MS C 5.0        */
/* Author        : John Hurst                                                */
/* Date          : 20/04/90                                                  */
/* Input         : InFile : parameter file giving:                           */
/*                 N1     : smallest board to solve                          */
/*                 N2     : largest board to solve                           */
/*                 MODE   : 'ALL' or 'ONE'                                   */
/*                 PMODE  : 'PRINT' or 'NOPRINT'                             */
/* Output        : Solutions and timing statistics for solutions             */
/* Parameters    : @1     : InFile name                                      */
/*                 @2     : OutFile name                                     */
/* Modifications : NONE                                                      */
/*                                                                           */
/*****************************************************************************/

#include  <ctype.h>
#include  <stdio.h>
#include  <jhtimes.h>


#define   TRUE      1
#define   FALSE     0


#define   MAXSIZE   100
#define   MAXSIZE2  199

FILE *InFile;
FILE *OutFile;
int  Queens[MAXSIZE];
int  Col[MAXSIZE];
int  Diag1[MAXSIZE2];
int  Diag2[MAXSIZE2];


void Init( char * argv[], int * N1, int * N2, char * Mode, char * PrintMode )
{
  InFile = fopen( argv[ 1 ], "r" );
  fscanf( InFile, "%d", N1 );
  fscanf( InFile, "%d", N2 );
  fscanf( InFile, "%s", Mode );
  fscanf( InFile, "%s", PrintMode );
  fclose( InFile );

  OutFile = fopen( argv[ 2 ], "w" );
  fprintf( OutFile, "QueensC1: \n" );
  fprintf( OutFile, "N1   = %5d \n", *N1 );
  fprintf( OutFile, "N2   = %5d \n", *N2 );
  fprintf( OutFile, "Mode = %s \n", Mode );
}

void Epilog()
{
  fclose( OutFile );
}

void Setup( int N )
{
  int j;
  for( j = 0; j<=N-1; j++ ) {
    Col[ j ] = TRUE;
  }
  for( j = 0; j<=2*N-2; j++ ) {
    Diag1[ j ] = TRUE;
    Diag2[ j ] = TRUE;
  }
}


int Ok( int i, int j, int N )
{
  return( Col[ j ] && Diag1[ j - i + N ] && Diag2[ i + j ] );
}


void Place( int i, int j, int N )
{
  Queens[ i ] = j;
  Col[ j ] = FALSE;
  Diag1[ j - i + N ] = FALSE;
  Diag2[ i + j ] = FALSE;
}


void Remove( int i, int j, int N )
{
  Col[ j ] = TRUE;
  Diag1[ j - i + N ] = TRUE;
  Diag2[ i + j ] = TRUE;
}


void WriteSolution( int N )
{
  int i, j;
  fprintf( OutFile, "Ú" );
  for( j = 0; j <= N-1; j++ )
    fprintf( OutFile, "ÄÄÄÂ" );
  fprintf( OutFile, "ÄÄÄ¿" );
  fprintf( OutFile, "\n" );
  for( i = 0; i <= N-1; i++ ) {
    fprintf( OutFile, "³" );
    for( j = 0; j <= Queens[ i ]-1; j++ )
      fprintf( OutFile, "   ³" );
    fprintf( OutFile, " Q ³" );
    for( j = Queens[ i ]+1; j <= N; j++ )
      fprintf( OutFile, "   ³" );
    fprintf( OutFile, "\n" );
    fprintf( OutFile, "Ã" );
    for( j = 0; j <= N-1; j++ )
      fprintf( OutFile, "ÄÄÄÅ" );
    fprintf( OutFile, "ÄÄÄ´" );
    fprintf( OutFile, "\n" );
  }
  fprintf( OutFile, "³" );
  for( j = 0; j <= Queens[ N ]-1; j++ )
    fprintf( OutFile, "   ³" );
  fprintf( OutFile, " Q ³" );
  for( j = Queens[ N ]+1; j <= N; j++ )
    fprintf( OutFile, "   ³" );
  fprintf( OutFile, "\n" );
  fprintf( OutFile, "À" );
  for( j = 0; j <= N-1; j++ )
    fprintf( OutFile, "ÄÄÄÁ" );
  fprintf( OutFile, "ÄÄÄÙ" );
  fprintf( OutFile, "\n" );
}


void Solve( int N, char * Mode, char * PrintMode, int * NS )
{
  int i, j;
  int Failed;
  Setup( N );
  i = 0;
  j = 0;
  Failed = FALSE;
  *NS = 0;
  N--;
  do {
    while ( ( i <= N ) && !Failed )
      if ( Ok( i, j, N ) ) {
        Place( i, j, N );
        i++;
        j = 0;
      } else {
        while ( ( 0 < i ) && ( j == N ) ) {
          i--;
          j = Queens[ i ];
          Remove( i, j, N );
        }
        if ( j < N )
          j++;
        else
          Failed = TRUE;
      }
    if ( !Failed ) {
      (*NS)++;
      if ( strcmp( PrintMode, "PRINT" ) == 0 )
        WriteSolution( N );
      i--;
      j = Queens[ i ];
      Remove( i, j, N );
      while ( ( 0 < i ) && ( j == N ) ) {
        i--;
        j = Queens[ i ];
        Remove( i, j, N );
      }
      if ( j < N )
        j++;
      else
        Failed = TRUE;
    }
  } while ( !Failed && ( strcmp( Mode, "ONE" ) ) );
}

main( int argc, char *argv[] )
{
  int  N, N1, N2;
  int  NS;
  char Mode[10];
  char PrintMode[10];
  Init( argv, &N1, &N2, Mode, PrintMode );
  for ( N = N1; N <= N2; N++ ) {
    JHResetTime();
    JHStartTime();
    Solve( N, Mode, PrintMode, &NS );
    JHStopTime();
    if ( NS == 1 )
      fprintf( OutFile, "%d solution  for N = %d", NS, N );
    else
      fprintf( OutFile, "%d solutions for N = %d", NS, N );
    fprintf( OutFile, " took %s.\n", JHStringTime( JHReadTime() ) );
  }
  Epilog();
}

