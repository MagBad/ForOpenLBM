########################################
# Set up how to compile the source files
########################################

# Add the source files
SET(GRID_src ${SRCGRID}/D2Q9Block.f08 D2Q9BounArray.f08
  D2Q9BoundaryCondition.f08) 

#####################################################
# Add the needed libraries and special compiler flags
#####################################################

add_library(${GRIDLIB} SHARED ${GRID_src})

# add_executable(grid.x grid_p.f08)

