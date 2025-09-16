pub const variables  = @import("variables.zig");
pub const arithmetic = @import("arithmetic.zig");
pub const function_arguments = @import("function_arguments.zig");
pub const interface = @import("interface.zig");


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
    /// Initiate the stack frame
    STT = 0x1,

    /// Set the value of an existing variable
    SET = 0x2,

    /// Drop a variable
    ///
    /// Note this does not delete any data, only flags that space as writable
    DRP = 0x3,

    /// Load the value of this variable into a register
    LOD = 0x4,

    /// Return the value in the loaded register to the given variable
    ///
    /// Set the register to the address of the variable given
    ///
    /// Set to zero if none is provided
    RET = 0x05,

    /// End the current stack frame
    END = 0x06,

    /// Add to the currently loaded variable
    ADD = 0x11,

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
