include_guard()

include(CollectTargets)

function(define_component_install_targets)
	collect_default_targets_recursive(DIR_TARGETS)
	foreach(COMP ${ARGN})
		add_custom_target(
			install-${COMP}
			DEPENDS ${DIR_TARGETS}
			COMMAND
				"${CMAKE_COMMAND}" -DCMAKE_INSTALL_COMPONENT=${COMP} -DCMAKE_INSTALL_CONFIG_NAME="$<CONFIG>" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_install.cmake"
		)
	endforeach()
endfunction()
