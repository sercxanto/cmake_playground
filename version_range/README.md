# Major version ranges in CMake

```shell
$ cmake -B build
-- Found Dummy200: 2.0.0 (found suitable version "2.0.0", required range is "1...2") 
-- Could NOT find Dummy210: Found unsuitable version "2.1.0", required range is "1...2" (found 2.1.0)
-- Found Dummy210: 2.1.0 (found suitable version "2.1.0", required range is "1...<3") 
```

```shell
$ cmake -D version="2.1" -P range.cmake 
2.1 is NOT in range 1...2
$ cmake -D version="2.0" -P range.cmake 
2.0 is in range 1...2
```

Other semver libraries handle version ranges differently:

```shell
npm install node-semver
nodejs range.js
```