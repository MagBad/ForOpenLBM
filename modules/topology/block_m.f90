! Module for describing a generic block

module Block

    implicit none

    type Block_t
        integer :: blockID
        logical :: activeBlock
        real, allocatable, dimension(:, :, :, :) :: coords

    end type Block_t


    interface Block_t
        module procedure initializeBlock
        module procedure isActiveBlock

     end interface Block_t

    contains

      function isActiveBlock( object ) result( active )

        implicit none
        type(Block_t), intent( in ) :: object
        logical :: active

        active = object%activeBlock .eqv. .True.

      end function isActiveBlock

      subroutine setActive( object, val)
          type(Block_t), intent( inout ) :: object
          logical, intent(in) :: val 

          object%activeBlock = val

      end subroutine setActive

      function initializeBlock( x, y, z, active ) result(object)

        use Util
        implicit none

        type(Block_t) :: object
        logical, intent(in) :: active
        real, intent(in), dimension(:) :: x, y, z

        ! Allocate the coords for the ranges
        allocate( object%coords(size(x), size(y), size(z), 3) )
        object%activeBlock = active

        ! Do the computations for
        call meshgrid(object%coords, x, y, z)

      end function initializeBlock

      ! Routine to return the coordinates from the object
      subroutine getCoords( object, x )

        type( Block_t), intent(in) :: object
        real, intent(out), dimension(:, :, :, :) :: x

        x = object%coords

      end subroutine getCoords

end module Block
