cmake_minimum_required(VERSION 3.19)

project(cmaketest
        DESCRIPTION "A test for CMake"
        LANGUAGES NONE)

message("FOOBAR: '${FOOBAR}'")
message("CMAKE_BUILD_TYPE: '${CMAKE_BUILD_TYPE}'")
message("CMAKE_PROJECT_TOP_LEVEL_INCLUDES: '${CMAKE_PROJECT_TOP_LEVEL_INCLUDES}")
