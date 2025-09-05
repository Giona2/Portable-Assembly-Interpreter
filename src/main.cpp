#include "stdcwc/error.hpp"
#include "stdcwc/fs.hpp"
#include <stdio.h>


int main() {
	stdcwc::File file("/home/jonah/Documents/Programming/C++/iasm_mk4/testing/example.iasm");
	int current_char = file.pull();

	while (current_char != EOF) {
		printf("%d\n", current_char);

		current_char = file.pull();
	}
}
