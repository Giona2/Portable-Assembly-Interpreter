const std = @import("std");

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;

    extern var variable_frames: VariableFrames;
    export var current_byte_address: usize = 0;


pub fn exec_stt() void {
    // Get the frame size
    current_byte_address += 1;
    const frame_size_raw: [@sizeOf(VariableFrames.frame_size_type)]u8 = @as(*const [2]u8, @ptrFromInt(current_byte_address)).*;
    const frame_size = std.mem.readInt(VariableFrames.frame_size_type, frame_size_raw, .little);

    // Create new frame
    variable_frames.start_new_frame(frame_size);

    // Move to the end of the instruction
    current_byte_address += @sizeOf(frame_size) - 1;
}

pub fn exec_set() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_size: u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;

    // Get the variable index
}

pub fn exec_lod() void {
    @panic("unimplemented");
}

pub fn exec_ret() void {
    @panic("unimplemented");
}

pub fn exec_end() void {
    @panic("unimplemented");
}
