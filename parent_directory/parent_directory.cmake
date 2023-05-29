# cmake_path is available since CMake 3.20
cmake_minimum_required(VERSION 3.20)

function(print_parent_directory directory)
    message("Parent path of '${directory}':")

    cmake_path(GET directory PARENT_PATH cmake_path_naive)

    set(directory_patched "${directory}/..")
    cmake_path(NORMAL_PATH directory_patched)
    cmake_path(GET directory_patched PARENT_PATH cmake_path_correct)

    get_filename_component(filename_component "${directory}" DIRECTORY)

    message("  cmake_path (naive):     '${cmake_path_naive}'")
    message("  cmake_path:             '${cmake_path_correct}'")
    message("    directory_patched:   '${directory_patched}'")
    message("  get_filename_component: '${filename_component}'")
endfunction()

print_parent_directory("/path/parent/child")
print_parent_directory("/path/parent/child/")
print_parent_directory("parent/child")
print_parent_directory("parent/child/")
