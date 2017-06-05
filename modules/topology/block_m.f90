! Module for describing a generic block

module Block

    implicit none
    
    type Block_t
        integer :: blockID
        logical :: activeBlock
        real, allocatable, dimension(:, :, :, 3) :: coords
    
    contains
        public :: getId ! Get the id
        public :: isActiveBlock
        public :: isNotActiveBlock
        public :: getCoords

    end type Block_t
        
    interface Block_t
            procedure :: initializeBlock3D
    end interface Block_t

    contains

        subroutine isActiveBlock( object ) result( active )
            type(Block_t), intent( inout ) :: object
            logical, pointer :: active = object%activeBlock .eq. .True.

        end subroutine 

        subroutine isNotActiveBlock( object ) result( active )
            type(Block_t), intent( inout ) :: object
            logical :: active = object%activeBlock .eq. .False.

        end subroutine 

        subroutine setActive( object, val)
            type(Block_n), intent( inout ) :: object
            logical :: val 

            object%active = val

        end subroutine setActive
        
        subroutine initializeBlock3D( object, x, y, z, active ) result(object)

            use Util

            type(Block3D_t) :: object
            logical :: active
            real, dimension(:) :: x, y, z
            integer :: i, j, k ! Loop varibles


            ! Allocate the coords for the ranges
            allocate(object%coords(size(x) * size(y) * size(z) * 4)
            object%active = active

            ! Do the computations for
            call meshgrid(object%coords, x, y, z)

        end subroutine

        !> Routine to return the coordinates from the object
        subroutine getCoord( object ) result( x )
            type( Block3D_t ), intent(in) :: object
            real, dimension(:, :, :, 4) :: x = object%coords

        end subroutine getCoord


end module Block
