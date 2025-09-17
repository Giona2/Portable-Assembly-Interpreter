const std = @import("std");

const super = @import("instruction_set.zig");
    const get_variable_pointer_here = super.get_variable_pointer_here;
    const OperationConfig = super.OperationConfig;

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;
    const LoadedVariable = globals.LoadedVariable;

    extern var loaded_variable: LoadedVariable;
    extern var variable_frames: VariableFrames;
    extern var current_byte_address: usize;


pub fn exec_stt() void {
    std.debug.print("Found stt\n", .{});

    // Get the frame size
    current_byte_address += 1;
    const frame_size_raw = @as(*const [@sizeOf(VariableFrames.variable_index_type)]u8, @ptrFromInt(current_byte_address));
    const frame_size = std.mem.readInt(VariableFrames.variable_index_type, frame_size_raw, .little);

    // Create new frame
    variable_frames.start_new_frame(frame_size);

    // Move to the end of the instruction
    current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
}

pub fn exec_set() void {
    std.debug.print("Found set\n", .{});

    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();

    // Get the variable pointer
    current_byte_address += 1;
    const variable_pointer = get_variable_pointer_here(@intCast(operation_config.size));

    // Write the value to the the variable
    std.debug.print("operation config: {d}\n", .{operation_config.config});
    if (operation_config.is_direct()) {
        std.debug.print("is direct\n", .{});
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;

        for (variable_pointer) |*variable_slot| {
            variable_slot.* = @as(*u8, @ptrFromInt(current_byte_address + 1)).*;

            current_byte_address += 1;
        }
    } else {
        std.debug.print("is not direct\n", .{});
        // Get the second variable pointer
        current_byte_address += @sizeOf(VariableFrames.variable_index_type);
        const from_variable_pointer = get_variable_pointer_here(operation_config.size);

        // Memcopy from to to
        for (variable_pointer, 0..) |*variable_slot, index| {
            variable_slot.* = from_variable_pointer[index];
        }

        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}

pub fn exec_lod() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();

    // Get the variable pointer
    current_byte_address += 1;
    const variable_pointer = get_variable_pointer_here(@intCast(operation_config.size));

    // Write this to the loading register
    loaded_variable.set(variable_pointer);

    // Move the current byte to the end of the instrution
    current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
}

pub fn exec_ret() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();

    // Get the variable pointer
    current_byte_address += 1;
    const variable_pointer = get_variable_pointer_here(@intCast(operation_config.size));

    // Set the variable to the value in the loaded variable buffer
    for (variable_pointer, 0..) |*variable_slot, index| {
        variable_slot.* = loaded_variable.inner[index];
    }

    // Move the current byte to the end of the instruction
    current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
}

pub fn exec_end() void {
    variable_frames.end_current_frame();
}
