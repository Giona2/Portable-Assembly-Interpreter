#include "stdcwc/stdcwc.hpp"
#include "iasm_instruction_set.hpp"
using namespace stdcwc;


int main() {
	File file = File::open("./testing/example.iasm", "rb").unwrap();
	int current_char = file.pull();

	while (current_char != EOF) {
		switch (current_char) {
			case IASMInstructionSet::SET:
			break;
		}

		current_char = file.pull();
	}

	file.close();
}
