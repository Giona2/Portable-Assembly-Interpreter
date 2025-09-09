#include "error.hpp"

#include <cstdlib>
#include <stdio.h>
#include "collections.hpp"


namespace stdcwc {
__attribute__((noreturn)) void exit_on_error(char *msg, uint error_code) {
	fprintf(stderr, "%s\n", msg);
	exit(error_code);
}


Vec<char> ErrorCode_get_msg(ErrorCode *self) { switch (*self) {
	case (ErrorCode::FileNotFound):
		return Vec<char>::from_str("File could not be found");
	break;

	case (ErrorCode::Passed):
		return Vec<char>::from_str("No error was found");
	break;
}}
}
