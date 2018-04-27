include_guard()

if(NOT DEFINED CMAKE_CONFIGURATION_TYPES)
	set(MCE_CONFIGURATION_TYPES Release Debug MinSizeRel RelWithDebInfo)
	if(NOT CMAKE_BUILD_TYPE IN_LIST MCE_CONFIGURATION_TYPES)
		message(WARNING "No valid BUILD_TYPE given, defaulting to Release. Set CMAKE_BUILD_TYPE to one of {Release,Debug,MinSizeRel,RelWithDebInfo}.")
		set(CMAKE_BUILD_TYPE Release)
	endif()
endif()

if(NOT DEFINED CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX d)
  set(CMAKE_MINSIZEREL_POSTFIX msr)
  set(CMAKE_RELWITHDEBINFO_POSTFIX rd)
endif()

set(CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL MinSizeRel Release "" None)
set(CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO RelWithDebInfo Release "" None)
