cmake_minimum_required(VERSION 3.19)

project(test LANGUAGES NONE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Specifying a major version range in CMake like this makes no sense
find_package(Dummy200 1...2)
find_package(Dummy210 1...2)

# Go one major up and exclude that
find_package(Dummy210 1...<3)
