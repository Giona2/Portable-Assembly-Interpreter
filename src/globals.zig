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
const maximum_variable_count: comptime_int = 32;

export var loaded_variable_value: usize = 0;

export var caller_variable_frames: CallerVariableFrames = undefined;
export var address_buffer: AddressBuffer = AddressBuffer.init();

pub const AddressBuffer = extern struct {
    inner: [maximum_variable_count]usize,
    len: usize,

    pub fn init() AddressBuffer { return .{
        .inner = [_]usize{0}**maximum_variable_count,
        .len = 0,
    };}

    /// Add an address to the address buffer
    pub fn push_address(self: *AddressBuffer, address: usize) void {
        self.len += 1;

        self.inner[self.len-1] = address;
    }

    /// Remove the last address from the address buffer
    pub fn remove_address(self: *AddressBuffer) void {
        self.len -= 1;
    }

    /// Retreaves the most recent address from the address buffer
    pub fn get_most_recent_address(self: *AddressBuffer) usize {
        return self.inner[self.len-1];
    }

    /// Get the last address pushed to the buffer, then deletes it
    pub fn pop_address(self: *AddressBuffer) usize {
        self.len -= 1;
        return self.inner[self.len];
    }
};

pub const CallerVariableFrames = extern struct {
    inner: Vec(Vec(Variable)),

    pub fn init() CallerVariableFrames {
        return CallerVariableFrames{ .inner = Vec(Vec(Variable)).init() };
    }

    pub fn restore_last_frame(self: *CallerVariableFrames) void {
        // Get the last caller stack frame
        const previous_frame = self.inner.last() catch unreachable;

        // Set the length of the current variable frame to the length of the previous frame
        current_variable_frame.length = previous_frame.len;

        // Copy the data from the previous frame to the current fram
        var current_variable_index: usize = 0;
        while (current_variable_index < current_variable_frame.length) {
            current_variable_frame.inner[current_variable_index] = (previous_frame.get(current_variable_index) catch unreachable).*;

            current_variable_index += 1;
        }
    }
};

pub const CurrentVariableFrame = extern struct {
    inner: [maximum_variable_count]Variable,
    length: usize,

    pub fn init() CurrentVariableFrame { return CurrentVariableFrame{
        .inner = [_]Variable{ .{.size = 0, .value= 0} }**maximum_variable_count,
        .length = 0
    };}

    pub fn start_new_frame(self: *CurrentVariableFrame) void {
        // Construct the caller frame
        var caller_frame = Vec(Variable).init();

        // Copy the data of the current frame to the caller frame
        for (self.inner[0..self.length]) |variable| {
            caller_frame.push(variable);
        }

        // Add the caller frame to the caller variable frames
        caller_variable_frames.inner.push(caller_frame);
    }
};

pub const Variable = extern struct {
    size: i8,
    value: usize,
};
// =========================


// ==================================
// === Function Argument Handling ===
// ==================================
export var function_arg_registers = FunctionArgRegisters.init();


pub const FunctionArgRegister = enum(u8) {
    ret  = 0,
    reg1 = 1,
    reg2 = 2,
    reg3 = 3,
    reg4 = 4,
    reg5 = 5,
    reg6 = 6,
};

pub const FunctionArgRegisters = extern struct {
    ret:  usize,
    reg1: usize,
    reg2: usize,
    reg3: usize,
    reg4: usize,
    reg5: usize,
    reg6: usize,

    pub fn init() FunctionArgRegisters { return .{
        .ret =  0,
        .reg1 = 0,
        .reg2 = 0,
        .reg3 = 0,
        .reg4 = 0,
        .reg5 = 0,
        .reg6 = 0,
    };}

    pub fn set(self: *FunctionArgRegisters, target_register: FunctionArgRegister, value: usize) void { switch (target_register) {
        .ret  => self.ret  = value,
        .reg1 => self.reg1 = value,
        .reg2 => self.reg2 = value,
        .reg3 => self.reg3 = value,
        .reg4 => self.reg4 = value,
        .reg5 => self.reg5 = value,
        .reg6 => self.reg6 = value,
    }}
};
// ==================================
