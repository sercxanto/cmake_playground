# cmake-gui and cache variables

cmake-gui and `cmake -LA ...` only show cache variables that have a type specifier.

This can be reproduced with CMake 3.27.x and 3.31.2 and is related to
[CMake issue 23721](https://gitlab.kitware.com/cmake/cmake/-/issues/23721).

See below for different cases and workarounds:

## Without type

```shell
cmake --preset=without_type -D FOOBAR=1
cmake-gui build/without_type
cmake -B build/without_type -LA
```

cmake-gui lists the following variables when "Advanced" is checked:

- `CMAKE_EXPORT_BUILD_DATABASE`
- `CMAKE_EXPORT_COMPILE_COMMANDS`
- `CMAKE_INSTALL_PREFIX`
- `CMAKE_MAKE_PROGRAM`
- `CMAKE_SKIP_INSTALL_RPATH`
- `CMAKE_VERBOSE_MAKEFILE`

After clicking "configure" in cmake-gui the file `CMakeCache.txt` is rewritten and the entries
`CMAKE_BUILD_TYPE`, `CMAKE_PROJECT_TOP_LEVEL_INCLUDES` and `FOOBAR` are removed.

`cmake -LA` shows the same variables as cmake-gui.

When in cmake-gui the CMake preset is manually set to `without_type` also `CMAKE_BUILD_TYPE` and `CMAKE_PROJECT_TOP_LEVEL_INCLUDES` are shown, but not `FOOBAR`.

## With type

```shell
cmake --preset=with_type -D FOOBAR=1
cmake-gui build/with_type
cmake -B build/with_type -LA
```

cmake-gui lists the following variables when "Advanced" is checked:

- `CMAKE_EXPORT_BUILD_DATABASE`
- `CMAKE_EXPORT_COMPILE_COMMANDS`
- `CMAKE_INSTALL_PREFIX`
- `CMAKE_MAKE_PROGRAM`
- `CMAKE_PROJECT_TOP_LEVEL_INCLUDES`
- `CMAKE_SKIP_INSTALL_RPATH`
- `CMAKE_VERBOSE_MAKEFILE`

`cmake -LA` shows the same variables as cmake-gui.


## Command line only

```shell
cmake -B build/cmdline -D FOOBAR:STRING=1
cmake-gui build/cmdline
cmake -B build/cmdline -LA
```

FOOBAR is shown in cmake gui and with `cmake -LA`.


## Workarounds

- Always provide a type
