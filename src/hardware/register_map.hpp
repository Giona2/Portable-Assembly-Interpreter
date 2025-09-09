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

/// Sets this register to the first value in the register buffer
void set_hardware_register_primary();
void set_hardware_register_one();
void set_hardware_register_two();
void set_hardware_register_three();
void set_hardware_register_four();
void set_hardware_register_five();
void set_hardware_register_six();
void set_hardware_register_seven();
