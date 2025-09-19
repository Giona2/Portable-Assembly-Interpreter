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


pub fn exec_add() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();
    std.debug.print("in add\n", .{});

    // Manipulate the loaded register
    current_byte_address += 1;
    if (operation_config.is_direct()) {
        std.debug.print("is direct\n", .{});
        // Read the value given
        const added_value_raw: [*]u8 = @ptrFromInt(current_byte_address);

        // Add the value given to the loaded variable
        if (operation_config.is_float()) {
            const added_value = std.mem.readVarInt(f64, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_f64().* += added_value;
        } else {
            const added_value = std.mem.readVarInt(isize, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_isize().* += added_value;
        }

        current_byte_address += operation_config.size - 1;
    } else {
        // Get the src variable pointer
        const variable_pointer = get_variable_pointer_here(operation_config.size);

        std.debug.print("adding value {any}", .{variable_pointer});

        // Add the loaded register to the variable content given
        loaded_variable.as_isize().* += std.mem.readVarInt(usize, variable_pointer, .little);
        if (operation_config.is_float()) {
            loaded_variable.as_f64().* += std.mem.readVarInt(f64, variable_pointer, .little);
        } else {
            loaded_variable.as_isize().* += std.mem.readVarInt(usize, variable_pointer, .little);
        }

        // Move the current byte to the end of the instruction
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}

pub fn exec_sub() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();
    std.debug.print("in add\n", .{});

    // Manipulate the loaded register
    current_byte_address += 1;
    if (operation_config.is_direct()) {
        std.debug.print("is direct\n", .{});
        // Read the value given
        const added_value_raw: [*]u8 = @ptrFromInt(current_byte_address);

        // Add the value given to the loaded variable
        if (operation_config.is_float()) {
            const added_value = std.mem.readVarInt(f64, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_f64().* -= added_value;
        } else {
            const added_value = std.mem.readVarInt(isize, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_isize().* -= added_value;
        }

        current_byte_address += operation_config.size - 1;
    } else {
        // Get the src variable pointer
        const variable_pointer = get_variable_pointer_here(operation_config.size);

        std.debug.print("adding value {any}", .{variable_pointer});

        // Add the loaded register to the variable content given
        loaded_variable.as_isize().* += std.mem.readVarInt(usize, variable_pointer, .little);
        if (operation_config.is_float()) {
            loaded_variable.as_f64().* -= std.mem.readVarInt(f64, variable_pointer, .little);
        } else {
            loaded_variable.as_isize().* -= std.mem.readVarInt(usize, variable_pointer, .little);
        }

        // Move the current byte to the end of the instruction
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}

pub fn exec_mul() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();
    std.debug.print("in add\n", .{});

    // Manipulate the loaded register
    current_byte_address += 1;
    if (operation_config.is_direct()) {
        std.debug.print("is direct\n", .{});
        // Read the value given
        const added_value_raw: [*]u8 = @ptrFromInt(current_byte_address);

        // Add the value given to the loaded variable
        if (operation_config.is_float()) {
            const added_value = std.mem.readVarInt(f64, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_f64().* *= added_value;
        } else {
            const added_value = std.mem.readVarInt(isize, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_isize().* *= added_value;
        }

        current_byte_address += operation_config.size - 1;
    } else {
        // Get the src variable pointer
        const variable_pointer = get_variable_pointer_here(operation_config.size);

        std.debug.print("adding value {any}", .{variable_pointer});

        // Add the loaded register to the variable content given
        loaded_variable.as_isize().* += std.mem.readVarInt(usize, variable_pointer, .little);
        if (operation_config.is_float()) {
            loaded_variable.as_f64().* *= std.mem.readVarInt(f64, variable_pointer, .little);
        } else {
            loaded_variable.as_isize().* *= std.mem.readVarInt(usize, variable_pointer, .little);
        }

        // Move the current byte to the end of the instruction
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}

pub fn exec_div() void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();
    std.debug.print("in add\n", .{});

    // Manipulate the loaded register
    current_byte_address += 1;
    if (operation_config.is_direct()) {
        std.debug.print("is direct\n", .{});
        // Read the value given
        const added_value_raw: [*]u8 = @ptrFromInt(current_byte_address);

        // Add the value given to the loaded variable
        if (operation_config.is_float()) {
            const added_value = std.mem.readVarInt(f64, added_value_raw[0..operation_config.size], .little);
            loaded_variable.as_f64().* *= added_value;
        } else {
            @panic("The DIV instruction only supports floating point values");
        }

        current_byte_address += operation_config.size - 1;
    } else {
        // Get the src variable pointer
        const variable_pointer = get_variable_pointer_here(operation_config.size);

        std.debug.print("adding value {any}", .{variable_pointer});

        // Add the loaded register to the variable content given
        loaded_variable.as_isize().* += std.mem.readVarInt(usize, variable_pointer, .little);
        if (operation_config.is_float()) {
            loaded_variable.as_f64().* *= std.mem.readVarInt(f64, variable_pointer, .little);
        } else {
            @panic("The DIV instruction only supports floating point values");
        }

        // Move the current byte to the end of the instruction
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}
