#include <cstdlib>
#include <stdio.h>


/// Displays `msg` to `stderr` then exits the program on code `error_code`
__attribute__((noreturn)) void exit_on_error(char *msg, uint error_code) {
	fprintf(stderr, "%s\n", msg);
	exit(error_code);
}
