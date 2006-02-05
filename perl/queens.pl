
$size = shift;

@pos = (-1, -1, -1, -1);
@col = (0, 0, 0, 0);
@diag1 = (0, 0, 0, 0, 0, 0, 0, 0);
@diag2 = (0, 0, 0, 0, 0, 0, 0, 0);

sub place {
  my ($row, $col) = @_;
  #print "place($row, $col)\n";
  $pos[$row] = $col;
  $col[$col] = 1;
  $diag1[$col-$row+$size] = 1;
  $diag2[$col+$row] = 1;
}

sub unplace {
  my ($row) = @_;
  #print "unplace($row)\n";
  $col = $pos[$row];
  $pos[$row] = undef;
  $col[$col] = 0;
  $diag1[$col-$row+$size] = 0;
  $diag2[$col+$row] = 0;
  return $col;
}

sub ok {
  my ($row, $col) = @_;
  #print "ok($row, $col)\n";
  return 0 if $col[$col];
  return 0 if $diag1[$col-$row+$size];
  return 0 if $diag2[$col+$row];
  return 1;
}

$row = 0;
$col = 0;

while ($row < $size) {
  while (!ok($row, $col) && $col < $size) {
    $col++;
  }
  if ($col < $size) {
    place($row, $col);
    $row++;
    $col = 0;
  }
  else {
    $row--;
    $col = unplace($row) + 1;
  }
}

foreach $p (@pos) {
  print " " x $p . "X\n";
}

