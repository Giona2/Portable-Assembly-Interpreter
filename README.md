# Table of Contents
* [Description](#description)
* [Portable Assembly Virtual Machine](portable-assembly-virtual-machine)

# Description
Portable Assembly Interpreter is the program responsible for running portable binary (`.pbin`) files outputted by the Portable Assembly Compiler Collection (`pacc`). It accomplishes this by running the application under a lightweight virtual machine called the Portable Assembly Virtual Machine  
  
For details on the language syntax, check out the `pacc` repository to experiment with the Portable Assembly language

# Portable Assembly Virtual Machine
This vm has only three basic parts that make up the bare essentials for running a Portable Binary program

## Variable Frames Buffer
The Variable Frames Buffer is a heap-allocated collection of fixed-sized spaces created for each new function

## Loaded Variable Register
This is an 8 byte "register" that acts only as a region of memory to store information. This is the only data that can be operated upon through arithmetic expression or bitwise operations. Basically, if you want to apply mathmatical functions to a variable, you need to load its data into this register first

## Six Function Variables
These are extra registers whose sole purpose it to load with information to pass between function calls. You connot manipulate them beyond setting their value.
