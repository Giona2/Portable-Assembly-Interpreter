// ===============
// === Imports ===
// ===============
const std = @import("std");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const ptrFromAddr = ptr.ptrFromAddr;

const hardware = @import("hardware/hardware.zig");
// ===============


// =================
// === Constants ===
// =================
const allocator = std.heap.page_allocator;
// =================


// ===============
// === Globals ===
// ===============
/// Content of the given source file
var file_content: Vec(u8) = undefined;

/// Currently selected byte in the source file
pub var current_byte_address: usize = 0;
// ===============


// =================
// === Functions ===
// =================
/// Emulated process to execute the given source file
noinline fn execute_program() void {
    while (@as(*u8, @ptrFromInt(current_byte_address)).* != fs.EOF) {
        std.debug.print("{d}\n", .{@as(*u8, @ptrFromInt(current_byte_address)).*});
        current_byte_address += 1;
    }
}
// =================


pub fn main() !void {
    // Check hardware support
    hardware.platform.check_hardware_support();

    // Get the target file's content
    const target_file = try fs.File.open("testing/example.pasm");
    file_content = target_file.read();
        defer file_content.deinit();
    current_byte_address = @intFromPtr(&file_content.slice_ref()[0]);

    // Execute the program
    execute_program();
}
