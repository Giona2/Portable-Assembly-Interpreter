const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const Ptr = ptr.Ptr;

const hardware = @import("hardware/hardware.zig");


const allocator = std.heap.page_allocator;


var last_byte:    Ptr(u8) = undefined;
var current_byte: Ptr(u8) = undefined;


fn execute_program() void {
    while (current_byte.addr() <= last_byte.addr()) {
        switch (current_byte.ptr_ref().*) {
            else => std.debug.print("{d}\n", .{current_byte.ptr_ref().*}),
        }

        current_byte.inc(1);
    }
}


pub fn main() !void {
    // Check hardware support
    hardware.platform.check_hardware_support();

    // Get the target file's content
    const target_file = try fs.File.open("testing/example.iasm");
    var target_file_content = target_file.read();
        defer target_file_content.deinit();
    var file_content_ref = target_file_content.as_slice();

    // Get the addresses of the first and last byte in file_content for pointer arithmetic
    last_byte    = Ptr(u8).new(&file_content_ref[file_content_ref.len-1]);
    current_byte = Ptr(u8).new(&file_content_ref[0]);

    // Execute the program
    execute_program();
}
