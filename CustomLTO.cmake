include_guard()

set(USE_CUSTOM_LTO ON CACHE BOOL "Enable link-time optimization (see CustomLTO local module).")

if(MSVC AND USE_CUSTOM_LTO)
	foreach(CONF RELEASE MINSIZEREL RELWITHDEBINFO)
		set(CMAKE_EXE_LINKER_FLAGS_${CONF} "${CMAKE_EXE_LINKER_FLAGS_${CONF}} /LTCG:incremental /INCREMENTAL:NO /OPT:REF")
		set(CMAKE_STATIC_LINKER_FLAGS_${CONF} "${CMAKE_STATIC_LINKER_FLAGS_${CONF}} /LTCG:incremental")
		set(CMAKE_CXX_FLAGS_${CONF} "${CMAKE_CXX_FLAGS_${CONF}} /GL")
	endforeach()
endif()

function(enable_custom_lto TARGET)
	if(MSVC AND USE_CUSTOM_LTO)
		set_target_properties(${TARGET} PROPERTIES LINK_FLAGS_RELEASE "/LTCG:incremental")
		set_target_properties(${TARGET} PROPERTIES LINK_FLAGS_MINSIZEREL "/LTCG:incremental")
		set_target_properties(${TARGET} PROPERTIES LINK_FLAGS_RELWITHDEBINFO "/LTCG:incremental")
	endif()
endfunction()
