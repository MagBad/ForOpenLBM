! Module to describe a block in 2d

module Block2D

    implicit none
    
    type, extends(Block_t) :: Block2D_t
        ! Position
        real, dimention(2) :: x

        contains
            procedure :: initializeBlock2D
            procedure :: getCoord
    end type 

    contains
        subroutine initializeBlock2D( object, x, active )
            type(Block2D_t), intent(out) :: object
            real, dimension(2) :: x 
            logical :: active

            object%x = x
            object%active = active

        end subroutine

        subroutine getCoord( object ) result( x )
            type(Block2D_t), intent( in ) :: object
            real, dimension(2) :: x = object%getX

        end subroutine

end module Block2D
