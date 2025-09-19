cmake_minimum_required(VERSION 3.24)

project(MyPkg)

# Define library to export:
add_library(MyPkg_getint INTERFACE)
add_library(MyPkg::getint ALIAS MyPkg_getint)
set_target_properties(MyPkg_getint
        PROPERTIES EXPORT_NAME MyPkg::getint)
target_sources(MyPkg_getint
        PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/MyPkg_getint.h>"
               "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/MyPkg_getint.h>")
target_include_directories(MyPkg_getint
        INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
                  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")
