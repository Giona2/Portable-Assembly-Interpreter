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
    const VariableFrames = globals.VariableFrames;
    const FunctionArgRegisters = globals.FunctionArgRegisters;
    const LoadedVariable = globals.LoadedVariable;

    extern var current_byte_address: usize;
    extern var function_arg_registers: FunctionArgRegisters;
    extern var variable_frames: VariableFrames;
    extern var loaded_variable: LoadedVariable;


const allocator = std.heap.page_allocator;


var file_content: Vec(u8) = undefined;
var last_byte: usize = undefined;


// =================
// === Functions ===
// =================
pub const watchdog_logging: bool = true;
pub noinline fn watchdog() void {
    std.debug.print("\nCurrent Char: {d}\n", .{@as(*u8, @ptrFromInt(current_byte_address)).*});
    if (variable_frames.inner.len > 0) {
        for ((variable_frames.get_current_frame() catch unreachable).slice_ref()) |variable| {
            std.debug.print("{d}\n", .{variable});
        }
    }
    std.debug.print("Loaded register: {any}\n", .{loaded_variable.inner});
}

/// Emulated process to execute the given source file
noinline fn execute_program() void {
    while (current_byte_address <= last_byte) {
        if (current_byte_address > last_byte) break;

        // Run the watchdog log messages
        if (comptime watchdog_logging) watchdog();

        // Chech the current instruction
        switch (@as(*u8, @ptrFromInt(current_byte_address)).*) {
            @intFromEnum(InstructionSet.STT) => instruction_set.variables.exec_stt(),

            @intFromEnum(InstructionSet.SET) => instruction_set.variables.exec_set(),

            @intFromEnum(InstructionSet.LOD) => instruction_set.variables.exec_lod(),

            @intFromEnum(InstructionSet.RET) => instruction_set.variables.exec_ret(),

            @intFromEnum(InstructionSet.END) => instruction_set.variables.exec_end(),

            @intFromEnum(InstructionSet.ADD) => instruction_set.arithmetic.exec_add(),

            @intFromEnum(InstructionSet.AR1) => instruction_set.function_arguments.exec_set_function_register(),
            @intFromEnum(InstructionSet.AR2) => instruction_set.function_arguments.exec_set_function_register(),
            @intFromEnum(InstructionSet.AR3) => instruction_set.function_arguments.exec_set_function_register(),
            @intFromEnum(InstructionSet.AR4) => instruction_set.function_arguments.exec_set_function_register(),
            @intFromEnum(InstructionSet.AR5) => instruction_set.function_arguments.exec_set_function_register(),
            @intFromEnum(InstructionSet.AR6) => instruction_set.function_arguments.exec_set_function_register(),

            @intFromEnum(InstructionSet.CAL) => instruction_set.interface.exec_cal(),

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

    variable_frames = VariableFrames.init();
        defer variable_frames.deinit();

    // Execute the program
    execute_program();
}
