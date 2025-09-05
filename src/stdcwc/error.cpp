#include <cstdlib>
#include <stdio.h>


__attribute__((noreturn)) void exit_on_error(char *msg, uint error_code) {
	fprintf(stderr, "%s\n", msg);
	exit(error_code);
}
