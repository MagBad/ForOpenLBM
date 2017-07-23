! Module for describing all d2q9 related functions that describe the physical modell

module Distribution_m

  use Settings_m
  use Object_m

  implicit none

  type, extends(object_t) :: Dist_t

    private
    integer :: D ! Number of dimensions
    integer :: Q ! Number of distributions
    integer :: w_alloc, c_alloc = 0
    real( real_w ), allocatable :: weights( : )
    integer( int_w ), allocatable :: nodal_directions(:, :)

  contains
    ! Point to the methods form object_t
    procedure is_defined
    procedure mark_as_defined

    ! New methods
    procedure :: initDistribution
    procedure :: allocateDistribution
    procedure :: deallocateDistribution

 end type Dist_t

  contains

    pure function is_defined( obj ) result( defined )
      class( Dist_t ), intent( in ) :: obj
      logical :: defined

      defined = obj%user_defined

    end function is_defined

    elemental subroutine mark_as_definied( obj )
      class( Dist_t ), intent( inout ) :: obj

      obj%user_defined = .true.

    end subroutine mark_as_definied

    elemental subroutine initDistribution( obj, d, q )
      class( Dist_t ), intent( inout ) :: obj
      integer(int_w), intent( in ) :: d, q

      obj%D = d
      obj%Q = q
      allocate( obj%weights( 1:q ), obj%w_alloc )
      allocate( obj%nodal_directions( 1:d, 1:q ), obj%c_alloc )

    end subroutine

    subroutine deallocateDistribution( obj )
      type( Dist_t ), intent( inout ) :: obj

      deallocate( obj%weights, obj%w_alloc )
      deallocate( obj%nodal_directions, obj%c_alloc )

    end subroutine deallocateDistribution

end module Distribution_m
