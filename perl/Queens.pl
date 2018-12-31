# Copyright 2018 John Hurst
# John Hurst
# 2018-12-22

use strict;
use warnings;
use Time::HiRes qw(time);

sub ok {
  my ($size, $row, $cols, $diags1, $diags2, $col) = @_;
  return ($cols & (1 << $col)) == 0 &&
         ($diags1 & (1 << $row + $col)) == 0 &&
         ($diags2 & (1 << $row - $col + $size - 1)) == 0;
}

sub place {
  my ($size, $row, $cols, $diags1, $diags2, $col) = @_;
  return (
    $size,
    $row + 1,
    $cols | (1 << $col),
    $diags1 | (1 << $row + $col),
    $diags2 | (1 << $row - $col + $size - 1)
  );
}

sub solve {
  my ($size, $row, $cols, $diags1, $diags2) = @_;
  if ($row == $size) {
    return 1;
  }
  my $result = 0;
  foreach my $col (1..$size) {
    if (ok($size, $row, $cols, $diags1, $diags2, $col)) {
      $result += solve(place($size, $row, $cols, $diags1, $diags2, $col));
    }
  }
  return $result;
}

my $from = $#ARGV >= 0 ? $ARGV[0] : 8;
my $to = $#ARGV >= 1 ? $ARGV[1] : $from;

foreach my $size ($from..$to) {
  my $start = time;
  my $result = solve($size, 0, 0, 0, 0);
  my $duration = time - $start;
  printf("%d,%d,%0.3f\n", $size, $result, $duration);
}
