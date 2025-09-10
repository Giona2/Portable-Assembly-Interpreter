const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;


const allocator = std.heap.page_allocator;


pub fn main() !void {
    // Get the target file's content
    const target_file = try fs.File.open("testing/example.iasm");
    const target_file_content = target_file.read();
        defer target_file_content.deinit();

    // Iterate through each byte in the file
    for (target_file_content.slice_ref()) |byte| {
        std.debug.print("{d}\n", .{byte});
    }
}
