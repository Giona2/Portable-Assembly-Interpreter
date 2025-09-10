const builtin = @import("builtin");


/// Throws an error at compile time if the target hardware is unsupported
pub fn check_hardware_support() void {
    comptime { switch (builtin.target.os.tag) {
        .windows => {},
        .linux => {},
        else => @compileError("The target operating system you are compiling to is not supported")
    }}

    comptime { switch (builtin.target.cpu.arch) {
        .x86_64 => {},
        else => @compileError("The target architecture you are compiling to is not supported")
    }}
}
