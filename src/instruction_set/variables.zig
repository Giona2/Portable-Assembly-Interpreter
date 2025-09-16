const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;

    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;



pub fn exec_stt() void {
    @panic("unimplemented");
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
