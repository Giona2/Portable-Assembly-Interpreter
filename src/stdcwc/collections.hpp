#pragma once


#include <cstddef>
#include <cstdint>
#include <cstdlib>


namespace stdcwc {
template<typename T> struct Result;
template<typename T> struct Option;
template<typename T> Option<T> None();


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

	/// Create a Vec from a type array
	static Vec<T> from(T from[], size_t len) {
		// Allocate space for the vector
		size_t capacity = len + 1 * sizeof(T);
		T *inner = (T *)malloc(capacity);

		// Copy all content
		for (int i = 0; i < len; i++) inner[i] = from[i];

		// Construct and return the vector
		return {.inner = inner, .len = len, .capacity = capacity};
	}

	/// Create a Vec<char> from a const char * type
	static Vec<char> from_str(const char *from) {
		// Initialize the result
		Vec<char> result = Vec::new_();

		// Push each character from `from` to the result
		const char *current_char = from;
		while (current_char != 0) {
			result.push(*current_char);

			current_char += 1;
		}

		// Return the result
		return result;
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

	void uninit() {
		free(this->inner);
	}
};

}
