! Module for util routines and functions

module Util

! Routine for computing a meshgrid
subroutine meshgrid(grid, x, y, z)
    real, dimension(:, :, :, 3), intent(inout) :: grid
    real, dimension(:), intent(in) :: x, y, z
    real :: sX, sY, sZ
    integer :: i

    sX = size(x)
    sY = size(y)
    sZ = size(z)
    
    do i = 1:sZ
        grid(:, :, i, 1) = spread(x, dim = 1, sY)
        grid(:, :, i, 2) = spread(y, dim = 2, sX)
    end do

    do i = 1:sX
        grid(i, :, :, 3) = spread(z, dim = 3, sY )
    end do

end subroutine

end module Util