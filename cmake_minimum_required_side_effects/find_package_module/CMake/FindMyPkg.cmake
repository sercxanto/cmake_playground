cmake_minimum_required(VERSION 3.25)

cmake_policy(GET CMP0140 cmp140DuringFindPackage)
message("CMake policy CMP0140 during find_package: ${cmp140DuringFindPackage}")

set(MyPkg_FOUND TRUE)
