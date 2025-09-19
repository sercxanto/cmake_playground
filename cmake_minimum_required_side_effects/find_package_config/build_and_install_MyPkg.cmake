cmake_minimum_required(VERSION 3.25)

set(MyPkgSourceDir ${CMAKE_CURRENT_LIST_DIR}/MyPkg)
set(MyPkgBuildDir ${CMAKE_CURRENT_LIST_DIR}/MyPkg/build)
set(MyPkgInstallDir ${CMAKE_CURRENT_LIST_DIR}/MyPkg/build/installed)

file(REMOVE_RECURSE ${MyPkgBuildDir})

execute_process(COMMAND ${CMAKE_COMMAND} -S ${MyPkgSourceDir} -B ${MyPkgBuildDir}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND ${CMAKE_COMMAND} --install ${MyPkgBuildDir} --prefix ${MyPkgInstallDir}
    COMMAND_ERROR_IS_FATAL ANY)
