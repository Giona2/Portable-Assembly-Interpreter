#include "stdcwc/fs.hpp"
#include "stdcwc/error.hpp"
#include "hardware/function_isolation.hpp"
#include <stdint.h>
using namespace stdcwc;


int main() {
	File file = File::open("./testing/example.iasm", "rb").unwrap();
	Vec<u_int8_t> file_content = file.read();
	volatile u_int8_t *current_byte_instruction = file_content.inner;

	init_while();
	while (*current_byte_instruction != 0xFF) {
		end_while();

		init_while();
		current_byte_instruction += 1;
	}
	end_while();

	file.close();
}
