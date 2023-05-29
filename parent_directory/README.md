# How to get the parent directory of a directory

The task is to get the parent directory of a given directory where the given
directory is already known to be a directory.

An example where the input directory is already known to be a directory
(and not a file) is a target include directory (properties `INCLUDE_DIRECTORIES`
and `INTERFACE_INCLUDE_DIRECTORIES`).

With CMake prior to version 3.20 there is the `get_filename_component` function:

```cmake
get_filename_component(filename_component "${directory}" DIRECTORY)
```

With CMake >= 3.20 `get_filename_component` is deprecated in favor of `cmake_path`.
A naive way would be to directly call this function:

```cmake
cmake_path(GET directory PARENT_PATH cmake_path_naive)
```

But there is a glitch with `cmake_path` when `directory` already contains
a trailing slash ("/").

Calling `target_include_directories` with trailing slashes might be a bad style, but
is still valid. In such a case plain `cmake_path` returns back plain `directory`.

The workaround is to add a "/.." and normalize this new path:

```cmake
set(directory_patched "${directory}/..")
cmake_path(NORMAL_PATH directory_patched)
cmake_path(GET directory_patched PARENT_PATH cmake_path_correct)
```

For `/path/parent/child/` this results in `/path/parent/` for which in turn
`cmake_path(GET directory_patched PARENT_PATH ...)` correctly returns
`/parent/path`.

See `parent_directory.cmake` for an example:

```shell
cmake -P parent_directory.cmake
```
