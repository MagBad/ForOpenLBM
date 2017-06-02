project(test1 Fortran)

file(GLOB pf_files "*.pf")

set(testSuites ${PROJECT_BINARY_DIR}/generated/testSuites.inc)

file(WRITE ${testSuites} "")

set(_test_sources)
foreach(pf ${pf_files})
    get_filename_component(_test ${pf} NAME_WE)
    message(STATUS "Adding test ${_test}")
    set(test_dependency ${PROJECT_SOURCE_DIR}/${_test}.pf)
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/generated/${_test}.F90
        COMMAND python ${PFUNIT_DIR}/bin/pFUnitParser.py ${PROJECT_SOURCE_DIR}/${_test}.pf ${PROJECT_BINARY_DIR}/generated/${_test}.F90
        DEPENDS ${test_dependency}
    )
    set(_test_sources ${_test_sources} ${PROJECT_BINARY_DIR}/generated/${_test}.F90)
    file(APPEND ${testSuites} "ADD_TEST_SUITE(${_test}_suite)\n")
endforeach()

set_source_files_properties(${PFUNIT_DIR}/include/driver.F90 PROPERTIES GENERATED 1)

# pfunit -- especially without MPI, has some unused variables. We don't want to
# bother the user with this.
IF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")
    string(REGEX REPLACE " -Wall" "" CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG}")
ELSEIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel")
    set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -diag-disable 7712")
ENDIF(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")

include_directories(
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_BINARY_DIR}/generated
    ${PFUNIT_DIR}/include
    ${PFUNIT_DIR}/mod
)

add_executable(
    ${PROJECT_NAME}
    ${PFUNIT_DIR}/include/driver.F90
    ${_test_sources}
)

target_link_libraries(
    ${PROJECT_NAME}
    ${PFUNIT_DIR}/lib/libpfunit.a
    mod1
)

install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib/static)
