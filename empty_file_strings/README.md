# file functions with non existing files

CMake's file functions (at least version 3.25) behaves inconsistently when
called with an empty string.

E.g. the following does fail it just returns an empty string:

```cmake
file(STRINGS "" content)
file(STRINGS "/" content)
file(STRINGS "." content)
```

On the other hand `file(MD5) ...` fails:

```cmake
file(MD5 "." content)
```

See `test.cmake` for an example:

```cmake
cmake -P test.cmake
```
