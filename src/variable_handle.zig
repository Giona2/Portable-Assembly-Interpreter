const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;


pub const address_buffer_size: comptime_int = 4;


/// Tracks the list of pointers the active register is currently accessing
pub var address_buffer:  [4]usize      = [_]usize{0} ** 4;
pub var variable_buffer: VariableBuffer = undefined;


/// Representation of the entire variable buffer of the current stack frame
pub const VariableBuffer = struct {
    buffer: Vec(Variable),
    total_size: usize,

    pub fn init() VariableBuffer {
        return VariableBuffer{ .buffer = Vec.init(), .total_size = 0 };
    }

    pub fn deinit(self: *const VariableBuffer) void {
        self.buffer.deinit();
    }
};


/// Representation of a variable in stack memory
pub const Variable = struct {
    /// Indicates if this variable is currently being used
    is_active: bool,

    /// The first address of this variable
    start_address: usize,

    /// The size of this variable in bytes
    size: usize,
};
