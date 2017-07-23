  ! Module for the description of a block containing coordinates

module CoordinateBlock_m

  use Block

  type, extends(Block_t) :: CoordinateBlock_t
     real, allocatable, dimension(:, :, :, :) :: coords

   contains
        procedure getX
        procedure allocateBlock

  end type CoordinateBlock_t

  contains

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

end module CoordinateBlock_m
