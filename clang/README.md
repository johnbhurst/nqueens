# C

    cc --version
    Apple LLVM version 9.0.0 (clang-900.0.39.2)
    Target: x86_64-apple-darwin17.3.0
    Thread model: posix
    InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

## Bits - Functional

    cc -O3 -o queens queens.c

    ./queens 11 14
    Board size 11 has 2680 solutions. Calculated in 10ms
    Board size 12 has 14200 solutions. Calculated in 52ms
    Board size 13 has 73712 solutions. Calculated in 304ms
    Board size 14 has 365596 solutions. Calculated in 1831ms
