! Module to describe a block in 2d

module Block2D

    implicit none
    
    type, extends(Block_t) :: Block2D_t
        ! Position
        real :: x, y 
    end type 

    contains
        subroutine getX( object ) result( x )
            type(Block_t), intent( in ) :: object
            real :: x = object%getX

        end subroutine

        subroutine getY( object ) result( y )
            type(Block_t), intent( in ) :: object
            real :: y = object%getY

        end subroutine

end module Block2D
