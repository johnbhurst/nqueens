// Copyright 2026 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2026-11-05

const std = @import("std");

const Board = struct {
    const ONE = @as(u64, 1);
    size: u64,
    row: u64,
    cols: u64,
    diags1: u64,
    diags2: u64,

    fn new(size: u64) Board {
        return .{ .size = size, .row = 0, .cols = 0, .diags1 = 0, .diags2 = 0 };
    }

    fn ok(self: Board, col: u64) bool {
        return (self.cols & (ONE << @intCast(col))) |
            (self.diags1 & (ONE << @intCast(self.row + col))) |
            (self.diags2 & (ONE << @intCast(self.size + self.row - col - 1))) == 0;
    }

    fn place(self: Board, col: u64) Board {
        return .{
            .size = self.size,
            .row = self.row + 1,
            .cols = self.cols | (ONE << @intCast(col)),
            .diags1 = self.diags1 | (ONE << @intCast(self.row + col)),
            .diags2 = self.diags2 | (ONE << @intCast(self.size + self.row - col - 1))
        };
    }

    fn solve(self: Board) u64 {
        return if (self.row == self.size) 1 else {
            var result: u64 = 0;
            for (0..self.size) |col| {
                result += if (self.ok(@intCast(col))) self.place(@intCast(col)).solve() else 0;
            }
            return result;
        };
    }
};

pub fn main(init: std.process.Init) !void {
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    const from = if (args.len > 1) try std.fmt.parseInt(u64, args[1], 10) else 8;
    const to = if (args.len > 2) try std.fmt.parseInt(u64, args[2], 10) else from;
    for (from..to+1) |size| {
        const start = std.Io.Clock.awake.now(init.io);
        const board: Board = Board.new(size);
        const solutions = board.solve();
        const end = std.Io.Clock.awake.now(init.io);
        const elapsed_ns = start.durationTo(end).nanoseconds;
        const elapsed_s: f64 = @as(f64, @floatFromInt(elapsed_ns)) / 1_000_000_000;
        std.debug.print("{},{},{d:.3}\n", .{size, solutions, elapsed_s});
    }
}
