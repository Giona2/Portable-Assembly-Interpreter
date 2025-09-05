from itertools import chain
import subprocess
import os
import sys
import glob


COMPILER               =  "gcc"
BUILD_DIR              =  "./build"
OUT_DIR                = f"{BUILD_DIR}/a.out"
COMPILE_FLAGS_FILE_DIR =  "./compile_flags.txt"


# Build build directory
try:
    os.mkdir(BUILD_DIR)
except FileExistsError:
    ...

# Get source code paths
source_files = glob.glob("./src/**/*.cpp", recursive=True)

# Get compile flags
compile_flags: list[str] = []
with open(COMPILE_FLAGS_FILE_DIR, 'r') as compile_flags_file:
    for flag in compile_flags_file.readlines():
        compile_flags.append(flag.replace('\n', ''))

# Compile source code paths
compiler_command = list(chain.from_iterable([[COMPILER], source_files, compile_flags, ['-o'], [OUT_DIR]]))
result = subprocess.run(compiler_command)
if result.returncode != 0:
    sys.exit(-1)
