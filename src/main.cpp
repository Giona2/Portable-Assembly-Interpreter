#include "stdcwc/fs.hpp"
#include "stdcwc/collections.hpp"
#include <stdio.h>
using namespace stdcwc;


int main() {
	String msg = String::from("hello\n");

	printf("%s", msg.inner);

	/*
	stdcwc::File file = stdcwc::File::open("./testing/example.iasm", "rb")
		.unwrap_or(File alt);
	int current_char = file.pull();

	while (current_char != EOF) {
		printf("%d\n", current_char);

		current_char = file.pull();
	}
	*/
}
