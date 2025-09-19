# Portable Assembly Interpreter
The Portable Assembly Interpreter (`pai`) is arguably the most important part of the portable assembly toolchain. This tool is what's responsible for running Portable Binary (`.pbin`) files and making them work on a wide variety of computers (at least, in the future).  
  
These docs are meant to explain how `pai` works at a fundamental level. If you would like to expermiment with Portable Assembly, check out the Portable Assembly Compiler Collection docs to learn about the languages built upon by Portable Assembly

# Background Information
These docs assume you have the following background information...
- Knowledge of different computational numerical types (integers, floats, etc.)
- How numbers are stored in a computer byte-per-byte
  
---
  
* [Introduction](introduction.md)
* [Loading Register](loading-register.md)
* [Variable Frame Buffers](variable-frame-buffers.md)
