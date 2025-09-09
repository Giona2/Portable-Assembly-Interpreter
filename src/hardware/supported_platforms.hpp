// Architectures
#if defined (__x86_64__)
	#define AMD_64
#endif

// Operating Systems
#if defined(__linux__)
	#define LINUX
#elif defined(_WIN32)
	#define WINDOWS
#endif

// Full platforms
#if defined(AMD_64) && defined (LINUX)
	#define LINUX_AMD_64
#elif defined(AMD_64) && defined(WINDOWS)
	#define WINDOWS_AMD_64
#endif
