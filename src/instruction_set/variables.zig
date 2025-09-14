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
    // Move to the byte size
    current_byte_address += 1;

    // Allocate space on the stack
    stack.alloc_stack(stack_slot_size);

    // Register the new variable
    variable_buffer.add_variable(@sizeOf(default_variable_size), asm volatile("" : [ret] "={rsp}" (->usize)));
}

pub inline fn exec_set() void {
    // Move to the variable index
    current_byte_address += 1;

    // Set the variable index
    asm volatile (
        \\ movq %[value], (%[variable_address])
        :
        : [variable_address] "r" ( variable_buffer.buffer[@as(usize, (@as(*u8, @ptrFromInt(current_byte_address))).*)].address ),
          [value]            "r" ( @as(*default_variable_size, @ptrFromInt(current_byte_address+1)).* ),
        : "memory"
    );

    // Move to the end of this instruction
    current_byte_address += @sizeOf(default_variable_size);
}

pub inline fn exec_end() void {
    asm volatile (
        \\ mov %rbp, %rsp
        \\ pop %rbp
    );
}
