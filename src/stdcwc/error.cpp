#include "error.hpp"

#include <cstdlib>
#include <stdio.h>
#include "collections.hpp"


namespace stdcwc {
__attribute__((noreturn)) void exit_on_error(char *msg, uint error_code) {
	fprintf(stderr, "%s\n", msg);
	exit(error_code);
}


String ErrorCode_get_msg(ErrorCode *self) { switch (*self) {
	case (ErrorCode::FileNotFound):
		return String::from("File could not be found");
	break;

	case (ErrorCode::Passed):
		return String::from("No error was found");
	break;
}}
}
