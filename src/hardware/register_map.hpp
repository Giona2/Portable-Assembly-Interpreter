#include "supported_platforms.hpp"
#include "sys/types.h"


extern volatile u_int8_t *current_byte_instruction;


#ifdef LINUX_AMD_64
	#define HARDWARE_REGISTER_PRIMARY "%rax"
	#define HARDWARE_REGISTER_ONE     "%rdi"
	#define HARDWARE_REGISTER_TWO     "%rsi"
	#define HARDWARE_REGISTER_THREE   "%rdx"
	#define HARDWARE_REGISTER_FOUR    "%r10"
	#define HARDWARE_REGISTER_FIVE    "%r8"
	#define HARDWARE_REGISTER_SIX     "%r9"
	#define HARDWARE_REGISTER_SEVEN   "%rbx"
#endif

#ifdef AMD_64
	#define HARDWARE_MOV "movq"
#endif

__attribute__((always_inline)) inline void reset_registers() {
	__asm__ volatile (
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_PRIMARY "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_ONE "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_TWO "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_THREE "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_FOUR "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_FIVE "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_SIX "\n"
		HARDWARE_MOV " $0, " HARDWARE_REGISTER_SEVEN "\n"
	);
}

/* ===========
 * === Set ===
 * =========== */
 /// Sets this register to the first value in the register buffer
__attribute__((always_inline)) inline void set_hardware_register_primary() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_PRIMARY "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
		: "rax"
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_one() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_ONE "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_two() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_TWO "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_three() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_THREE "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_four() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_FOUR "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_five() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_FIVE "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_six() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_SIX "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
__attribute__((always_inline)) inline void set_hardware_register_seven() {
	#ifdef LINUX_AMD_64

	__asm__ volatile (
		"movq %[buffer_value], %" HARDWARE_REGISTER_SEVEN "\n"
		:
		: [buffer_value] "m" (*current_byte_instruction)
	);

	#endif
}
/* =========== */
