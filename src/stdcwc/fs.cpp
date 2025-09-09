#include "fs.hpp"
#include "error.hpp"
#include <stdlib.h>
#include <stdint.h>
using namespace stdcwc;


Result<File> File::open(char *path, char *modes) {
	FILE *file_pointer = fopen(path, modes);

	if (file_pointer != NULL) {
		return Ok<File>({.file_pointer = file_pointer});
	} else {
		return Err<File>(ErrorCode::FileNotFound);
	}
}

Vec<u_int8_t> File::read() {
		// Initialize the result
		Vec<u_int8_t> result = Vec<u_int8_t>::new_();

		// Pull each character from `this` into the result
		char current_char = this->pull();
		while (current_char != EOF) {
			result.push(current_char);

			current_char = this->pull();
		}

		// Return the result
		return result;
	}

u_int8_t File::pull() {
	// Return the current character
	return fgetc(this->file_pointer);
}

void File::close() {
	fclose(this->file_pointer);
}
