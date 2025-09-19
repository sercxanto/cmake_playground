# cmake_minimum_required and side-effects

Generally `cmake_minimum_required()` should be placed on top of "every" CMake file.

In CMake files which are included "in the usual way" by `include` or `add_subdirectory` the
policies and the variable `CMAKE_MINIMUM_REQUIRED_VERSION` behave like regular directory scoped
variables which means that sub-directories and included files have their own policy scope.

See the documentation for [cmake_minimum_required](https://cmake.org/cmake/help/latest/command/cmake_minimum_required.html)
and [cmake_policy](https://cmake.org/cmake/help/latest/command/cmake_policy.html) for details and exceptions.

When `cmake_minimum_required` is used in toolchain files, `find_package` in config / module mode or in dependency provider files,
the situation is not so clear. The subfolders contain examples to check the behaviour.

## toolchain_file

A `cmake_minimum_required` in the toolchain file does not "infect" the project policy-wise, but regarding the variable
`CMAKE_MINIMUM_REQUIRED_VERSION`:

```shell
cd toolchain_file
cmake -B build --toolchain=gcc.cmake
```

## find_package_module

The same for `find_package` in module mode:

```shell
cd find_package_module
cmake -B build
```

## find_package_config

The same for `find_package` in config mode:

```shell
cd find_package_config
cmake -B build
```

## find_package_provider

A `cmake_minimum_required` at the top of the provider file **does "infect"** the project with `CMAKE_MINIMUM_REQUIRED_VERSION` **and** policy settings:

```shell
cd find_package_provider
cmake -B build
```

This could be fixed by changing `simple_provider.cmake`: Remove `cmake_minimum_required` and use `cmake_policy` inside
the `block()`.
