project(exe1 Fortran)

file(GLOB ${PROJECT_NAME}_sources "*.f90")

message(STATUS "Sources for Project ${PROJECT_NAME}: ${${PROJECT_NAME}_sources}")

add_executable(${PROJECT_NAME} ${${PROJECT_NAME}_sources})

target_link_libraries(${PROJECT_NAME} mod1)

install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib/static)
