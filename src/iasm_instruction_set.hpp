#pragma once


#include <sys/types.h>


extern volatile u_int8_t *current_byte_instruction;


const u_int8_t LITERAL_BYTE_SIZE = 4;


/// Instruction set of an iasm binary
enum IASMInstructionSet {
	/// Change the value of a given register
	SET = 0x1,

	LITERAL = 0x20,

	IREG_0 = 0x80,
};

void instruction_set();
