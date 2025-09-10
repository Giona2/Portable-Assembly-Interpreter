const std = @import("std");

const Vec = @import("stdzig/collections.zig").Vec;


pub fn main() !void {
    const msg = Vec(u8).from("Hello, there");
    std.debug.print("{s}", .{msg});
}
