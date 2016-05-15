# ubirch Kinetis SDK package

This is a [CMake](https://cmake.org) package for the [Kinetis SDK](kex.freescale.com/en/). It
creates a Kinetis SDK library target (ksdk20) as well as targets for some of the middleware (i.e. mmcau)
found in the SDK. Packages can then be found by other CMake projects using `find_package()`.

> &#9888; To use this package you will need to download the __Kinetis SDK 2.0__ from [kex.nxp.com]()
> and tell CMake where to find it.

## Building

1. Checkout the [ubirch-arm-toolchain](https://gitlab.com/ubirch/ubirch-arm-toolchain)
2. Download the Kinetis SDK 2.0 ([kex.nxp.com]())
3. Create a build directory:
    ```
    mkdir build
    cd build
    ```
3. Run cmake (providing the toolchain, the SDK root as well as the target MCU):
    ```
    cmake \
      -DCMAKE_TOOLCHAIN_FILE=<toolchain-dir>/cmake/ubirch-arm-toolchain.cmake \
      -DSDK_ROOT=<sdk-dir> \
      -DMCU=MK82F25615
    ```
4. Run make
    ```
    make
    ```

> If you want to build all different configuration types (`Debug`, `Release`, `MinSizeRel`, ...)
> you need to create a build directory for every configuration and run `cmake` with an extra
> argument `-DCMAKE_BUILD_TYPE=<build-type>` as well as `make`.

## Contents

- `cmake`
  - `KinetisMiddleware.cmake` - macros to configure middleware targets
  - `KinetisSDK.cmake` - macro to configure the Kinetis SDK target and compile options
  - `KinetisSDKUtils.cmake` - macros for identifying and configuring SDK and MCU
- `CMakeLists.txt` - package build file
- `build.sh` - default build file, creating a sub directory `build` and runs `cmake` and `make`

## License

If not otherwise noted in the individual files, the code in this repository is

__Copyright &copy; 2016 [ubirch](http://ubirch.com) GmbH, Author: Matthias L. Jugel__

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```





