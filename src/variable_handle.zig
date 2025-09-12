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
};
