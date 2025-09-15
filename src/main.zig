const std = @import("std");
const builtin = @import("builtin");

const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;
    const fs = stdzig.fs;
    const ptr = stdzig.ptr;
        const ptrFromAddr = ptr.ptrFromAddr;

const hardware = @import("hardware/hardware.zig");

const instruction_set = @import("instruction_set/instruction_set.zig");
    const InstructionSet = instruction_set.InstructionSet;

const globals = @import("globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;

    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;


const allocator = std.heap.page_allocator;


var file_content: Vec(u8) = undefined;
var last_byte: usize = undefined;


// =================
// === Functions ===
// =================
pub const watchdog_logging: bool = true;
pub noinline fn watchdog() void {
}

/// Emulated process to execute the given source file
noinline fn execute_program() void {
    while (current_byte_address <= last_byte) {
        // Run the watchdog log messages
        if (comptime watchdog_logging) watchdog();

        // Chech the current instruction
        switch (@as(*u8, @ptrFromInt(current_byte_address)).*) {
            @intFromEnum(InstructionSet.STT) => instruction_set.variables.exec_stt(),

            @intFromEnum(InstructionSet.NEW) => instruction_set.variables.exec_new(),

            @intFromEnum(InstructionSet.SET) => instruction_set.variables.exec_set(),

            @intFromEnum(InstructionSet.END) => instruction_set.variables.exec_end(),

            else => {},
        }

        // Move to the next byte and continue
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
    last_byte = @intFromPtr(&file_content.slice_ref()[file_content.len-1]);

    // Execute the program
    execute_program();
}
