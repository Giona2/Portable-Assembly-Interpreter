#pragma once


#include <stdio.h>
#include <stdlib.h>
#include "error.hpp"


namespace stdcwc {

struct File {
	FILE *file_pointer;
	int current_char_index = -1;

	/// Create new instance of this
	File(char *file_path);

	/// Pull a byte from the file stream
	///
	/// Returns EOF when the end of a file is reached
	Result<int> pull();

	/// Deconstruct instance of this
	///
	/// Closes the opened file
	~File();
};

}
