const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;

const hardware = @import("hardware/hardware.zig");
    const stack = hardware.stack;


pub const address_buffer_size: comptime_int = 4;


/// Tracks the list of pointers the active register is currently accessing
pub var address_buffer:  [4]usize       = [_]usize{0} ** 4;
pub var variable_buffer: [50]?Variable = [_]Variable{null}**50;


pub fn variable_buffer_add_variable(self: [50]?Variable) void {
    // Find the next null value
    var next_available_variable_slot_index: usize = 0;
    while (next_available_variable_slot_index < self.len) {
        next_available_variable_slot_index += 1;
    }
}


/// Representation of a variable in stack memory
pub const Variable = extern struct {
    /// The first address of this variable
    start_address: usize,

    /// The size of this variable in bytes
    size: usize,

    pub fn init_default_variable(start_address: usize) Variable {
        return .{.is_active = true, .start_address = start_address, .size = 8};
    }
};

/// Representation of the created variables in a pasm executable
pub const VariableBuffer = extern struct {
    buffer: [50]?usize,

    pub fn init() VariableBuffer {
        return .{ .buffer = [_]?usize{null}**50 };
    }
};
