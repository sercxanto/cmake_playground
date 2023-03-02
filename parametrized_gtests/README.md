# CMake test names and gtest parametrized tests

Summary:

* CMake can automatically create test names with help of `gtest_discover_tests()`
* The test names should be unique and match the naming in gtest
* CMake misses the test suite names for type-parametrized test suites
* The behavior has been introduced beween CMake version 3.19 and 3.23
* [This patch](https://gitlab.kitware.com/cmake/cmake/-/commit/073dd1bd8131a337d3022a6bdc75af0114588093) seems especially suspicious
* As a result type-parametrized tests cannot be addressed individually any longer

## How to reproduce

```shell
# Build the project
$ cmake -B build
$ cmake --build build

# List the available tests
cd build
ctest -N
```

### CMake 3.19

```
Test project /project/path/build
  Test  #1: SimpleTestsuite.SimpleTest
  Test  #2: TypePrefix/TypeParametrizedTestsuite/char.TypeTest
  Test  #3: TypePrefix/TypeParametrizedTestsuite/int.TypeTest
  Test  #4: TypePrefix/TypeParametrizedTestsuite/unsigned int.TypeTest
  Test  #5: TypePrefix/TypeParametrizedTestsuiteCollision/char.TypeTest
  Test  #6: TypePrefix/TypeParametrizedTestsuiteCollision/int.TypeTest
  Test  #7: TypePrefix/TypeParametrizedTestsuiteCollision/unsigned int.TypeTest
  Test  #8: ValuePrefix/ValueParameterizedTestSuite.ValueTest/1
  Test  #9: ValuePrefix/ValueParameterizedTestSuite.ValueTest/2
  Test #10: ValuePrefix/ValueParameterizedTestSuite.ValueTest/3

Total Tests: 10
```

### CMake 3.23 - 3.25

```
Test project /project/path/build
  Test  #1: SimpleTestsuite.SimpleTest
  Test  #2: TypePrefix.TypeTest<char>
  Test  #3: TypePrefix.TypeTest<int>
  Test  #4: TypePrefix.TypeTest<unsigned int>
  Test  #5: TypePrefix.TypeTest<char>
  Test  #6: TypePrefix.TypeTest<int>
  Test  #7: TypePrefix.TypeTest<unsigned int>
  Test  #8: ValuePrefix/ValueParameterizedTestSuite.ValueTest/1
  Test  #9: ValuePrefix/ValueParameterizedTestSuite.ValueTest/2
  Test #10: ValuePrefix/ValueParameterizedTestSuite.ValueTest/3

Total Tests: 10
```

### gtest raw output

```shell
$ ./testsuite --gtest_list_tests 
Running main() from /.../googletest/src/gtest_main.cc
SimpleTestsuite.
  SimpleTest
TypePrefix/TypeParametrizedTestsuite/0.  # TypeParam = char
  TypeTest
TypePrefix/TypeParametrizedTestsuite/1.  # TypeParam = int
  TypeTest
TypePrefix/TypeParametrizedTestsuite/2.  # TypeParam = unsigned int
  TypeTest
TypePrefix/TypeParametrizedTestsuiteCollision/0.  # TypeParam = char
  TypeTest
TypePrefix/TypeParametrizedTestsuiteCollision/1.  # TypeParam = int
  TypeTest
TypePrefix/TypeParametrizedTestsuiteCollision/2.  # TypeParam = unsigned int
  TypeTest
ValuePrefix/ValueParameterizedTestSuite.
  ValueTest/0  # GetParam() = 1
  ValueTest/1  # GetParam() = 2
  ValueTest/2  # GetParam() = 3
```
