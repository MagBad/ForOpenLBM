!  Module to descibe a super class for a 2d patch

module Patch2D

    implicit none

    type patch2D_t
        type(patch_t) :: parent
        type(patch_t), dimension(1, *) :: childs

    end type patch2D_t
    
    contains
        interface
            subroutine  addBlock2D( block_2D )
            
        end interface !

end module Patch2D
