const std = @import("std");

const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;
    const registers = hardware.registers;

const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;
    const AddressBuffer = globals.AddressBuffer;
    const FunctionArgRegisters = globals.FunctionArgRegisters;

    extern var loaded_variable_value: usize;
    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;
    extern var address_buffer: AddressBuffer;
    extern var function_arg_registers: FunctionArgRegisters;

const root = @import("../main.zig");
    const watchdog = root.watchdog;
    const watchdog_logging = root.watchdog_logging;

const InstructionSet = @import("instruction_set.zig").InstructionSet;


pub fn exec_set_function_register() void {
    // Retreave the register
    const given_register:  u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;
    const target_register_num: u8 = @intFromEnum(InstructionSet.AR0) ^ given_register;

    // Get the value
    current_byte_address += 1;
    const set_value: usize = @as(*usize, @ptrFromInt(current_byte_address)).*;

    // Set the target register
    function_arg_registers.set(@enumFromInt(target_register_num), set_value);

    // Move to the end of the instruction
    current_byte_address += @sizeOf(usize) - 1;
}
