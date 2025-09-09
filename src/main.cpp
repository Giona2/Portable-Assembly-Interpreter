#include <stdio.h>
#include "stdcwc/stdcwc.hpp"


int main() {
	stdcwc::File file = stdcwc::File::open("./testing/example.iasm", "rb")
		.unwrap();
	int current_char = file.pull();

	while (current_char != EOF) {
		printf("%d\n", current_char);

		current_char = file.pull();
	}
}
