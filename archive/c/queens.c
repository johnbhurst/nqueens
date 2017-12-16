

#define MAXSIZE 20
#define TRUE    1
#define FALSE   0

int size;

main (argc, argv, envp)
    int argc;
    char *argv[];
    char *envp;

{
  int row, column;
  int queens[MAXSIZE];
  int solved, failed;

  if (argc > 0) {

    size = atoi(argv[1]);
    row = 0;
    column = 0;
    solved = FALSE;
    failed = FALSE;

    while ((row <= size-1) && (!solved) && (!failed)) {

      queens[row] = column;

      if (ok(queens, row))

        if (row < size-1) {
          row++;
          column = 0;
        } else {
          writeSolution(queens);
          solved = TRUE;
        }

      else if (column < size-1)

        column++;

      else {

        while ((queens[row] == size-1) && (row > 0))
          row--;

        if (queens[row] == size-1) {
          writefailed();
          failed = TRUE;
        }
        else
          column = queens[row] + 1;
      }
    }
  }
}



int ok(queens, n)
int queens[];
int n;
{
  int queen2, r1, r2, c1, c2, okResult;

  okResult = TRUE;
  r1 = n;
  c1 = queens[n];

  for (queen2 = 0; queen2 <= n-1; queen2++) {

    r2 = queen2;
    c2 = queens[queen2];

    if (abs(r1-r2) == abs(c1-c2))
      okResult = FALSE;

    if (c1 == c2)
      okResult = FALSE;

  }

  return (okResult);
}


writeSolution(queens)
int queens[];
{
  int row, column;

  printf("\n");
  printf("Solution found : ");
  printf("\n");
  printf("\n");

  printf("   Ú");
  for (column = 0; column <= size-2; column++)
    printf("ÄÄÄÂ");

  printf("ÄÄÄ¿");
  printf("\n");

  for (row = 0; row <= size-1; row++) {

    printf("   ³");
    for (column = 0; column <= queens[row] - 1; column++)
      printf("   ³");

    printf(" Q ³");

    for (column = queens[row] + 1; column <= size - 1; column++)
      printf("   ³");

    printf("\n");

    if (row < size - 1) {
      printf("   Ã");
      for (column = 0; column <= size - 2; column++)
        printf("ÄÄÄÅ");

      printf("ÄÄÄ´");
      printf("\n");
    } else {
      printf("   À");
      for (column = 1; column <= size - 1; column++)
        printf("ÄÄÄÁ");

      printf("ÄÄÄÙ");
      printf("\n");
    }
  }

  printf("\n");
  printf("\n");
  printf("\n");

}

writefailed()

{
  printf("\n");
  printf("No solution found to problem. ");
  printf("\n");
}

