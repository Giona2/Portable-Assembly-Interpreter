# Goals
I decided to ditch direct register access, it was much too difficult to work around the compiler's shenanigans (not to meantion that, sense *every* operation needed the registers I was trying to allow access to, it was going to create inevidable conflicts), but stack manipulation will still very much be part of this.  
In general, my goal is to **create the lowest level bytecode format possible**, and the way I see it, direct register access doesn't need to be a direct part of it, as the register's main goal is to pull values from memory, operate on them, and store them back in to memory.  
That being said, here's a comprehensive list of what I'd like to accomplish:
- Direct stack manipulation
- Basic set of instructions for bitwise operations, basic arithmetic, and control flow
- First iteration of my interface API

# SEE HERE
In its current stage, almost all instructions should take a size (in bytes) for operation. When the first bit in that byte is 1 (0x8_), this indicates that the following variable index should be treated as a pointer.

# Interface API
The interface will be baked into the interpreter. The alternative would've been making it in iasm, but I'd have to completely flesh out the language first which is entirely unrealistic.  
I'll be adding API functionality as-needed

# Function Management
Six function arg registers will be available for the sole purpose of passing arguments to functions and handling return statements.  
**The loaded value now acts as the return register**

# Instruction Set
## Stack/Variable management
- `stt`|`0x01` : `<size in bytes>` ; Initiate the stack frame
- `set`|`0x02` : `<size>`, `<variable index>`, `<value>` ; Set the value of an existing variable
  - The `pai` will save the size of each variable and will assume the size of the value given. No need for extra fluff
- `lod`|`0x03` : `<size>`, `<variable index>` ; Load the value of this variable into a register
- `ret`|`0x04` : `<size>`, `<variable index>` ; Return the value in the loaded register to the given variable. Set the register to the address of the variable given. Set to zero if none is provided
- `end`|`0x05` : ; End the stack frame

## Pointer Management
- `ptr`|`0x06` : `<variable index>` ; Loads the address of the given variable index into the given register

## Bitwise Operations
- `and`|`0x07` : `<size>`, `<variable index>` ; Bitwise And's the loaded variable to the given variable
- `_or`|`0x08` : `<size>`, `<variable index>`
- `xor`|`0x09` : `<size>`, `<variable index>`
- `not`|`0x0a` : `<size>`, `<variable index>`
- `shl`|`0x0b` : `<size>`, `<variable index>`
- `shr`|`0x0c` : `<size>`, `<variable index>`

## Arithmetic Operations
- `add`|`0x0d` : `<size>`, `<variable index>`
- `sub`|`0x0e` : `<size>`, `<variable index>`
- `mul`|`0x0f` : `<size>`, `<variable index>`
- `div`|`0x10` : `<size>`, `<variable index>`

## Function Arguments
- `ar_`|`0xa_` : `<size>`, `<variable index>` ; Sets the value of the given arugment register. `0xa0` Reflects the ret register while `0xa1-0xa6` reflects the argument registers

## Interface Calls
- `cal`|`0xf0` : `<interface call number>` ; Call an interface function
