const std = @import("std");
const builtin = @import("builtin");

const source_file_parsing = @import("source_file_parsing.zig");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const ptrFromAddr = ptr.ptrFromAddr;

const hardware = @import("hardware/hardware.zig");

const instruction_set = @import("instruction_set.zig");
    const InstructionSet = instruction_set.InstructionSet;

const globals = @import("globals.zig");
    const VariableBuffer = globals.VariableBuffer;
    extern var current_byte_address: usize;
    extern var variable_buffer: VariableBuffer;


const allocator = std.heap.page_allocator;


var file_content: Vec(u8) = undefined;


// =================
// === Functions ===
// =================
/// Emulated process to execute the given source file
noinline fn execute_program() void {
    while (@as(*u8, @ptrFromInt(current_byte_address)).* != fs.EOF) { switch (@as(*u8, @ptrFromInt(current_byte_address)).*) {
        @intFromEnum(InstructionSet.NEW) => InstructionSet.exec_new(),

        else => {},
    }}
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
