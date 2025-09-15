const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;

const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;

    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;

const root = @import("../main.zig");
    const watchdog = root.watchdog;
    const watchdog_logging = root.watchdog_logging;


pub const default_variable_size: type = i64;
pub const stack_slot_size: usize = 16;


pub inline fn exec_stt() void {
    current_variable_frame.start_new_frame();
}

pub inline fn exec_new() void {

}

pub inline fn exec_set() void {
}

pub inline fn exec_lod() void {
}

pub inline fn exec_end() void {
    caller_variable_frames.restore_last_frame();
}
