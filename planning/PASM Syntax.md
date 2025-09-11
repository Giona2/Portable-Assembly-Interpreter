# Goals
I decided to ditch direct register access, it was much too difficult to work around the compiler's shenanigans (not to meantion that, sense *every* operation needed the registers I was trying to allow access to, it was going to create inevidable conflicts), but stack manipulation will still very much be part of this.  
In general, my goal is to **create the lowest level bytecode format possible**, and the way I see it, direct register access doesn't need to be a direct part of it, as the register's main goal is to pull values from memory, operate on them, and store them back in to memory.  
That being said, here's a comprehensive list of what I'd like to accomplish:
- Direct stack manipulation
- Basic set of instructions for bitwise operations, basic arithmetic, and control flow
- First iteration of my interface API

# Interface API
The interface will be baked into the interpreter. The alternative would've been making it in iasm, but I'd have to completely flesh out the language first which is entirely unrealistic.  
I'll be adding API functionality as-needed

# Function Management
Six function arg registers will be available for the sole purpose of passing arguments to functions and handling return statements.  
A seventh function register will also be provided that handles the return value of the function

# Instruction Set
## Stack/Variable management
- `new`|`0x1` : `<size in bytes>` ; Create a new variable
	- Finds the first variable of the requested size
- `set`|`0x2` : `<variable index>`, `<value>` ; Set the value of an existing variable
  - The `pai` will save the size of each variable and will assume the size of the value given. No need for extra fluff
- `drp`|`0x3` : `<variable index>` ; Drop a variable from the index
  - This does not delete the existing data, just flags it as available
- `lod`|`0x4` : `<variable index>` ; Load the value of this variable into a register
- `ret`|`0x5` : ; Return that variable back to its place in memory

## Pointer Management
- `ptr`|`0x06` : `<variable index>` ; Gets the pointer of the given variable
- `drf`|`0x07` : ... ; Gets the value at that pointer

## Bitwise Operations
- `and`|`0x08` : `<variable index>` ; Bitwise And's the loaded variable to the given variable
- `_or`|`0x09` : `<variable index>`
- `xor`|`0x0a` : `<variable index>`
- `not`|`0x0b` : `<variable index>`
- `shl`|`0x0c` : `<variable index>`
- `shr`|`0x0d` : `<variable index>`

## Arithmetic Operations
- `add`|`0x0e` : `<variable index>`
- `sub`|`0x0f` : `<variable index>`
- `mul`|`0x10` : `<variable index>`
- `div`|`0x11` : `<variable index>`
