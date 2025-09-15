const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;

const globals = @import("../globals.zig");
    const VariableBuffer = globals.VariableBuffer;

    extern var current_byte_address: usize;
    extern var variable_buffer: VariableBuffer;

const root = @import("../main.zig");
    const watchdog = root.watchdog;
    const watchdog_logging = root.watchdog_logging;


pub const default_variable_size: type = i64;
pub const stack_slot_size: usize = 16;


pub inline fn exec_stt() void {
    asm volatile (
        \\ push %rbp
        \\ mov  %rsp, %rbp
    );
}

pub inline fn exec_new() void {
}

pub inline fn exec_set() void {
}

pub inline fn exec_lod() void {
}

pub inline fn exec_end() void {
    asm volatile (
        \\ mov %rbp, %rsp
        \\ pop %rbp
    );
}
