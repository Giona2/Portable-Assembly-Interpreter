const globals = @import("../globals.zig");
    const FunctionArgRegisters = globals.FunctionArgRegisters;

    extern var function_arg_registers: FunctionArgRegisters;


/// Write a message to `stdout`
/// msg: *[uint_8b]
/// len: usize
pub fn display() void {

}
