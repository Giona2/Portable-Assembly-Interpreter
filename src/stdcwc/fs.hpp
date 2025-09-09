#pragma once


#include <stdlib.h>
#include <stdio.h>

#include "collections.hpp"


namespace stdcwc {
template<typename T> struct Result;

struct File {
	FILE *file_pointer;

	static Result<File> open(char *path, char *modes);

	/// Reads the entire file to a heap-allocated `String`
	String read() {
		String msg = String::new_();
	}

	/// Pull a byte from the file stream
	///
	/// Returns EOF when the end of a file is reached
	int pull();

	/// Close the underlying file
	void close();
};

}
