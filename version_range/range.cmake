set(versionMin 1)
set(versionMax 2)

if(NOT DEFINED version)
    message(FATAL_ERROR "Please set version variable")
endif()

if(version VERSION_GREATER_EQUAL versionMin AND version VERSION_LESS_EQUAL versionMax)
    message("${version} is in range ${versionMin}...${versionMax}")
else()
    message("${version} is NOT in range ${versionMin}...${versionMax}")
endif()
