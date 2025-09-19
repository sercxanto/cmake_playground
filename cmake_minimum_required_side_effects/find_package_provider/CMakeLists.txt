cmake_minimum_required(VERSION 3.24)

set(CMAKE_PROJECT_TOP_LEVEL_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/simple_provider.cmake")

message("CMAKE_MINIMUM_REQUIRED_VERSION before find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingBefore)
message("CMake policy CMP0140 before find_package call: ${cmp140SettingBefore}")

project(cmaketest)

find_package(MyPkg REQUIRED)

# CMP0140 is introduced with CMake 3.25

message("CMAKE_MINIMUM_REQUIRED_VERSION after find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingAfter)
message("CMake policy CMP0140 after find_package call: ${cmp140SettingAfter}")
