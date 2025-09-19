cmake_minimum_required(VERSION 3.24)

message("CMAKE_MINIMUM_REQUIRED_VERSION before project call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")

cmake_policy(GET CMP0140 cmp140SettingBefore)
message("CMake policy CMP0140 before project call: ${cmp140SettingBefore}")

project(cmaketest)

# CMP0140 is introduced with CMake 3.25

message("CMAKE_MINIMUM_REQUIRED_VERSION after project call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
cmake_policy(GET CMP0140 cmp140SettingAfter)
message("CMake policy CMP0140 after project call: ${cmp140SettingAfter}")
