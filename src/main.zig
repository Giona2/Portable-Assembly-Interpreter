const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const ptrFromAddr = ptr.ptrFromAddr;

const hardware = @import("hardware/hardware.zig");

const instruction_set = @import("instruction_set.zig");


const allocator = std.heap.page_allocator;


var file_content: Vec(u8) = undefined;
var current_byte_address: usize = 0;

var address_buffer: Vec(usize) = Vec(usize).init_predef(4, 0);


noinline fn execute_program() void {
    while (@as(*u8, @ptrFromInt(current_byte_address)).* != fs.EOF) {
        switch (@as(*u8, @ptrFromInt(current_byte_address)).*) {
            0 => {address_buffer.last();},
            else => {},
        }

        current_byte_address += 1;
    }
}


pub fn main() !void {
    // Check hardware support
    hardware.platform.check_hardware_support();

    // Get the target file's content
    const target_file = try fs.File.open("testing/example.iasm");
    file_content = target_file.read();
        defer file_content.deinit();
    file_content.push(0xFF);

    current_byte_address = @intFromPtr(&file_content.slice_ref()[0]);

    // Execute the program
    execute_program();
}
