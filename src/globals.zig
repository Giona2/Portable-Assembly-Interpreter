// ===========================
// === Source File Parsing ===
// ===========================
export var current_byte_address: usize = 0;
// ===========================


// =========================
// === Variable Handling ===
// =========================
export var variable_buffer = VariableBuffer.init();

const max_variable_count: comptime_int = 50;


pub const Variable = extern struct {
    address: usize,
    size: i8,
};

pub const VariableBuffer = extern struct {
    buffer: [max_variable_count]?*Variable,

    pub fn init() VariableBuffer {
        return .{ .buffer = [_]?*Variable{null}**max_variable_count };
    }

    pub fn add_variable(self: *VariableBuffer, size: i8, address: usize) void {
        // Find the next available space
        var variable_index: usize = 0;
        while (variable_index < self.buffer.len) {
            if (self.buffer[0] != null) break;
            variable_index += 1;
        }

        var constructed_variable = Variable{ .address = address, .size = size };

        // Construct the variable
        self.buffer[variable_index] = &constructed_variable;
    }
};
// =========================
