set(GIT_BINARY git CACHE FILEPATH "Git binary to use for version determination.")
set(FALLBACK_VERSION "[unknown version]" CACHE STRING "Fallback version to use if auto-detection fails.")
set(FALLBACK_BRANCH "[unknown branch]" CACHE STRING "Fallback branch name to use if auto-detection fails.")

function(get_version_info)
	execute_process(COMMAND ${GIT_BINARY} describe --tags --always --dirty=-modified 
					WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
					RESULT_VARIABLE GIT_RESULT1
					OUTPUT_VARIABLE GIT_DESCRIBE_VERSION
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(GIT_RESULT1 EQUAL 0)
		message(STATUS "Version (from git describe): " ${GIT_DESCRIBE_VERSION})
		set(BUILD_VERSION ${GIT_DESCRIBE_VERSION})
	else()
		set(BUILD_VERSION ${FALLBACK_VERSION})
	endif()

	execute_process(COMMAND ${GIT_BINARY} rev-parse --abbrev-ref HEAD 
					WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
					RESULT_VARIABLE GIT_RESULT2
					OUTPUT_VARIABLE GIT_BRANCH
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(DEFINED ENV{CI_BUILD_REF_NAME})
		set(BUILD_BRANCH $ENV{CI_BUILD_REF_NAME})
	elseif(GIT_RESULT2 EQUAL 0)
		message(STATUS "Branch (from git rev-parse): " ${GIT_BRANCH})
		set(BUILD_BRANCH ${GIT_BRANCH})
	else()
		set(BUILD_BRANCH ${FALLBACK_BRANCH})
	endif()

	if(BUILD_BRANCH STREQUAL BUILD_VERSION)
		set(BUILD_VERSION_STRING ${BUILD_VERSION})
	else()
		string(CONCAT BUILD_VERSION_STRING ${BUILD_BRANCH} "-" ${BUILD_VERSION})
		message(STATUS "Branch: " ${BUILD_BRANCH})
		message(STATUS "Version: " ${BUILD_VERSION})
		message(STATUS "Version string: " ${BUILD_VERSION_STRING})
	endif()
	set(BUILD_BRANCH ${BUILD_BRANCH} PARENT_SCOPE)
	set(BUILD_VERSION ${BUILD_VERSION} PARENT_SCOPE)
	set(BUILD_VERSION_STRING ${BUILD_VERSION_STRING} PARENT_SCOPE)
	string(REGEX REPLACE "[^0-9]" ";" VERSION_LIST "${BUILD_VERSION}")
	list(GET VERSION_LIST 0 BUILD_VERSION_MAJOR)
	if(BUILD_VERSION_MAJOR STREQUAL "")
		list(REMOVE_AT VERSION_LIST 0)
	endif()
	list(LENGTH VERSION_LIST COMP_COUNT)
	set(COMP_LIST MAJOR MINOR PATCH TWEAK)
	foreach(I RANGE 3)
		list(GET COMP_LIST ${I} COMP)
		if(I LESS COMP_COUNT)
			list(GET VERSION_LIST ${I} BUILD_VERSION_${COMP})
			if(BUILD_VERSION_${COMP} STREQUAL "")
				set(BUILD_VERSION_${COMP} 0)
			endif()
			set(BUILD_VERSION_${COMP} ${BUILD_VERSION_${COMP}} PARENT_SCOPE)
		else()
			set(BUILD_VERSION_${COMP} 0)
			set(BUILD_VERSION_${COMP} 0 PARENT_SCOPE)
		endif()
	endforeach()
	message(STATUS "Version separated: ${BUILD_VERSION_MAJOR}.${BUILD_VERSION_MINOR}.${BUILD_VERSION_PATCH}.${BUILD_VERSION_TWEAK}")
	set(PASS_TO_BOOTSTRAP ${PASS_TO_BOOTSTRAP}
				BUILD_BRANCH
				BUILD_VERSION
				BUILD_VERSION_STRING
				BUILD_VERSION_MAJOR
				BUILD_VERSION_MINOR
				BUILD_VERSION_PATCH
				BUILD_VERSION_TWEAK
			PARENT_SCOPE
		)
endfunction()
