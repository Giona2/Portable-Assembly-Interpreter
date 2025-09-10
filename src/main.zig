const std = @import("std");

const Vec = @import("stdzig/stdzig.zig").collections.Vec;


const allocator = std.heap.page_allocator;


pub fn main() !void {
    const file = try std.fs.cwd().openFile("testing/experiment.iasm", .{});
        defer file.close();

    const file_size = try file.getEndPos();

    var file_content: Vec(u8) = Vec(u8).init();
        defer file_content.deinit();
    file_content.append([_]u8{0} ** file_size);
}
