import subprocess
import os


subprocess.run(["zig", "build-exe", "src/main.zig", "-O", "ReleaseFast"])

try:
	os.mkdir("./build")
except FileExistsError:
	...

os.rename("./main", "./build/main")
os.remove("./main.o")
