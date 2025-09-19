const std = @import("std");

const super = @import("instruction_set.zig");
    const get_variable_pointer_here = super.get_variable_pointer_here;
    const OperationConfig = super.OperationConfig;
    const InstructionSet = super.InstructionSet;

const globals = @import("../globals.zig");
    const VariableFrames = globals.VariableFrames;
    const LoadedVariable = globals.LoadedVariable;

    extern var loaded_variable: LoadedVariable;
    extern var variable_frames: VariableFrames;
    extern var current_byte_address: usize;


fn perform_operation_on_float(given_instruction: InstructionSet, value: f64) void { switch (given_instruction) {
    InstructionSet.ADD => loaded_variable.as_f64().* += value,
    InstructionSet.SUB => loaded_variable.as_f64().* -= value,
    InstructionSet.MUL => loaded_variable.as_f64().* *= value,
    InstructionSet.DIV => loaded_variable.as_f64().* /= value,
    else => { @panic("unsupported"); }
}}

fn perform_operation_on_int(given_instruction: InstructionSet, value: isize) void { switch (given_instruction) {
    InstructionSet.ADD => loaded_variable.as_isize().* += value,
    InstructionSet.SUB => loaded_variable.as_isize().* -= value,
    InstructionSet.MUL => loaded_variable.as_isize().* *= value,
    InstructionSet.DIV => @panic("The DIV instruction only supports floating point numbers"),
    else => { @panic("unsupported"); }
}}


pub fn exec_arithmetic_and_bitwise(given_instruction: InstructionSet) void {
    // Get the byte size of the operation
    current_byte_address += 1;
    const operation_config = OperationConfig.init_here();

    // Manipulate the loaded register
    current_byte_address += 1;
    if (operation_config.is_direct()) {
        // Read the value given
        const added_value_raw: [*]u8 = @ptrFromInt(current_byte_address);

        // Add the value given to the loaded variable
        if (operation_config.is_float()) {
            const added_value: f64 = @bitCast(std.mem.readVarInt(u64, added_value_raw[0..operation_config.size], .little));
            perform_operation_on_float(given_instruction, added_value);
        } else {
            const added_value = std.mem.readVarInt(isize, added_value_raw[0..operation_config.size], .little);
            perform_operation_on_int(given_instruction, added_value);
        }

        current_byte_address += operation_config.size - 1;
    } else {
        // Get the src variable pointer
        const variable_pointer = get_variable_pointer_here(operation_config.size);

        // Add the loaded register to the variable content given
        if (operation_config.is_float()) {
            perform_operation_on_float(given_instruction, @bitCast(std.mem.readVarInt(u64, variable_pointer, .little)));
        } else {
            perform_operation_on_int(given_instruction, std.mem.readVarInt(isize, variable_pointer, .little));
        }

        // Move the current byte to the end of the instruction
        current_byte_address += @sizeOf(VariableFrames.variable_index_type) - 1;
    }
}
