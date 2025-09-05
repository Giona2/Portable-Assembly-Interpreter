#include "stdcwc/fs.hpp"
#include <stdio.h>


int main() {
	stdcwc::File file = stdcwc::File::open("./testing/example.iasm", "rb")
		.unwrap_or(File alt);
	int current_char = file.pull();

	while (current_char != EOF) {
		printf("%d\n", current_char);

		current_char = file.pull();
	}
}
