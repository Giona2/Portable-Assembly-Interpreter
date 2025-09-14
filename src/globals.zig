const std = @import("std");


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
    is_active: bool,
    address: usize,
    size: i8,
};

pub const VariableBuffer = extern struct {
    buffer: [max_variable_count]Variable,

    pub fn init() VariableBuffer {
        return .{ .buffer = [_]Variable{.{.is_active = false, .address = 0, .size = 0}}**max_variable_count };
    }

    pub noinline fn add_variable(self: *VariableBuffer, size: i8, address: usize) void {
        // Find the next available space
        var variable_index: usize = 0;
        while (variable_index < self.buffer.len) {
            if (!self.buffer[variable_index].is_active) break;
            variable_index += 1;
        }

        // Construct the variable
        self.buffer[variable_index] = .{ .is_active = true, .address = address, .size = size };
    }
};
// =========================


// ========================
// === Loading Variables ===
// =========================
// =========================
