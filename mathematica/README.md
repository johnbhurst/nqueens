# Mathematica

Mathematica is a fun way to program the Queens problem, but is not very fast.

    SolveN := Composition[Reverse, Timing, SolveBoard, NewBoard]
    SolveN /@ Range[4, 12]

    {
        {2, 0.00104},
        {10, 0.003582},
        {4, 0.010026},
        {40, 0.046731},
        {92, 0.160073},
        {352, 0.649898},
        {724, 3.53721},
        {2680, 16.6137},
        {14200, 91.1466}
    }
