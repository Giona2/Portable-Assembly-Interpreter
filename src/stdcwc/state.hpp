#pragma once


/// Parent class of a possible function return state
enum class State {};

/// A value that may be a specified state
template<typename T>
struct StateResult {
	T result;
	State state;
};
