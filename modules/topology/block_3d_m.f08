! Module for describing a 3d block

module Block3D

    implicit none

    use Block

    type, extends(Block) :: Block3D_t
        real, dimension(3) :: x

        contains
            procedure :: initializeBlock3D
            procedure :: getCoord

    end type Block3D_t

    contains

        subroutine initializeBlock3D( object, x, active )
            type(Block3D_t), intent(out) :: object
            real, dimension(3) :: x 
            logical :: active

            object%x = x 
            object%active = active

        end subroutine

        subroutine getCoord( object ), result( x )
            type( Block3D_t ), intent(in) :: object
            real, dimension(3) :: x = object%x

        end subroutine getX

end module Block3D