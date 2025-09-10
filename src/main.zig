const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const ptrFromAddr = ptr.ptrFromAddr;


const allocator = std.heap.page_allocator;


var last_byte:    *u8 = null;
var current_byte: *u8 = null;


fn execute_program() void {
    while (current_byte_address <= last_byte_address) {
        switch (ptrFromAddr(u8, current_byte_address).*) {
            else => std.debug.print("{d}\n", .{ptrFromAddr(u8, address: usize)}),
        }

        current_byte_address += 1;
    }
}


pub fn main() !void {
    // Get the target file's content
    const target_file = try fs.File.open("testing/example.iasm");
    const target_file_content = target_file.read();
        defer target_file_content.deinit();
    const file_content_ref = target_file_content.slice_ref();

    // Get the addresses of the first and last byte in file_content for pointer arithmetic
    last_byte_address    = &file_content_ref[file_content_ref.len-1];
    current_byte_address = &file_content_ref[0];

    // Execute the program
    execute_program();
}
