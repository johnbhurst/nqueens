# Google Cloud Functions

(With Groovy driver.)

The Groovy driver generates partial boards to a certain depth,
then calls a Google Cloud Function to solve each of these boards in
parallel.

Increasing the depth increases the number of boards to solve, but
reduces the amount of work per board.

Ideally we would like to use as much parallelism as possible,
and solve many many small boards qquickly.

I've been having trouble getting Google Cloud Functions to run 100%
reliably, and am not sure whether the problem has to do with the number
of concurrent invocations or something else.

## pool size = 200, depth = 2, fetch attempts = 1

Number to evaluate: 90
Board size 11 has 2680 solutions. Calculated in PT11.56S.
Number to evaluate: 110
Board size 12 has 14200 solutions. Calculated in PT11.211S.
Number to evaluate: 132
Board size 13 has 73712 solutions. Calculated in PT16.122S.
Number to evaluate: 156
Board size 14 has 365596 solutions. Calculated in PT7.416S.
Number to evaluate: 182
Board size 15 has 2279184 solutions. Calculated in PT18.529S.
Number to evaluate: 210
Board size 16 has 14772512 solutions. Calculated in PT40.006S.
Number to evaluate: 240
Board size 17 has 95815104 solutions. Calculated in PT1M47.007S.
Number to evaluate: 272