const std = @import("std");

const interface = @import("../interface/interface.zig");
    const InterfaceCode = interface.InterfaceCode;

const hardware = @import("../hardware/hardware.zig");
    const stack = hardware.stack;
    const registers = hardware.registers;

const globals = @import("../globals.zig");
    const CurrentVariableFrame = globals.CurrentVariableFrame;
    const CallerVariableFrames = globals.CallerVariableFrames;
    const AddressBuffer = globals.AddressBuffer;

    extern var loaded_variable_value: usize;
    extern var current_variable_frame: CurrentVariableFrame;
    extern var caller_variable_frames: CallerVariableFrames;
    extern var current_byte_address: usize;
    extern var address_buffer: AddressBuffer;

const root = @import("../main.zig");
    const watchdog = root.watchdog;
    const watchdog_logging = root.watchdog_logging;


pub fn exec_cal() void {
    // Get the interface call
    current_byte_address += 1;
    const interface_call: i16 = @as(*i16, @ptrFromInt(current_byte_address)).*;

    // Run the interface call
    switch (@as(InterfaceCode, @enumFromInt(interface_call))) {
        .display => interface.io.display()
    }
}
