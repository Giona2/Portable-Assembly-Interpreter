#include "fs.hpp"
#include "error.hpp"
#include <stdlib.h>
using namespace stdcwc;


File::File(char *file_path) {
	this->file_pointer = fopen(file_path, "rb");
}

Result<int> File::pull() {
	// Increment current character
	this->current_char_index += 1;

	// Return the current character
	return Ok(fgetc(this->file_pointer));
}

File::~File() {
	fclose(this->file_pointer);
}
