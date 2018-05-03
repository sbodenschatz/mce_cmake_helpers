if(NOT DEFINED SRC_GROUPS_MAX_LEVELS)
	set(SRC_GROUPS_MAX_LEVELS 5)
endif()

function(make_src_groups_code HEADER_PATH SRC_PATH)
	set(header_globs)
	set(src_globs)
	set(last_header_glob ${HEADER_PATH})
	set(last_src_glob ${SRC_PATH})
	foreach(I RANGE ${SRC_GROUPS_MAX_LEVELS})
		set(last_header_glob "${last_header_glob}/*")
		set(last_src_glob "${last_src_glob}/*")
		list(APPEND header_globs ${last_header_glob})
		list(APPEND src_globs ${last_src_glob})
	endforeach()

	file(GLOB header_dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${HEADER_PATH} ${header_globs})
	file(GLOB src_dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${SRC_PATH} ${src_globs})
	list(APPEND src_dirs ${header_dirs})
	list(REMOVE_DUPLICATES src_dirs)
	foreach(src_dir ${src_dirs})
		if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${SRC_PATH}/${src_dir} OR IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${HEADER_PATH}/${src_dir})
			string(REPLACE / \\ src_grp ${src_dir})
			source_group(${src_grp} REGULAR_EXPRESSION "(${SRC_PATH}/${src_dir}|${HEADER_PATH}/${src_dir})/.*")
		endif()
	endforeach()
endfunction()

function(make_src_groups_dirs)
	set(globs "*")
	set(last_glob "*")
	foreach(I RANGE ${SRC_GROUPS_MAX_LEVELS})
		set(last_glob "${last_glob}/*")
		list(APPEND globs ${last_glob})
	endforeach()
	file(GLOB src_dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${globs})
	foreach(src_dir ${src_dirs})
		if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${src_dir})
			string(REPLACE / \\ src_grp ${src_dir})
			source_group(${src_grp} REGULAR_EXPRESSION "${src_dir}/.*")
		endif()
	endforeach()
endfunction()

