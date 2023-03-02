if((NOT DEFINED ENV{QNX_HOST}) OR (NOT DEFINED ENV{QNX_TARGET}))
    message(FATAL_ERROR "Environment variables QNX_HOST and QNX_TARGET must be set.
    # Change into bash mode and source qnxsdp-env.sh like:
    $ bash -i
    $ source /opt/qnx710/qnxsdp-env.sh\n")
endif()

set(CMAKE_SYSTEM_NAME QNX)
set(CMAKE_SYSTEM_VERSION 7.1.0)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_C_COMPILER qcc)
set(CMAKE_CXX_COMPILER qcc)

# Verbose output for qcc frontend, so that we see what qcc is calling behind the scene
set(CMAKE_C_FLAGS_INIT "-v" CACHE STRING "CMAKE_C_FLAGS_INIT")
set(CMAKE_CXX_FLAGS_INIT "-v" CACHE STRING "CMAKE_C_FLAGS_INIT")

# _cxx LLVM (default)
set(CMAKE_C_COMPILER_TARGET   "8.3.0,gcc_ntox86_64")
set(CMAKE_CXX_COMPILER_TARGET "8.3.0,gcc_ntox86_64")

set(CMAKE_SYSROOT $ENV{QNX_TARGET})
