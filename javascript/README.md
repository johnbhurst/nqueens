# JavaScript

    node --version
    v9.2.0

## Object oriented, mutable state (place/unplace)

    node queens.js 11 14
    11: 39.912ms
    2680
    12: 98.136ms
    14200
    13: 520.964ms
    73712
    14: 3171.376ms
    365596

## Functional, ok()/place()/solve_board()

    node queens_func.js 11 14
    11: 24.032ms
    2680
    12: 75.518ms
    14200
    13: 435.935ms
    73712
    14: 2744.340ms
    365596

## Functional with filter()/map()/reduce()

    node queens_func_hihgerorder.js 11 14
    11: 314.934ms
    2680
    12: 1761.598ms
    14200
    13: 9576.930ms
    73712
    14: 58044.415ms
    365596
