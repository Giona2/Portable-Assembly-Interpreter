#pragma once


#include <stdlib.h>
#include <stdio.h>
#include "error.hpp"


namespace stdcwc {

struct File {
	FILE *file_pointer;

	static Result<File> open(char *path, char *modes);

	/// Pull a byte from the file stream
	///
	/// Returns EOF when the end of a file is reached
	int pull();

	/// Deconstruct instance of this
	///
	/// Closes the opened file
	~File();
};

}
