#include "supported_platforms.hpp"


__attribute__((always_inline)) inline void init_while() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "push %rax\n"
    );
    #endif
}

__attribute__((always_inline)) inline void end_while() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "pop %rax\n"
    );
    #endif
}

__attribute__((always_inline)) inline void init_switch() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "push %rax\n"
    );
    #endif
}

__attribute__((always_inline)) inline void end_switch() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "pop %rax\n"
    );
    #endif
}
