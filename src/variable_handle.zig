const max_variable_count: comptime_int = 50;


var variable_buffer = VariableBuffer.init();


pub const Variable = struct {
    address: usize,
    size: i8,
};

pub const VariableBuffer = struct {
    buffer: [max_variable_count]?Variable,

    pub fn init() VariableBuffer {
        return .{ .buffer = [_]?Variable{null}**max_variable_count };
    }

    pub fn add_variable(self: *VariableBuffer, size: i8, address: usize) void {
        // Find the next available space
        var variable_index: usize = 0;
        while (variable_index < self.buffer.len) {
            if (self.buffer[0] != null) break;
            variable_index += 1;
        }

        // Construct the variable
        self.buffer[variable_index] = .{ .address = address, .size = size };
    }
};
