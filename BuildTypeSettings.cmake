include_guard()

if(NOT MSVC)
	if(NOT (CMAKE_BUILD_TYPE STREQUAL Debug) AND NOT (CMAKE_BUILD_TYPE STREQUAL Release))
		set(CMAKE_BUILD_TYPE Release)
	endif()
endif()

if(NOT DEFINED CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX d)
  set(CMAKE_MINSIZEREL_POSTFIX msr)
  set(CMAKE_RELWITHDEBINFO_POSTFIX rd)
endif()