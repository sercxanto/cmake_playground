cmake_minimum_required(VERSION 3.24)

project(MyPkg)

# Define library to export:
add_library(MyPkg_getint INTERFACE)
set_target_properties(MyPkg_getint
        PROPERTIES EXPORT_NAME MyPkg::getint)
target_sources(MyPkg_getint
        PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/MyPkg_getint.h>"
               "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/MyPkg_getint.h>")
target_include_directories(MyPkg_getint
        INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
                  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

# Package install boilerplate:
install(TARGETS MyPkg_getint EXPORT MyPkgConfigExport)
include(GNUInstallDirs)
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/"
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        COMPONENT MyPkg_Development FILES_MATCHING PATTERN "*.h")
set(PACKAGE_IMPORT_TARGET_FILE MyPkgTargets.cmake)
export(EXPORT MyPkgConfigExport
        FILE "${PACKAGE_IMPORT_TARGET_FILE}")
cmake_path(SET configPackageInstallPath "${CMAKE_INSTALL_LIBDIR}/cmake/MyPkg")
install(EXPORT MyPkgConfigExport
        FILE "${PACKAGE_IMPORT_TARGET_FILE}"
        DESTINATION "${configPackageInstallPath}"
        COMPONENT MyPkg_Development)
include(CMakePackageConfigHelpers)
configure_package_config_file("${PROJECT_SOURCE_DIR}/Package.cmake.in"
        MyPkgConfig.cmake
        INSTALL_DESTINATION "${configPackageInstallPath}"
        NO_SET_AND_CHECK_MACRO NO_CHECK_REQUIRED_COMPONENTS_MACRO)
install(FILES "${PROJECT_BINARY_DIR}/MyPkgConfig.cmake"
        DESTINATION "${configPackageInstallPath}"
        COMPONENT MyPkg_Development)
