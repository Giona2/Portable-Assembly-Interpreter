#include "iasm_instruction_set.hpp"
#include "stdcwc/fs.hpp"
#include "stdcwc/error.hpp"
using namespace stdcwc;

#include "hardware/function_isolation.hpp"
#include "hardware/register_map.hpp"

#include <stdint.h>


File file;
Vec<u_int8_t> file_content = Vec<u_int8_t>::new_();
volatile u_int8_t *current_byte_instruction;


void execute_program() {
	init_while();
	while (*current_byte_instruction != 0xFF) {
		switch (*current_byte_instruction) {
			case IASMInstructionSet::SET: end_while();
			break;
			_: end_while();
			break;
		}

		init_while();
		current_byte_instruction += 1;
	}
	end_while();
}


int main() {
	file = File::open("./testing/example.iasm", "rb").unwrap();
	file_content = file.read();
	current_byte_instruction = file_content.inner;

	reset_registers();

	execute_program();

	file.close();
}
