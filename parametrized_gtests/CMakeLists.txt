cmake_minimum_required(VERSION 3.19)
project(ctest_mwe)

set(CMAKE_CXX_STANDARD 14)

include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG 4c9a3bb62bf3ba1f1010bf96f9c8ed767b363774
)
FetchContent_MakeAvailable(googletest)

add_executable(testsuite testsuite.cpp)
target_link_libraries(testsuite gtest_main)

enable_testing()
include(GoogleTest)
gtest_discover_tests(testsuite)
