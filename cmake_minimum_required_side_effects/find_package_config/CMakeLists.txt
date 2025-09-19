cmake_minimum_required(VERSION 3.24)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake")

project(cmaketest)

# Simulate externally build and installed project
execute_process(COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/build_and_install_MyPkg.cmake COMMAND_ERROR_IS_FATAL ANY)

message("CMAKE_MINIMUM_REQUIRED_VERSION before find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingBefore)
message("CMake policy CMP0140 before find_package call: ${cmp140SettingBefore}")

set(MyPkg_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/MyPkg/build/installed)
find_package(MyPkg REQUIRED)

# CMP0140 is introduced with CMake 3.25

message("CMAKE_MINIMUM_REQUIRED_VERSION after find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingAfter)
message("CMake policy CMP0140 after find_package call: ${cmp140SettingAfter}")
