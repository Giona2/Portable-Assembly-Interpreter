const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;


const allocator = std.heap.page_allocator;


pub fn main() !void {
    var target_file = try fs.File.open("testing/example.iasm");

    for (target_file.read().slice_ref()) |byte| {
        std.debug.print("{d}\n", .{byte});
    }
}
