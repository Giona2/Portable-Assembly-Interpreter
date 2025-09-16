const std = @import("std");

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;

    extern var variable_frames: VariableFrames;


pub fn exec_stt() void {
    // Get the frame size
    current_byte_address += 1;
    const frame_size_raw: [2]u8 = @as(*const [2]u8, @ptrFromInt(current_byte_address)).*;
    const frame_size = std.mem.readInt(u16, frame_size_raw, .little);


}

pub fn exec_new() void {
    @panic("unimplemented");
}

pub fn exec_set() void {
    @panic("unimplemented");
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
