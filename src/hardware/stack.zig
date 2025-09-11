pub inline fn init_stack() void {
    asm volatile (
        \\push %%rbp
        \\mov  %%rsp, %%rbp
    );
}

pub inline fn end_stack() void {
    asm volatile (
        \\mov %%rbp, %%rsp
        \\pop %%rbp
    );
}

pub inline fn alloc_stack(size: usize) void {
    asm volatile (
        \\sub %[size], %%rsp
        :
        : [size] "{rax}" (size),
        : "rax"
    );
}
