! Module for describing a 3d block

module Block3D

    implicit none

    use Block

    type extends(Block) :: Block3D_t
        real :: x, y, z
    end type Block3D_t

    contains

        subroutine getX( object ), result( x )
            type( Block3D_t ), intent(in) :: object
            real :: x = object%x

        end subroutine getX
        
        subroutine getY( object ), result( y )
            type( Block3D_t ), intent(in) :: object
            real :: y = object%y

        end subroutine getY
        
        subroutine getZ( object ), result( z )
            type( Block3D_t ), intent(in) :: object
            real :: z = object%z

        end subroutine getZ

end module Block3D