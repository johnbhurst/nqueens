# Mathematica

Mathematica is a fun way to program the Queens problem, but is not very fast.

    Reverse /@ (Timing[SolveBoard[New[#]]] & /@ Range[4, 12])

    {
        {2, 0.001404},
        {10, 0.004504},
        {4, 0.015078},
        {40, 0.053516},
        {92, 0.201588},
        {352, 0.852801},
        {724, 2.78165},
        {2680, 12.109},
        {14200, 66.1882}
    }
