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
export var loaded_variable_value: [loaded_variable_size]u8 = [_]u8{0}**loaded_variable_value;

export var variable_frames: VariableFrames = undefined;


pub const VariableFrames = extern struct { const This: type = VariableFrames;
    const frame_size = 512;

    inner: Vec(Vec(u8)),

    pub fn init() This {
        return This{ .inner = Vec(Vec(u8)).init() };
    }

    pub fn start_new_frame(self: *This, size: usize) void {
        const constructed_frame = Vec(u8).init_fixed(size);

        self.inner.push(constructed_frame);
    }

    pub fn end_current_frame(self: *This) void {
        self.inner.shave();
    }

    pub fn get_current_frame(self: *This) !Vec(u8) {
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
