include_guard()

set(SANITIZER_INSTRUMENTATION OFF CACHE BOOL "Enable instrumentation with ASAN and UBSAN (currently only supported on Linux).")

if(SANITIZER_INSTRUMENTATION AND UNIX)
	message(STATUS "Using sanitizer instrumentation.")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address -fsanitize=undefined")
    if (${CMAKE_CXX_COMPILER_ID} MATCHES "GNU")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-sanitize=null")
    elseif (${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize-blacklist=${CMAKE_CURRENT_SOURCE_DIR}/sanitizer_blacklist.txt")
    endif ()
endif()