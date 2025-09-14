const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;

const globals = @import("../globals.zig");
    const VariableBuffer = globals.VariableBuffer;

    extern var current_byte_address: usize;
    extern var variable_buffer: VariableBuffer;


const default_variable_size: comptime_int = 8;
pub inline fn exec_new() void {
    // Move to the byte size
    current_byte_address += 1;

    // Allocate space on the stack
    stack.alloc_stack(default_variable_size);

    // Register the new variable
    variable_buffer.add_variable(default_variable_size, asm volatile("" : [ret] "={rsp}" (->usize)));
}
