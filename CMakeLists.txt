cmake_minimum_required(VERSION 3.0)

project(build_test Fortran)

enable_language(Fortran)

# Check whether the user has selected a BUILD_TYPE
IF ("${CMAKE_BUILD_TYPE}" STREQUAL "")

    message(STATUS "Build type not explicitly set. Trying to guess...")
    get_filename_component(BINDIR ${PROJECT_BINARY_DIR} NAME)
    IF (${BINDIR} MATCHES "RELEASE")
        set(CMAKE_BUILD_TYPE "RELEASE")
        message(STATUS "Set to ${CMAKE_BUILD_TYPE}")
    ELSEIF(${BINDIR} MATCHES "DEBUG")
        set(CMAKE_BUILD_TYPE "DEBUG")
        message(STATUS "Set to ${CMAKE_BUILD_TYPE}")
    ELSE()
        message(WARNING "Unable to deduce build type. Use -DCMAKE_BUILD_TYPE=<RELEASE/DEBUG>")
    ENDIF(${BINDIR} MATCHES "RELEASE")

ELSE()
    message(STATUS "Build Type is ${CMAKE_BUILD_TYPE}")
ENDIF("${CMAKE_BUILD_TYPE}" STREQUAL "")

set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/mods)

include_directories(${CMAKE_Fortran_MODULE_DIRECTORY})
file(MAKE_DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY})

set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR})

# if DEBUG requested, set the various debug options.
IF(${CMAKE_BUILD_TYPE} MATCHES "DEBUG")
    set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -O0")
    IF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")
        set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -Wall -fcheck=all -fbacktrace")
    ELSEIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel")
        set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -warn all -check all -traceback")
    ELSE()
        message(WARNING "Unable to determine Compiler ID: ${CMAKE_Fortran_COMPILER_ID}")
    ENDIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")
    message(STATUS "Debug flags for ${CMAKE_Fortran_COMPILER_ID}: ${CMAKE_Fortran_FLAGS_DEBUG}")
ENDIF(${CMAKE_BUILD_TYPE} MATCHES "DEBUG")

set(PFUNIT_DIR $ENV{PFUNIT})
IF(IS_DIRECTORY ${PFUNIT_DIR})
    message(STATUS "pFUnit found in ${PFUNIT_DIR}")

    # If in DEBUG mode, add parameters for test coverage
    IF(${CMAKE_BUILD_TYPE} MATCHES "DEBUG")
        IF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")
            message(STATUS "Adding compile options -fprofile-arcs -ftest-coverage")
            set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -fprofile-arcs -ftest-coverage")
        ELSEIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel")
            set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG}")
        ELSE()
            message(WARNING "Unable to determine Compiler ID: ${CMAKE_Fortran_COMPILER_ID}")
        ENDIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")
    ENDIF(${CMAKE_BUILD_TYPE} MATCHES "DEBUG")


    if (${CMAKE_Fortran_COMPILER} MATCHES "mpi.*")
        message(STATUS "We seem to be parallel, adding OpenMP support")
        #        set(CMAKE_Fortran_COMPILER mpif90)
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -qopenmp")
    endif()
ENDIF(IS_DIRECTORY ${PFUNIT_DIR})

add_subdirectory(modules)
add_subdirectory(executables)

IF(IS_DIRECTORY ${PFUNIT_DIR})
    add_subdirectory(tests)
    enable_testing()
    # Add the tests below
    add_test(NAME Test_is_two COMMAND test1)
ELSE()
    message(WARNING "pFUnit not installed, testing disabled")
ENDIF()
