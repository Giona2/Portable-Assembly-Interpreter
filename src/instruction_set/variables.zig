const std = @import("std");

const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;
    const registers = hardware.registers;

const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;
    const AddressBuffer = globals.AddressBuffer;

    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;
    extern var address_buffer: AddressBuffer;

const root = @import("../main.zig");
    const watchdog = root.watchdog;
    const watchdog_logging = root.watchdog_logging;


pub const default_variable_size: type = i64;
pub const stack_slot_size: usize = 16;


pub fn exec_stt() void {
    current_variable_frame.start_new_frame();
}

pub fn exec_new() void {
    current_variable_frame.length += 1;

    current_byte_address += 1;

    current_variable_frame.inner[current_variable_frame.length-1].size = @as(*i8, @ptrFromInt(current_byte_address)).*;
}

pub fn exec_set() void {
    // Get the variable index
    current_byte_address += 1;
    const variable_index: i8 = @as(*i8, @ptrFromInt(current_byte_address)).*;

    // Get the variable value
    current_byte_address += 1;
    const variable_value: default_variable_size = @as(*default_variable_size, @ptrFromInt(current_byte_address)).*;

    // Construct the new variable
    current_variable_frame.inner[@intCast(variable_index)].value = variable_value;

    // Move to the next instruction
    current_byte_address += @sizeOf(default_variable_size);
}

pub fn exec_lod() void {
    // Get the variable index
    current_byte_address += 1;
    const variable_index: u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;

    // Add the address of that variable in the variable buffer to the address buffer
    address_buffer.push_address(@intFromPtr(&current_variable_frame.inner[variable_index].value));

    // Set %r10 to the value in this buffer
    asm volatile (
        "mov %[last_address], %r10"
        :
        : [last_address] "r" (current_variable_frame.inner[variable_index].value)
        : "r10", "memory"
    );
}

pub fn exec_ret() void {
    // Get the value in %r10
    const loaded_value: default_variable_size = asm volatile ("" : [value] "={r10}" (-> default_variable_size));

    // Pop the address buffer
    const last_address = address_buffer.pop_address();

    // Set the last address to the loaded value
    @as(*default_variable_size, @ptrFromInt(last_address)).* = loaded_value;
}

pub fn exec_end() void {
    caller_variable_frames.restore_last_frame();
}
