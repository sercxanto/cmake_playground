cmake_minimum_required(VERSION 3.19)

project(cmaketest
        DESCRIPTION "A test for CMake"
        LANGUAGES NONE)


function(check_for_test testname)
    if(TEST ${testname})
        message(STATUS "Test '${testname}' exists")
    else()
        message(STATUS "Test '${testname}' does not exist")
    endif()
endfunction()

enable_testing()

add_test(NAME my_test1 COMMAND ${CMAKE_COMMAND} -E echo "Hello test")

add_subdirectory(subdir)
#include(subdir/CMakeLists.txt)


check_for_test(my_test1)
check_for_test(my_test2)
