#pragma once


#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include "error.hpp"
using namespace stdcwc;


namespace stdcwc {

template<typename T>
struct Vec {
	T *inner;
	size_t len;
	size_t capacity;

	/// Create an empty Vec
	Vec<T> new_() {
		return {.inner = NULL, .len = 0, .capacity = sizeof(T)};
	};

	/// Create an empty Vec from a type array
	Vec<T> from(T *from, size_t len) {
		return {.inner = from, .len = len, .capacity = len};
	}

	/// Add an element to this vector
	void push(T element) {
		// If the pointer is null, allocate space
		if (this->inner == NULL) {
			this->inner = (T *)malloc(this->capacity);
		}

		// Calculate new size
		this->len += 1;

		// Increase capacity if needed
		if (this->len > capacity) {
			this->capacity *= 2;
			this->inner = (T *)realloc(this->inner, this->capacity);
		}

		// Add the element
		this->inner[this->len-1] = element;
	}

	/// Gets the element at `index`
	///
	/// Retuns `None` if the index is invalid
	Option<T *> get(size_t index) {
		if (index >= this->len) {
			return None<T>();
		} else {
			uintptr_t element_address = (uintptr_t)this->inner;
			element_address += index;
			return Some((T *)element_address);
		}
	}
};


struct String {
	Vec<char> inner;
};

}
