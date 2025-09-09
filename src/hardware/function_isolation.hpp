#include "supported_platforms.hpp"


__attribute__((always_inline)) inline void init_while() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "push %rax\n"   // Use %%rax instead of %rax
    );
    #endif
}

__attribute__((always_inline)) inline void end_while() {
    #ifdef LINUX_AMD_64
    __asm__ volatile (
        "pop %rax\n"   // Use %%rax instead of %rax
    );
    #endif
}
