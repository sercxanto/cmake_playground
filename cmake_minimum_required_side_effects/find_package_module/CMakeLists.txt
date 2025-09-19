cmake_minimum_required(VERSION 3.24)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake")

project(cmaketest)

message("CMAKE_MINIMUM_REQUIRED_VERSION before find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingBefore)
message("CMake policy CMP0140 before find_package call: ${cmp140SettingBefore}")

find_package(MyPkg)

# CMP0140 is introduced with CMake 3.25

message("CMAKE_MINIMUM_REQUIRED_VERSION after find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingAfter)
message("CMake policy CMP0140 after find_package call: ${cmp140SettingAfter}")
