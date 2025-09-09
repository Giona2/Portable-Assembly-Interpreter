#include "iasm_instruction_set.hpp"


size_t register_buffer[4];


void instruction_set() {
	// Move to the set value
	current_byte_instruction += 2;

	// Check if the value is a register or a literal
	switch (*current_byte_instruction) {
		case IASMInstructionSet::LITERAL:
			// Move to the actual number
			current_byte_instruction += 1;

			// Set the register buffer to the given value
			register_buffer[0] = *(size_t *)current_byte_instruction;

			// Move the current byte back to the literal indicator
			current_byte_instruction -= 2;
		break;
	}

	// Check what register the current byte instruction is
	switch (*current_byte_instruction) {
		case IASMInstructionSet::IREG_0:
		break;
	}
}
