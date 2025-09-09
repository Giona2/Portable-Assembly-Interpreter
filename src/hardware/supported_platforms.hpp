// Architectures
#if defined (__x86_64__)
	#define AMD_64
#endif

// Operating Systems
#if defined(__linux__)
	#define LINUX
#endif

// Full platforms
#if defined(AMD_64) && defined (LINUX)
	#define LINUX_AMD_64
#endif
