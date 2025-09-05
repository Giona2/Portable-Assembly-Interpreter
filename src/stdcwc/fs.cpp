#include "fs.hpp"
#include "error.hpp"
#include <stdlib.h>
using namespace stdcwc;


Result<File> File::open(char *path, char *modes) {
	FILE *file_pointer = fopen(path, modes);

	if (file_pointer != NULL) {
		return Ok<File>({.file_pointer = file_pointer});
	} else {
		return Err<File>(ErrorCode::FileNotFound);
	}
}

int File::pull() {
	// Return the current character
	return fgetc(this->file_pointer);
}

File::~File() {
	fclose(this->file_pointer);
}
