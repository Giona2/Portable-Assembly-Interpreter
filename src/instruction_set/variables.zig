const std = @import("std");

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;
    const LoadedVariable = globals.LoadedVariable;

    extern var loaded_variable: LoadedVariable;
    extern var variable_frames: VariableFrames;
    extern var current_byte_address: usize;


pub fn exec_stt() void {
    // Get the frame size
    current_byte_address += 1;
    const frame_size_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address)).*;
    const frame_size = std.mem.readInt(VariableFrames.variable_index_type, frame_size_raw, .little);

    // Create new frame
    variable_frames.start_new_frame(frame_size);

    // Move to the end of the instruction
    current_byte_address += @sizeOf(frame_size) - 1;
}

pub fn exec_set() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_size: u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;

    // Get the variable pointer
    const current_variable_frames = (variable_frames.get_current_frame() catch unreachable).slice_ref();

    current_byte_address += 1;
    const variable_index_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address));
    const variable_index = std.mem.readInt(VariableFrames.variable_index_type, variable_index_raw, .little);
    const variable_pointer: [operation_size]u8 = current_variable_frames[variable_index..variable_frames+operation_size];

    // Write the value to the the variable
    current_byte_address += variable_index_raw.len - 1;

    for (variable_pointer) |*variable_slot| {
        variable_slot.* = current_byte_address + 1;

        current_byte_address += 1;
    }
}

pub fn exec_lod() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_size: u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;

    // Get the variable pointer
    const current_variable_frames = (variable_frames.get_current_frame() catch unreachable).slice_ref();

    current_byte_address += 1;
    const variable_index_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address));
    const variable_index = std.mem.readInt(VariableFrames.variable_index_type, variable_index_raw, .little);
    const variable_pointer: [operation_size]u8 = current_variable_frames[variable_index..variable_frames+operation_size];

    // Write this to the loading register
    loaded_variable.set(variable_pointer);

    // Move the current byte to the end of the instrution
    current_byte_address += variable_index_raw.len - 1;
}

pub fn exec_ret() void {
    // Get the size of the loaded variable
    const operation_size = loaded_variable.operation_size;

    // Get the variable pointer
    const current_variable_frames = (variable_frames.get_current_frame() catch unreachable).slice_ref();

    current_byte_address += 1;
    const variable_index_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address));
    const variable_index = std.mem.readInt(VariableFrames.variable_index_type, variable_index_raw, .little);
    const variable_pointer: [operation_size]u8 = current_variable_frames[variable_index..variable_frames+operation_size];

    // Set the variable to the value in the loaded variable buffer
    for (variable_pointer, 0..) |*variable_slot, index| {
        variable_slot.* = loaded_variable.inner[index];
    }
}

pub fn exec_end() void {

}
