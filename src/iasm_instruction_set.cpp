#include "iasm_instruction_set.hpp"

#include "hardware/register_map.hpp"
#include "hardware/function_isolation.hpp"


size_t register_buffer[4];


void instruction_set() {
	init_switch();

	// Move to the set value
	current_byte_instruction += 1;

	// Check if the value is a register or a literal
	switch (*current_byte_instruction) {
		case IASMInstructionSet::LITERAL:
			// Move to the actual number
			current_byte_instruction += 1;

			// Set the register buffer to the given value
			register_buffer[0] = *(size_t *)current_byte_instruction;

			// Move to the next instruction
			current_byte_instruction += LITERAL_BYTE_SIZE;
		break;
	}

	// Check what register the current byte instruction is
	switch (*current_byte_instruction) {
		case IASMInstructionSet::IREG_0:
			end_switch();
			set_hardware_register_primary();
		break;
	}
}
