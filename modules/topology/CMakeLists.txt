########################################
# Set up how to compile the source files
########################################

# Add the source files
SET(TOPOGY ${SRCTOP}/block_m.f08) 

#####################################################
# Add the needed libraries and special compiler flags
#####################################################

add_library(${TOPLIB} MODULE ${TOPOGY})

