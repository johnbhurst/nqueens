# Copyright 2020 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
# 2026-11-14

"""Plot N-Queens timings for each language against board size.

The input is a CSV file from combine.py: an N column of board sizes, then one
column of times in seconds for each language. A language may have no time for
some sizes, and times below the timer's resolution may be zero.
"""

import argparse

import matplotlib
import pandas


def load(infile):
    """Read timings, indexed by board size N, with one column per language."""
    df = pandas.read_csv(infile, index_col="N").sort_index()
    df = df.apply(pandas.to_numeric, errors="coerce")
    # A time of zero is below the timer's resolution, and cannot be plotted on
    # a log scale, so treat it as missing.
    return df.mask(df <= 0)


def rank(df):
    """Order languages from slowest to fastest.

    Compare times at the largest board size that every language has a time for.
    If there is no such size, compare each language's time at its own largest
    size.
    """
    complete = df.dropna()
    if not complete.empty:
        size = complete.index[-1]
        times = complete.loc[size]
        label = f"N={size}"
    else:
        times = df.apply(lambda column: column.dropna().iloc[-1] if column.notna().any() else 0.0)
        label = "each language's largest N"
    return times.sort_values(ascending=False), label


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("infile", help="combined timings CSV file, from combine.py")
    parser.add_argument("-o", "--output", help="save the plot to this image file, in place of showing it")
    args = parser.parse_args()

    if args.output:
        matplotlib.use("Agg")  # no display needed to save a file
    import matplotlib.pyplot as plt

    df = load(args.infile)
    times, label = rank(df)
    print(f"Slowest to fastest, by time in seconds at {label}:")
    for language, time in times.items():
        print(f"  {language:12} {time:10.3f}")

    ax = df[times.index].plot(kind="line", logy=True, marker=".", figsize=(10, 7))
    # The default colours repeat after 10 lines, so vary the line style too.
    for i, line in enumerate(ax.get_lines()):
        line.set_linestyle(["-", "--", ":"][i // 10 % 3])
    ax.set_xlabel("Board size (N)")
    ax.set_ylabel("Time (seconds)")
    ax.set_title(f"N-Queens timings, slowest to fastest at {label}")
    ax.legend(fontsize="small", ncol=2)
    plt.tight_layout()

    if args.output:
        plt.savefig(args.output)
        print(f"Saved plot to {args.output}")
    else:
        plt.show()


if __name__ == "__main__":
    main()
