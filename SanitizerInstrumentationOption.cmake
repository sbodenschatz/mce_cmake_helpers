include_guard()

set(SANITIZER_INSTRUMENTATION OFF CACHE BOOL "Enable instrumentation with ASAN and UBSAN (currently only supported on Linux).")
set(SANITIZER_BLACKLIST "" CACHE FILEPATH "Blacklist file for sanitizers.")

if(SANITIZER_INSTRUMENTATION AND UNIX)
	message(STATUS "Using sanitizer instrumentation.")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address -fsanitize=undefined -lpthread")
	if(SANITIZER_BLACKLIST)
		set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -fsanitize-blacklist=${SANITIZER_BLACKLIST})
	endif()
endif()
