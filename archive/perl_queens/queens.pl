# $Id: queens.pl 683 2007-04-04 08:00:08Z jhurst $
# Copyright 2007 John Hurst
# John Hurst (jbhurst@attglobal.net)
# 2007-04-01 

use strict;

my $size = 0;
my @pos = ();
my @col = ();
my @diag1 = ();
my @diag2 = ();

sub initialize {
  $size = $_[0];
  for (my $i = 0; $i < $size; $i++) {
    $pos[$i] = -1;
    $col[$i] = 0;
  }
  for (my $i = 0; $i < 2 * $size + 1; $i++) {
    $diag1[$i] = 0;
    $diag2[$i] = 0;
  }
}

sub place {
  my ($row, $col) = @_;
  $pos[$row] = $col;
  $col[$col] = 1;
  $diag1[$col - $row + $size] = 1;
  $diag2[$col + $row] = 1;
}

sub unplace {
  my ($row) = @_;
  my $col = $pos[$row];
  $pos[$row] = -1;
  $col[$col] = 0;
  $diag1[$col - $row + $size] = 0;
  $diag2[$col + $row] = 0;
  return $col;
}

sub ok {
  my ($row, $col) = @_;
  return !($col[$col] || $diag1[$col - $row + $size] || $diag2[$col + $row]);
}

initialize(shift);
my $row = 0;
my $col = 0;

my $start = time();
while ($row >= 0 && $row < $size) {
  while ($col < $size && !ok($row, $col)) {
    $col++;
  }
  if ($col < $size) {
    place($row, $col);
    $row++;
    $col = 0;
  }
  else {
    $row--;
    if ($row >= 0) {
      $col = unplace($row) + 1;
    }
  }
}

my $elapsed = time() - $start;
if ($row == $size) {
  foreach $col (@pos) {
    print " " x $col . "X\n";
  }
}

print $elapsed . " seconds.\n";

