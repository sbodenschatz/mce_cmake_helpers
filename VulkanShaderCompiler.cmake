function(compile_glsl_to_spirv OUTPUT_LIST)
	set(SPV_LIST)
	foreach(SRC_FILE ${ARGN})
		set(SPV_FILE ${SRC_FILE}.spv)
		add_custom_command(
			OUTPUT ${SPV_FILE}
			COMMAND glslangValidator -V -o ${SPV_FILE} ${CMAKE_CURRENT_SOURCE_DIR}/${SRC_FILE}
			MAIN_DEPENDENCY ${SRC_FILE}
			COMMENT "Compiling GLSL shader \"${SRC_FILE}\" to SPIR-V file \"${SPV_FILE}\""
		)
		list(APPEND SPV_LIST ${SPV_FILE})
	endforeach()
	set(${OUTPUT_LIST} ${SPV_LIST} PARENT_SCOPE)
endfunction()

