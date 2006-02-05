10  maxsize = 20
20  DIM queens(maxsize)
30  true = -1 : false = 0
40  INPUT "SIZE : "; size
50  row = 1
60  column = 1
70  solved = FALSE
80  failed = FALSE
100 WHILE (row <= size) AND  NOT (solved) AND NOT (failed)
110   queens(row) = column
120   GOSUB 600
140   IF NOT ok THEN 220
150     IF row >= size THEN 190
160       row = row + 1
170       column = 1
180       GOTO 330
190      GOSUB 700
200       solved = TRUE
210       GOTO 330
220     IF column >= size THEN 250
230       column = column + 1
240       GOTO 330
250      WHILE (queens(row) = size) AND (row > 1)
260         row = row - 1
270       WEND
280       IF queens(row) <> size THEN 320
290         GOSUB 900
300         failed = TRUE
310         GOTO 330
320        column = queens(row) + 1
330 WEND
340 END
600 n = row
610 ok = TRUE
620 r1 = n
630 c1 = queens(n)
640 FOR queen2 = 1 TO n - 1
650   r2 = queen2
660   c2 = queens(queen2)
670   IF ABS(r1-r2) = ABS(c1-c2) THEN ok = FALSE
680   IF c1 = c2 THEN ok = FALSE
690 NEXT
695 RETURN
700 PRINT
705 PRINT "Solution found : ";
710 PRINT
715 PRINT
720 PRINT "   Ú";
725 FOR column = 1 TO size-1 : PRINT "ÄÄÄÂ"; : NEXT
730 PRINT "ÄÄÄ¿";
735 PRINT
740 FOR row = 1 TO size
745   PRINT "   ³";
750   FOR column = 1 TO queens(row) - 1 : PRINT "   ³"; : NEXT
755   PRINT " Q ³";
760   FOR column = queens(row) + 1 TO size : PRINT "   ³"; : NEXT
765   PRINT
770   IF row >= size THEN 800
775     PRINT "   Ã";
780     FOR column = 1 TO size-1 : PRINT "ÄÄÄÅ"; : NEXT
785     PRINT "ÄÄÄ´";
790     PRINT
795     GOTO 820
800    PRINT "   À";
805     FOR column = 1 TO size-1 : PRINT "ÄÄÄÁ"; : NEXT
810     PRINT "ÄÄÄÙ";
815     PRINT
820 NEXT
825 PRINT
830 PRINT
835 PRINT
840 RETURN
900 PRINT
905 PRINT "No solution found to problem. ";
910 PRINT
