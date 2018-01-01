# Groovy

## Implementation Notes

Note the two different implementations of the `ok()` method:

      private boolean ok(int col) {
        return (this.cols & (1 << col)) == 0 &&
          (this.diags1 & (1 << this.row + col)) == 0 &&
          (this.diags2 & (1 << this.row - col + this.size - 1)) == 0
      }

      private boolean ok(int col) {
        return ((this.cols & (1 << col)) |
          (this.diags1 & (1 << this.row + col)) |
          (this.diags2 & (1 << this.row - col + this.size - 1))) == 0
      }

The second one performs better in most languages because it is entirely
computed using bitwise operations. This is also true of Groovy when
compiled statically. The first uses a combination of bitwise and Boolean
operations, and works better in dynamic Groovy. I suspect this may be
due to boxing/unboxing in dynamic Groovy.

