const hardware = @import("../hardware/hardware.zig");
    const registers = hardware.registers;

const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;
    const AddressBuffer = globals.AddressBuffer;

    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;
    extern var address_buffer: AddressBuffer;

const default_variable_size = @import("variables.zig").default_variable_size;


pub fn exec_add() void {
    // Move to the value to add to
    current_byte_address += 1;
    const added_value = @as(*default_variable_size, @ptrFromInt(current_variable_frame)).*;

    // Add this value to the loaded register
    asm volatile (
        "add %[added_value], %r10"
        :
        : [added_value] "r" (added_value)
        : "memory", "r10"
    );

    // Move to the last byte in the declaration
    current_byte_address += @sizeOf(default_variable_size);
}
