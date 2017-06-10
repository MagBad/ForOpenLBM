! Module for util routines and functions

module Util

  contains

    ! Routine for computing a meshgrid
    subroutine meshgrid(grid, x, y, z)

      implicit none

      real, allocatable, dimension(:, :, :, :), intent(out) :: grid
      real, dimension(:), intent(in) :: x, y, z
      integer :: sX, sY, sZ
      integer :: i

      sX = size(x, 1)
      sY = size(y, 1)
      sZ = size(z, 1)

      allocate(grid(sX, sY, sZ, 3))

      do i = 1, sZ
          grid(:, :, i, 1) = spread(x, dim = 1, ncopies = sY)
          grid(:, :, i, 2) = spread(y, dim = 2, ncopies = sX)
      end do

      do i = 1, sX
          grid(i, :, :, 3) = spread(z, dim = 1, ncopies = sY )
      end do

    end subroutine meshgrid

end module Util
