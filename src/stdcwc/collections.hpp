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

	Vec(T *inner, size_t len, size_t capacity) : inner(inner), len(len), capacity(capacity) {}

	/// Create an empty Vec
	static Vec<T> new_() {
		return {.inner = NULL, .len = 0, .capacity = sizeof(T)};
	};

	/// Create an empty Vec from a type array
	static Vec<T> from(T from[], size_t len) {
		/// Allocate space for the vector
		size_t capacity = len + 1 * sizeof(T);
		T *inner = (T *)malloc(capacity);

		/// Copy all content
		for (int i = 0; i < len; i++) inner[i] = from[i];

		///
		return {.inner = inner, .len = len, .capacity = capacity};
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
		if (this->len * sizeof(T) >= capacity) {
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
			return None<T *>();
		} else {
			uintptr_t element_address = (uintptr_t)this->inner;
			element_address += index * sizeof(T);
			return Some((T *)element_address);
		}
	}

	~Vec() {
		free(this->inner);
	}
};

struct String : public Vec<char> {
	String(char *inner, size_t capacity, size_t len) : Vec<char>(inner, capacity, len) {

	}

	/// Create an empty Vec from a type array
	static String from(char from[]) {
		/// Allocate space for the vector
		size_t capacity = sizeof(char);
		char *inner = (char *)malloc(capacity);

		/// Copy all content
		int i = 0;
		while (from[i] != 0) {
			// if length reaches capacity, reallocate
			if (i+1 >= capacity) {
				capacity *= 2;
				inner = (char *)realloc(inner, capacity);
			}

			inner[i] = from[i];

			i+=1;
		}

		/// Construct it
		return String(inner, i+1, capacity);
	}
};

}
