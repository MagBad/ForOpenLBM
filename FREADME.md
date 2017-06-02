# Basic CMake Setup for a new Fortran Project

The idea is that you can fork this project into your own system, and you immediately have
a structure and a surrounding CMake environment to compile and test.

#### Note:

This project has been crafted with the scientists of the
Centre of Excellence for Climate System Science in mind.
Feel free to use it, but don't be confused when some parts of this document are
specifically geared towards the computational infrastructure for these scientists.

## Basic usage

After you have cloned this repo, go into its main directory and type the following:

    mkdir RELEASE
    cd RELEASE
    cmake ..
    make -j
    make install

This should build a tiny library `lib/static/liblib1.a` with a single funtion `is_two(n)`
which returns `.T.` if and only if the only parameter is indeed 2, and `.F.` otherwise,
and a single program `bin/exe1` that will write "Hello World" and check for each
number in 1..5 whether this number is indeed 2.

You can also build a `DEBUG` version by just renaming the directory.
In `DEBUG`, several debug options are selected when compiling, and the code is not
optimised.

If you have pFUnit installed, it should also manage to write a unit test `test/test1` that tests the library.

You can run this test by running the following command in your build directory

    make test

You only have to re-run the `cmake` command from above if you add new files or change
any `CMakeLists.txt` files. Otherwise, the `make` commands alone will be enough to
build after code changes.

#### NCI users:

This has been tested on `raijin` at the **NCI** with the following environment:

For serial:

    module purge
    module load cmake intel-fc/16.0.3.210 intel-cc/16.0.3.210
    module use ~access/modules
    module load pfunit/3.2.7-serial

For parallel:

    module purge
    module load cmake intel-fc/16.0.3.210 intel-cc/16.0.3.210 openmpi/1.8.6
    module use ~access/modules
    module load pfunit/3.2.7
    export FC=mpif90

## Writing your own libraries / modules

1. Create a new subdirectory under `modules`.
2. Change the `modules/CMakeLists.txt` to include your new subdirectory.
3. Copy the `modules/lib1/CMakeLists.txt` into your new subdirectory and change the
project name.

## Writing your own executables

1. Create a new subdirectory under `executables`.
2. Modify `executables/CMakeLists.txt` to include your new subdirectory.
3. Copy `executables/exe1/CMakeLists.txt` into your new subdirectory and change
the project name. (Also, you might want to remove the dependency to `mod1`.)

## Writing your own tests

1. Create a new subdirectory under `tests`.
2. Modify `tests/CMakeLists.txt` to include your new subdirectory.
3. Copy `tests/test1/CMakeLists.txt` into your new subdirectory and change
the project name.
4. Ensure that you add a dependency to the library you want to test.
5. Write your `pFUnit` compliant tests into files with the extension `.pf`
6. Add an `add_test()` line to the `CMakeLists.txt` file in the root directory.
