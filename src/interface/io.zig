const globals = @import("../globals.zig");
    const FunctionArgRegisters = globals.FunctionArgRegisters;

    extern var function_arg_registers: FunctionArgRegisters;


/// Write a message to `stdout`
/// msg: *[uint_8b]
/// len: usize
pub fn display() void {
    // Get the arguments from the function argument registers
    const msg_address: usize = function_arg_registers.reg1;
    const len: usize = function_arg_registers.reg2;

    // Write to stdout
    asm volatile ("syscall"
        :
        : [arg1] "{rdi}" (1),
          [arg2] "{rsi}" (msg_address),
          [arg3] "{rdx}" (len),
    );
}
