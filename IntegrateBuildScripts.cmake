include_guard()

if(NOT DEFINED BUILD_SCRIPTS_MAX_LEVELS)
	set(BUILD_SCRIPTS_MAX_LEVELS 5)
endif()

function(make_build_scripts_project SUFFIX)
	file(GLOB_RECURSE BUILD_SCRIPTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*CMake*.txt" "*.cmake")
	list(APPEND BUILD_SCRIPTS ${ARGN})
	list(REMOVE_ITEM BUILD_SCRIPTS "CMakeLists.txt")
	add_custom_target(BUILD_SCRIPTS_${SUFFIX} SOURCES ${BUILD_SCRIPTS})
	source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}" FILES ${BUILD_SCRIPTS})
endfunction()
