// console.time('main');
// for (let i = 0 ; i < 1000; i++) {
//   // do nothing
// }
// console.timeEnd('main');

class Board {
  constructor(size) {
    this.size = size;
    this.pos = []; // TODO: array of ints
    this.col = 0;
    this.diag1 = 0;
    this.diag2 = 0;
  }

  place(row, col) {
    //console.log("place(%d, %d)", row, col);
    this.pos[row] = col;
    this.col |= 1 << col;
    this.diag1 |= 1 << (row + col);
    this.diag2 |= 1 << (row - col + this.size -1);
  }

  remove(row) {
    var col = this.pos[row];
    this.col = this.col & ~(1 << col);
    this.diag1 = this.diag1 & ~(1 << row + col);
    this.diag2 = this.diag2 & ~(1 << row - col + size - 1);
    return col;
  }

  ok(row, col) {
    //console.log("ok(%d, %d)", row, col);
    //console.log("size=%d, col=%d, diag1=%d, diag2=%d", this.size, this.col, this.diag1, this.diag2);
    var result = (this.col & (1 << col)) == 0 &&
      (this.diag1 & (1 << row + col)) == 0 &&
      (this.diag2 & (1 << row - col + size - 1)) == 0;
    //console.log("result = " + result);
    return result;
  }

  backtrack(row, col) {
    while (col == this.size && row >= 0) {
      row--;
      if (row >= 0) {
        col = this.remove(row) + 1;
      }
    }
    return [row, col];
  }

  solve() {
    var row = 0;
    var col = 0;
    var result = 0;
    while (row >= 0) {
      if (this.ok(row, col)) {
        this.place(row, col);
        if (row < this.size - 1) {
          row++;
          col = 0;
        }
        else {
          result++;
          col = this.remove(row) + 1;
          if (col == this.size) {
            [row, col] = this.backtrack(row, col);
          }
        }
      }
      else {
        col++;
        if (col == this.size) {
          [row, col] = this.backtrack(row, col);
        }
      }
    }
    return result;
  }
}

var start = Number.parseInt(process.argv[2]);
var end = process.argv.length > 3 ?
  Number.parseInt(process.argv[3]) : start;

for (var size = start; size <= end; size++) {
  var b = new Board(size);
  console.time(size);
  var result = b.solve();
  console.timeEnd(size);
  console.log(result);
}
