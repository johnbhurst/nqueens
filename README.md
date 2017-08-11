# N-Queens: Comparing Different Programming Languages

I've been playing with this problem since the 1980s, and I have implemented programs for it in at least a dozen programming languages.
The earliest dated program of mine that I can find is a Pascal one from 1987.
But there's also a BASIC one here, which is not dated, but might be older!

Also in 1987 I read this paper:  
[Harold S Stone & Janice M Stone "Efficient search techniques - An empircal study of the N-Queens Problem", IBM Journal of Research and Development Vol 31, Issue 4: July 1987](http://ieeexplore.ieee.org/document/5390100/),
which outlines a fascinating way to improve the performance of the backtracking algorithm.

My programs use backtracking iteration.
When I started with this problem, I did not realise that there are fast algorithms to find a single solution.
See for example [Anany Levitin & Maria Levitin, "Algorithmic Puzzles", Oxford University Press (2011)](https://global.oup.com/academic/product/algorithmic-puzzles-9780199740444).
So I focused on finding and printing single solutions.

Below are some notes on the different implementations, in roughly chronological order.

## BASIC (1980s)

I learned BASIC in 1980, from a book my mother brought home one day. I still have that dog-eared old book.
The next year my mother bought us a Dick Smith System-80, which was an Australian clone of the TRS-80, with Level-2 BASIC.

I played a lot of games on it, but I also wrote a few games and many other programs.

I also learned a bit of Z80 assembler with it, and even dabbled in Pascal with Tiny Pascal.

The BASIC implementation here uses line-numbers, but also has `WHILE/WEND`, which my old TRS-80 Level 2 BASIC did not have.
So, I don't recall when I wrote it, which BASIC it was, or how to run it.

## Pascal (1987)

I got my first IBM computer in 1985 or 1986 I think, the PC JX.
It was an IBM Japan version of the "PC jr" sold in the US.

I used BASIC on that one too, a little.
But I also started experimenting with many other languages.

I started with IBM/Microsoft Pascal.
I think the compiler cost my hundreds of dollars, even with an IBM staff discount.
I bought several expensive language compilers in those years, when most of the "interesting" software for the PC was commerical.

Then one day I picked up Turbo Pascal for $100.
It was superior to the IBM/Microsoft product in every measure I could think of: price, compilation speed, executable size, executable speed.
It really was an outstanding piece of engineering.
The IDE also was incredibly snappy and productive.
I don't know if I have ever been as happy with a development environment since Turbo Pascal.

I wrote several very successful screen-scraping applications at IBM using Turbo Pascal.

These Pascal Queens programs may have actually been the first programs I wrote for the problem.

## Modula-2 (1988)

I graduated from Pascal to Modula-2, continuing my search for the perfect programming language.

My Modula-2 compiler was made by Logitech, I think before they ever got started with hardware.

I used Modula-2 for a few recreational projects, and then used it for my BSc Honours project work at university, too.

## Prolog (1989)

The Prolog programs were developed using Borland Turbo Prolog.

## C (1980s, 1990)

I learned C in 1986 for a university database course. I learned it from K&R first edition.

I used C for academic and commercial work in the 1980s and 1990s.

`queens.c` must be quite an old C program, because it uses the original K&R syntax, which has been obsolete for a long time, replaced by the ANSI syntax.
Based on the name, my guess is that `queencsqc.c` was written for Microsoft Quick-C.

`queensc1.c` and `queensc2.c` are newer: they use the ANSI syntax.

They also have the date they wqere written: 1990.

## C++ (2007)

I learned ++ in about 1990, and used it for academic and commercial work through the 1990s.

The largest project I did in C++ was with IBM, for computer/telephony integration at ANZ Bank.

The C++ Queens programs explored the performance difference between arrays and STL collections.

## Perl (2006, 2007)

I learned Perl while contracting with IBM at Ameritech in Chicago.
I used Perl to write a lot of utility scripts and small applications.

It was so much more productive than the traditional 3GL languages I had been using to that point, and it changed my view of programming forever.

I also used Perl to implement web applications at Contact Energy in 2002/2003.

The Perl implementations of the Queens programs ran surprisingly quickly for an interepreted scripting language.

## Java (2007)

I learned Java in 1995 when it was first launched, and joined many C++ programmers in switching to this new, simpler, cleaner language.
It was C++ "done right". (That seemed to be a possible thing, then.)

I ended up settling into the Java/JVM community for a long time, and still work on the platform 20 years later.

The Java Queens programs compared arrays with Collections classes in Java.

## Ruby (2007)

I got interested in Ruby in 2003 or 2004, after reading the Pick-Axe book.

For me Ruby was "Perl done right", or something like that.
I even named my dog "Ruby", whom we had from 2002 through 2015.

We used Ruby a little at Red Energy, until Groovy hit the scene and we switched to that.

## Groovy (2007)

I first tried Groovy in April 2004, when it was about 9 months old.
It was a bit flakey then, and I dropped it for a time.

But after the 1.0 release in 2007, I started using it more and more, and it's now been my primary langauge for 10 years.

Groovy combines elements of Java, Smalltalk and Ruby, and runs harmoniously on the JVM with Java, making it the best real-world alternative language during that period.

By default Groovy is very dynamic, and that led to very poor performance for the Queens problem on early versions, compared to other languages.

## Haskell (2012)

I tried to learn Haskell, stating in 2012.
But I have never got to the point where I really "get it".

These attempts at the Queens problem in Haskell illustrate my struggles to implement backtracking efficiently with immutable data structures.
No doubt there is a good way to do it, but I'm not there yet.

## Go (2016)

I started learning Go in 2016.
Go is a refreshing new take on low-level systems programming - a modern-day "C" replacement.
It's a lot of fun.
