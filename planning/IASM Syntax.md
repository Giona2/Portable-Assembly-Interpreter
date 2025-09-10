# Goals
I decided to ditch direct register access, it was much too difficult to work around the compiler's shenanigans (not to meantion that, sense *every* operation needed the registers I was trying to allow access to, it was going to create inevidable conflicts), but stack manipulation will still very much be part of this.  
In general, my goal is to **create the lowest level bytecode format possible**, and the way I see it, direct register access doesn't need to be a direct part of it, as the register's main goal is to pull values from memory, operate on them, and store them back in to memory.  
That being said, here's a comprehensive list of what I'd like to accomplish:
- Direct stack manipulation
- Basic set of instructions for bitwise operations, basic arithmetic, and control flow
- First iteration of my interface API

# Interface API
The interface will be baked into the interpreter. The alternative would've been making it in iasm, but I'd have to completely flesh out the language first which is intirely unrealistic.  
I'll be adding API functionality as-needed
