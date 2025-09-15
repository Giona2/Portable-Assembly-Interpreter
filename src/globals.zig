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

export var current_variable_frame: CurrentVariableFrame = undefined;

export var caller_variable_frames: CallerVariableFrames = undefined;

const CallerVariableFrames = extern struct {
    inner: Vec(Vec(Variable)),
};

const CurrentVariableFrame = extern struct {
    inner: [maximum_variable_count]Variable = [_]Variable{ .{.is_active = false, .size = 0}**maximum_variable_count },
};

const Variable = extern struct {
    is_active: bool,
    size: i8,
    value: usize,
};
// =========================


// ========================
// === Loading Variables ===
// =========================
// =========================
