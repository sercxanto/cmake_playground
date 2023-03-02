cmake_minimum_required(VERSION 3.23)

project(cmaketest
        DESCRIPTION "A test for CMake"
        LANGUAGES C)

set(NUMBER_OF_OBJECT_FILES 800 CACHE STRING "Number of object files to generate")
set(NAMES_WITH_HYPHEN ON CACHE BOOL "Generate names with hyphen")

add_subdirectory(lib)

add_executable(exe)
target_sources(exe PRIVATE main.c)
target_link_libraries(exe PRIVATE my_library)
