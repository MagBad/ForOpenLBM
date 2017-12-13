! Module for describing all d2q9 related functions that describe the physical modell

module Distribution_m

  use Settings_m
  use Object_m

  implicit none

  type, abstract, extends(object_t) :: Dist_t

    integer :: D ! Number of dimensions
    integer :: Q ! Number of distributions
    logical :: w_alloc, c_alloc = .false.
    real( real_w ), pointer, dimension( : ) :: weights
    integer( int_w ), pointer, dimension(:, :) :: nodal_directions

  contains
    ! New methods
    procedure(initDistInterface), deferred :: initDistribution
    generic :: init_dist => initDistribution

 end type Dist_t

 abstract interface
   subroutine initDistInterface( obj )
     import
     class(Dist_t), intent( inout ) :: obj

   end subroutine initDistInterface
 end interface

end module Distribution_m
