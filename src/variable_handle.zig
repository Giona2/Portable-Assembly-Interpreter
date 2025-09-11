const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;


pub const address_buffer_size: comptime_int = 4;


/// Tracks the list of pointers the active register is currently accessing
pub var address_buffer:  [4]usize      = [_]usize{0} ** 4;
pub var variable_buffer: Vec(Variable) = undefined;


/// Representation of a variable in stack memory
pub const Variable = struct {
    /// Indicates if this variable is currently being used
    is_active: bool,

    /// The first address of this variable
    start_address: usize,

    /// The size of this variable in bytes
    size: usize,
};
