# Go

    go version go1.8.3 darwin/amd64

## Arrays

    go build queens_all.go
    ./queens_all 11 14
    Board size 11 has 2680 solutions. Calculated in 16.422ms.
    Board size 12 has 14200 solutions. Calculated in 83.447ms.
    Board size 13 has 73712 solutions. Calculated in 384.145ms.
    Board size 14 has 365596 solutions. Calculated in 2.424568s.

## Arrays - parallel

    go build queens_all_parallel.go
    ./queens_all_parallel 11 14
    Board size 11 has 2680 solutions. Calculated in 6.087ms.
    Board size 12 has 14200 solutions. Calculated in 37.255ms.
    Board size 13 has 73712 solutions. Calculated in 175.088ms.
    Board size 14 has 365596 solutions. Calculated in 987.202ms.

## Bits

    go build queens_all_bits.go
    ./queens_all_bits 11 14
    Board size 11 has 2680 solutions. Calculated in 15.931ms.
    Board size 12 has 14200 solutions. Calculated in 76.895ms.
    Board size 13 has 73712 solutions. Calculated in 387.222ms.
    Board size 14 has 365596 solutions. Calculated in 2.345494s.

## Functional

    go build queens_all_func.go
    Board size 11 has 2680 solutions. Calculated in 20.96ms.
    Board size 12 has 14200 solutions. Calculated in 101.907ms.
    Board size 13 has 73712 solutions. Calculated in 496.566ms.
    Board size 14 has 365596 solutions. Calculated in 3.006174s.
