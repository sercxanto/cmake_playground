cmake_minimum_required(VERSION 3.19)

project(hello_world
        DESCRIPTION "Test project"
        LANGUAGES C)

enable_testing()

add_executable(exe)
target_sources(exe PRIVATE main.c)

add_test(NAME exe_test COMMAND exe)

add_test(NAME helper COMMAND "${CMAKE_COMMAND}" -E echo abc)
