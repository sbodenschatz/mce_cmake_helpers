include_guard()

function(provide_embedded_import TARGET NAMESPACE)
	if(NOT TARGET ${NAMESPACE}${TARGET})
		add_library(${NAMESPACE}${TARGET} INTERFACE IMPORTED GLOBAL)
		target_link_libraries(${NAMESPACE}${TARGET} INTERFACE ${TARGET})
	endif()
endfunction()