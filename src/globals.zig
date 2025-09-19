const std = @import("std");
const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;


// ===========================
// === Source File Parsing ===
// ===========================
export var current_byte_address: usize = 0;
// ===========================


// ======================
// === Stack Handling ===
// ======================
const loaded_variable_size: comptime_int = 8;
export var loaded_variable: LoadedVariable = LoadedVariable.init();

pub const LoadedVariable = extern struct { const This: type = LoadedVariable;
    inner: [loaded_variable_size]u8,
    operation_size: u8,

    pub fn init() This { return .{
        .inner = [_]u8{0}**loaded_variable_size,
        .operation_size = 0,
    };}

    pub fn set(self: *This, value: []u8) void {
        // Copy the data to the loaded buffer
        for (value, 0..) |byte, index| {
            self.inner[index] = byte;
        }

        // Set the operation size
        self.operation_size = @intCast(value.len);
    }

    pub fn as_isize(self: *This) *usize {
        return @alignCast(std.mem.bytesAsValue(isize, self.inner[0..self.operation_size]));
    }

    pub fn as_f64(self: *This) *f64 {
        return @alignCast(std.mem.bytesAsValue(f64, self.inner[0..self.operation_size]));
    }
};

export var variable_frames: VariableFrames = undefined;


pub const VariableFrames = extern struct { const This: type = VariableFrames;
    pub const frame_size = 512;
    pub const variable_index_type: type = u16;

    inner: Vec(Vec(u8)),

    pub fn init() This {
        return This{ .inner = Vec(Vec(u8)).init() };
    }

    pub fn start_new_frame(self: *This, size: variable_index_type) void {
        var constructed_frame = Vec(u8).init_fixed(@intCast(size));
        constructed_frame.len = @intCast(size);

        self.inner.push(constructed_frame);
    }

    pub fn end_current_frame(self: *This) void {
        self.inner.shave();
    }

    pub fn get_current_frame(self: *This) !*Vec(u8) {
        return self.inner.last();
    }

    pub fn deinit(self: *This) void {
        for (self.inner.as_slice()) |vec| {
            vec.deinit();
        }

        self.inner.deinit();

    }
};
// =========================


// ==================================
// === Function Argument Handling ===
// ==================================
export var function_arg_registers = FunctionArgRegisters.init();


pub const FunctionArgRegister = enum(u8) {
    reg1 = 1,
    reg2 = 2,
    reg3 = 3,
    reg4 = 4,
    reg5 = 5,
    reg6 = 6,
};

pub const FunctionArgRegisters = extern struct {
    const This: type = FunctionArgRegisters;

    reg1: usize,
    reg2: usize,
    reg3: usize,
    reg4: usize,
    reg5: usize,
    reg6: usize,

    pub fn init() This { return .{
        .reg1 = 0,
        .reg2 = 0,
        .reg3 = 0,
        .reg4 = 0,
        .reg5 = 0,
        .reg6 = 0,
    };}

    pub fn set(self: *This, target_register: FunctionArgRegister, value: usize) void { switch (target_register) {
        .reg1 => self.reg1 = value,
        .reg2 => self.reg2 = value,
        .reg3 => self.reg3 = value,
        .reg4 => self.reg4 = value,
        .reg5 => self.reg5 = value,
        .reg6 => self.reg6 = value,
    }}
};
// ==================================
