project(mod1 Fortran)

file(GLOB ${PROJECT_NAME}_sources "*.f90")

message(STATUS "Sources for project ${PROJECT_NAME}: ${${PROJECT_NAME}_sources}")

add_library(${PROJECT_NAME} STATIC ${${PROJECT_NAME}_sources})

install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib/static)
