#include "stdcwc/fs.hpp"
#include "stdcwc/error.hpp"
#include <cstdio>
using namespace stdcwc;


int main() {
	File file = File::open("./testing/example.iasm", "rb").unwrap();
	Vec<uint> file_content = file.read();
	for (int i = 0; i < file_content.len; i++) { uint *current_char = file_content.get(i).result;
		printf("%u\n", *current_char);
	}

	file.close();
}
