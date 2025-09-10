# Goal
Create a compilation target that can run on %75 of binary machines
## Requirements
- At least eight registers
- At least 16 bits

# Example file
```iasm
.data:
msg db "Hey", 0

.text:
mov   reg[0], msg
inter display

mov   reg[0], 0
inter exit
```

# Register Manipulation
There are eight available registers, `reg[0]`-`reg[7]`
```iasm
mov reg[0] 7  ; mov rax, 7
mov reg[1] 15 ; mov rdi, 15
```
To use a specific denomination of the register, add the name of the denomination after the register name
- `byte`: 8 bit
- `word`: 16 bit
```iasm
mov reg_byte[0] 8 ; mov al, 8
mov reg_word[1] 7 ; mov di, 7
```
To use floating point registers, the `fpreg` keyword is used
The same rules as above apply to FP registers
```iasm
mov fpreg[0] 8.0 
div fpreg[0] 4.0 ; fpreg: 2.0
```

# Stack/local variable storage
- To represent the stack, a stack keyword will be used. In order to "call a function," the combination of `stack init` and `jmp <line num of function>` must be used
- When a function is returned, use a combination of `stack return` and `jmp <line num of parent function>` must be used
- To create a variable, call `stack new <number of bytes>`
*note that `iai` will automatically align the stack before new function calls or return statements*
- To access a variable, call `stack get <return register> <variable index>`. This will return the pointer to the variable

# Pointer management
Get data at pointer:
```asm
mov rdi, [rbp+8]
```
```iasm
stack get reg[0] 0
get reg[1] reg[0]
```
Get pointer of data:
```asm
lea rdi, [rbp+8]
```
```iasm
stack get reg[0] 0
pntr reg[1] reg[0]
```

# CPU instruction handling
## Arithmetic
- Set value `set`:`0x1`
- Addition, `add`:`0x2`
    ```iasm
    mov reg[0] 2
    add reg[0] 1
    ; reg[0] = 3
    ```
- Subtraction, `sub`:`0x3`
    ```iasm
    mov reg[0] 2
    sub reg[0] 1
    ; reg[0] = 1
    ```
- Multiplication, `mul`:`0x4`
    ```iasm
    mov reg[0] 2
    sub reg[0] 1
    ; reg[0] = 1
    ```
- Division, `div`:`0x5` *Note that the `div` command can only operate on floating-point or fixed-point numbers*
    ```iasm
    mov fpreg[0] 8.0 
    div fpreg[0] 4.0 ; fpreg: 2.0
    ```
## Bitwise Operations
- AND, `and`:`0x6`
- OR, `or`:`0x7`
- XOR, `xor`:`0x8`
- NOT, `not`:`0x9`
- Left Shift, `SHL`:`0xa`
- Right Shift, `SHR`:`0xb`
## Pointer Handling
- Access data at pointer, `get <return register> <address>`:`0xc`
- Get pointer of data, `pntr <return register> <address>`:`0xd`
## Control Flow
- Check if equal to, `cmpe <register> <register>`:`0xe 0x1`
- Check if not equal to, `cmpne <register> <register>`:`0xe 0x2`
- Check if greater than, `cmpg <register> <register>`:`0xe 0x3`
- Check if greater than or equal to, `cmpge <register> <register>`:`0xe 0x4`
- Check if less than, `cmpl <register> <register>`:`0xe 0x5`
- Check if less than or equal to, `cmple <register> <register>`:`0xe 0x6`
- Unconditional jump, `jmp <line number>`:`0xf 0x1`
- Jump if true, `jt <line number>`:`0xf 0x2`
- Jump if false, `jf <line number>`:`0xf 0x3`
## Data Handling
- Initiate stack, `stack init`:`0x40 0x1`
- Add a variable, `stack add <variable size>`:`0x40 0x2`
- Get a variable, `stack get <return register> <variable index>`:`0x40 0x3`
- End stack frame, `stack return`:`0x40 0xfe`
## Register
- Format (integer register), `0x8<index> <byte denomination>`
- Format (float register),   `0x9<index> <byte denomination>`
- Byte denominations
    - `0x_0`:Entire register
    - `0x_1`:Byte register
    - `0x_2`:Word register
- Example
    ```iasm
    1 80 0 20 3   ; mov ireg[0] 3
    1 91 2 21 3.0 ; mov freg_byte[2] 3.0
    ```
## Literals
- Defines a number
- Format, `0x20 <4 byte number>`
    - `0x20`: Full byte size
