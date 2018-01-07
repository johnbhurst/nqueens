# Go

    go version go1.8.3 darwin/amd64

## Functional

    go build queens.go
    Board size 11 has 2680 solutions. Calculated in 20.96ms.
    Board size 12 has 14200 solutions. Calculated in 101.907ms.
    Board size 13 has 73712 solutions. Calculated in 496.566ms.
    Board size 14 has 365596 solutions. Calculated in 3.006174s.

## Functional - parallel

    go build queens_parallel.go
    Board size 11 has 2680 solutions. Calculated in 5.454ms.
    Board size 12 has 14200 solutions. Calculated in 33.28ms.
    Board size 13 has 73712 solutions. Calculated in 111.981ms.
    Board size 14 has 365596 solutions. Calculated in 626.894ms.

## Functional - parallel GCP n1-highcpu-4

    Board size 11 has 2680 solutions. Calculated in 7.494896ms.
    Board size 12 has 14200 solutions. Calculated in 36.008866ms.
    Board size 13 has 73712 solutions. Calculated in 155.342433ms.
    Board size 14 has 365596 solutions. Calculated in 937.389601ms.
    Board size 15 has 2279184 solutions. Calculated in 9.027127584s.
    Board size 16 has 14772512 solutions. Calculated in 1m4.365989864s.

## Functional - parallel GCP n1-highcpu-16

    Board size 11 has 2680 solutions. Calculated in 2.077255ms.
    Board size 12 has 14200 solutions. Calculated in 9.316836ms.
    Board size 13 has 73712 solutions. Calculated in 53.329788ms.
    Board size 14 has 365596 solutions. Calculated in 294.957093ms.
    Board size 15 has 2279184 solutions. Calculated in 1.85087926s.
    Board size 16 has 14772512 solutions. Calculated in 16.93968307s.
