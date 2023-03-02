# QNX qcc response files and CMake

Summary:

* CMake automatically generates response files for long command lines which hit the OS specific maxmimum command line length
* Under certain conditions the pathes inside the response files are quoted
* The QNX 7.0 and QNX 7.1 linkers do not understand the quoting and the build fails
* Presumably the problem exists since CMake 3.23

## For QNX 7.1

```shell
$ bash -i
$ . /opt/qnx710/qnxsdp-env.sh
$ cmake --preset=qcc8_qnx710_x86_64
$ cmake --build build/qcc8_qnx710_x86_64 --verbose
```

This results in:

```
/opt/qnx710/host/linux/x86_64/usr/bin/x86_64-pc-nto-qnx7.1.0-ld: cannot find "CMakeFiles/exe.dir/lib/my_library_files_with_hyphen-and-very_long_names_to_trigger_generation_of_response_files_800.c.o"
```

## For QNX 7.0


```shell
$ bash -i
$ . /opt/qnx700/qnxsdp-env.sh
$ cmake --preset=qcc5_qnx7_x86_64
$ cmake --build build/qcc5_qnx7_x86_64 --verbose
```

This results in:

```
/opt/qnx700/host/linux/x86_64/usr/bin/qcc -V5.4.0,gcc_ntox86_64 -Wc,-isysroot,/opt/qnx700/target/qnx7 @CMakeFiles/exe.dir/objects1.rsp -o exe 
/opt/qnx700/host/linux/x86_64/usr/bin/x86_64-pc-nto-qnx7.0.0-ld: cannot find "CMakeFiles/exe.dir/lib/my_library_files_with_hyphen-and-very_long_names_to_trigger_generation_of_response_files_0.c.o": No such file or directory
```

## Root cause

The problem is that the response file contains quoted strings and the QNX linker does not understand the quoting.

Here for example the first lines of `build/qcc8_qnx710_x86_64/CMakeFiles/exe.dir/objects1`:

```
CMakeFiles/exe.dir/main.c.o "CMakeFiles/exe.dir/lib/my_library_files_with_hyphen-and-very_long_names_to_trigger_generation_of_response_files_0.c.o" "CMakeFiles/exe.dir/lib/my_library_files_with_hyphen-and-very_long_names_to_trigger_generation_of_response_files_1.c.o"
```

The reason for the quotation of these strings is the presence of hyphen which causes CMake to escape the strings.

Tested CMake version: 3.25.1

The cross check can be made by disabling hyphen name generation (`NAMES_WITH_HYPHEN=OFF`). Then the response file is generated without the quotation and the QNX linker succeeds:

```
CMakeFiles/exe.dir/main.c.o CMakeFiles/exe.dir/lib/my_library_files_without_hyphen_and_very_long_names_to_trigger_generation_of_response_files_0.c.o CMakeFiles/exe.dir/lib/my_library_files_without_hyphen_and_very_long_names_to_trigger_generation_of_response_files_1.c.o
```

Most likely this behaviour has been introduced with https://gitlab.kitware.com/cmake/cmake/-/merge_requests/6714.

The issue can be reproduced with the "Unix Makefiles" generator. Ninja does not seem to be affected.

## Low level reproduction

The issue can be reproduced on a lower layer by using shell commands see `./lowlevel.sh`:

```shell
$ ./lowlevel.sh
+ qcc -v @/.../responsefile -o exe
cc: looking for gcc_ntox86_64 in /opt/qnx710/host/linux/x86_64/etc/qcc/gcc/8.3.0/gcc_ntox86_64++.conf
cc: looking for gcc_ntox86_64 in /opt/qnx710/host/linux/x86_64/etc/qcc/gcc/8.3.0/gcc_ntox86_64.conf
/opt/qnx710/host/linux/x86_64/usr/bin/x86_64-pc-nto-qnx7.1.0-ld ... ".../main.c" -o exe ...
/opt/qnx710/host/linux/x86_64/usr/bin/x86_64-pc-nto-qnx7.1.0-ld: cannot find "/.../main.c": No such file or directory
```

```shell
$ /opt/qnx710/host/linux/x86_64/usr/bin/x86_64-pc-nto-qnx7.1.0-ld -v
GNU ld (GNU Binutils) 2.32.0.20190627 [Release qnx710 r1541]
```
