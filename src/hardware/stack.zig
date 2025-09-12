/// Initiate a new stack frame
pub inline fn init_stack() void {
    asm volatile (
        \\push %%rbp
        \\mov  %%rsp, %%rbp
    );
}

/// End the current stack frame
pub inline fn end_stack() void {
    asm volatile (
        \\mov %%rbp, %%rsp
        \\pop %%rbp
    );
}

/// Allocate space in the current stack frame
pub inline fn alloc_stack(size: usize) void {
    asm volatile (
        \\sub %[size], %%rsp
        :
        : [size] "{rax}" (size),
        : "rax"
    );
}

pub const active_pointer_register: []u8 = "r10";
