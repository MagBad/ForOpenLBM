!> This module contains a description of a 1d LBM Distribution. Where each column is one node

module Local_Distribution_1D_m

  use Settings_m
  use Object_m, only: object_t

  type, extends(object_t) :: local_distribution
    real(real_w), allocatable :: f( :, :)

  contains
    procedure :: is_defined
    procedure :: mark_as_defined

  end type local_distribution

contains
  pure function is_defined( obj ) result( defined )
    class( local_distribution ), intent( in ) :: obj
    logical :: defined

    defined = obj%user_defined

  end function is_defined

  elemental subroutine mark_as_defined( obj )
    class( local_distribution ), intent( inout ) :: obj

    obj%user_defined = .TRUE.
  end subroutine mark_as_defined

end module Local_Distribution_1D_m
