set(packageName "Dummy210")

set(${packageName}_VERSION_MAJOR 2)
set(${packageName}_VERSION_MINOR 1)
set(${packageName}_VERSION_PATCH 0)
string(CONCAT ${packageName}_VERSION
    "${${packageName}_VERSION_MAJOR}."
    "${${packageName}_VERSION_MINOR}."
    "${${packageName}_VERSION_PATCH}")

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(${packageName}
    VERSION_VAR ${packageName}_VERSION
    REQUIRED_VARS ${packageName}_VERSION
    HANDLE_VERSION_RANGE
)

unset(packageName)
