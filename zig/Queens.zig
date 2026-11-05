// Copyright 2026 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2026-11-05

const std = @import("std");

const Board = struct {
    size: usize,
    row: usize,
    cols: u64,
    diags1: u64,
    diags2: u64,

    fn bit(col: usize) u64 {
        return @as(u64, 1) << @intCast(col);
    }

    fn new(size: u64) Board {
        return .{ .size = size, .row = 0, .cols = 0, .diags1 = 0, .diags2 = 0 };
    }

    fn ok(self: Board, col: usize) bool {
        return (self.cols & bit(col)) |
            (self.diags1 & bit(self.row + col)) |
            (self.diags2 & bit(self.size + self.row - col - 1)) == 0;
    }

    fn place(self: Board, col: usize) Board {
        return .{
            .size = self.size,
            .row = self.row + 1,
            .cols = self.cols | bit(col),
            .diags1 = self.diags1 | bit(self.row + col),
            .diags2 = self.diags2 | bit(self.size + self.row - col - 1),
        };
    }

    fn solve(self: Board) usize {
        if (self.row == self.size) return 1;

        var result: usize = 0;
        for (0..self.size) |col| {
            if (self.ok(col)) {
                result += self.place(col).solve();
            }
        }
        return result;
    }
};

pub fn main(init: std.process.Init) !void {
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    const from = if (args.len > 1) try std.fmt.parseInt(u64, args[1], 10) else 8;
    const to = if (args.len > 2) try std.fmt.parseInt(u64, args[2], 10) else from;
    for (from..to + 1) |size| {
        const start = std.Io.Clock.awake.now(init.io);
        const solutions = Board.new(size).solve();
        const elapsed_ns = start.untilNow(init.io, .awake).nanoseconds;
        const elapsed_s: f64 = @as(f64, @floatFromInt(elapsed_ns)) / 1e9;
        std.debug.print("{},{},{d:.3}\n", .{ size, solutions, elapsed_s });
    }
}
