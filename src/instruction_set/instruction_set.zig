pub const variables  = @import("variables.zig");
pub const arithmetic = @import("arithmetic.zig");
pub const function_arguments = @import("function_arguments.zig");
pub const interface = @import("interface.zig");


const std = @import("std");

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;
    const LoadedVariable = globals.LoadedVariable;

    extern var loaded_variable: LoadedVariable;
    extern var variable_frames: VariableFrames;
    extern var current_byte_address: usize;


//- `stt`|`0x01` : ; Initiate the stack frame
//- `new`|`0x02` : `<size in bytes>` ; Create a new variable
//  - Finds the first variable of the requested size
//- `set`|`0x03` : `<variable index>`, `<value>` ; Set the value of an existing variable
//  - The `pai` will save the size of each variable and will assume the size of the value given. No need for extra fluff
//- `drp`|`0x04` : `<variable index>` ; Drop a variable from the index
//  - This does not delete the existing data, just flags it as available
//- `lod`|`0x05` : `<variable index>` ; Load the value of this variable into a register
//- `ret`|`0x06` : ; Return the value in the loaded register to the given variable. Set the register to the address of the variable given. Set to zero if none is provided
//- `end`|`0x07` : ; End the stack frame
//- `ptr`|`0x08` : `<variable index>` ; Loads the address of the given variable index into the given register
//- `drf`|`0x09` : `<variable index>` ; Gets the value at that pointer
//- `and`|`0x0a` : `<variable index>` ; Bitwise And's the loaded variable to the given variable
//- `_or`|`0x0b` : `<variable index>`
//- `xor`|`0x0c` : `<variable index>`
//- `not`|`0x0d` : `<variable index>`
//- `shl`|`0x0e` : `<variable index>`
//- `shr`|`0x0f` : `<variable index>`
//- `add`|`0x10` : `<variable index>`
//- `sub`|`0x11` : `<variable index>`
//- `mul`|`0x12` : `<variable index>`
//- `div`|`0x13` : `<variable index>`

/// PIASM instruction set
pub const InstructionSet = enum(u8) {
    // ==============
    // == variable ==
    // ==============
    /// Initiate the stack frame
    STT = 0x1,

    /// Set the value of an existing variable
    SET = 0x2,

    /// Load the value of this variable into a register
    LOD = 0x3,

    /// Return the value in the loaded register to the given variable
    ///
    /// Set the register to the address of the variable given
    ///
    /// Set to zero if none is provided
    RET = 0x04,

    /// End the current stack frame
    END = 0x05,

    // =============
    // == bitwise ==
    // =============
    AND = 0x07,

    _OR = 0x08,

    XOR = 0x09,

    NOT = 0x0a,

    SHL = 0x0b,

    SHR = 0x0c,

    // ================
    // == arithmetic ==
    // ================
    /// Add to the currently loaded variable
    ADD = 0x0d,

    /// Subtract from the currently loaded variable
    SUB = 0x0e,

    /// Multiply to the currently loaded variable
    MUL = 0x0f,

    /// Divide from the currently loaded variable
    DIV = 0x10,

    // ===============
    // == functions ==
    // ===============
    /// Argument Register 1
    AR1 = 0xa1,

    /// Argument Register 1
    AR2 = 0xa2,

    /// Argument Register 3
    AR3 = 0xa3,

    /// Argument Register 4
    AR4 = 0xa4,

    /// Argument Register 5
    AR5 = 0xa5,

    /// Argument Register 6
    AR6 = 0xa6,

    /// Call an interface function
    CAL = 0xf0,
};

/// Parses the first four bits of an operation's byte size
///
/// 0b0000
/// 0b |is_pointer| 0 |is_float| |is_direct|
pub const OperationConfig = struct { const This: type = OperationConfig;
    size: u8,
    config: u8,

    const is_pointer_mask: u8 = 0b1000;
    const is_float_mask: u8 = 0b0010;
    const is_direct_mask: u8 = 0b0001;

    /// Parse the current byte as an operation size
    pub fn init_here() This {
        const full_operation: u8 = @as(*u8, @ptrFromInt(current_byte_address)).*;

        const config: u8 = full_operation >> 4;
        const size: u8 = (full_operation << 4) >> 4;
        return .{ .size = size, .config = config };
    }

    pub fn is_pointer(self: *const This) bool {
        return (self.config & is_pointer_mask == is_pointer_mask);
    }

    pub fn is_float(self: *const This) bool {
        return (self.config & is_float_mask == is_float_mask);
    }

    pub fn is_direct(self: *const This) bool {
        return (self.config & is_direct_mask == is_direct_mask);
    }
};

pub fn get_variable_pointer_here(size: usize) []u8 {
    const current_variable_frames = (variable_frames.get_current_frame() catch unreachable).as_slice();

    const variable_index_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address));
    const variable_index = std.mem.readInt(VariableFrames.variable_index_type, variable_index_raw, .little);
    const variable_pointer: []u8 = current_variable_frames[variable_index..variable_index+size];
    std.debug.print("using {d}th variable of {any}\n", .{variable_index, variable_pointer});

    return variable_pointer;
}
