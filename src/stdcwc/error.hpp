#pragma once


#include <stdlib.h>


namespace stdcwc {

enum ErrorCode {
	Passed,
	FileNotFound,
};

/// An optional value
template<typename T>
struct Option {
	T result;
	bool is_none;
};

/// A value that may be an error
template<typename T>
struct Result {
	T result;
	ErrorCode error_code;

	/// Gets the underlying value
	///
	/// If this is an error, return `alt` instead
	T unwrap_or(T alt) {
		if (this->error_code == ErrorCode::Passed) {
			return this->result;
		} else {
			return alt;
		}
	}

	/// Gets the underlying value
	///
	/// If this is an error, exit with a predefined error message
	T unwrap() {
		if (this->error_code == ErrorCode::Passed) {
			return this->result;
		} else {
		}
	}
};


/// Displays `msg` to `stderr` then exits the program on code `error_code`
__attribute__((noreturn)) void exit_on_error(char *msg, uint error_code);

/// Return a value that otherwise would return an error
template<typename T>
Result<T> Ok(T inner) {
	return { .result = inner, .error_code = ErrorCode::Passed };
}

/// Return an error in place of a value
template<typename T>
Result<T> Err(ErrorCode error_code) {
	return { .result = NULL, .error_code = error_code };
}

/// Return a value that otherwise wouldn't exist
template<typename T>
Option<T> Some(T inner) {
	return { .result = inner, .is_none = false };
}

/// Return none in place of a value
template<typename T>
Option<T> None() {
	return { .result = NULL, .is_none = true };
}

}
