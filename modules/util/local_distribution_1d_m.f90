!> This module contains a description of a 1d LBM Distribution. Where each column is one node

module Local_Distribution_1D_m

  use Settings_m
  use Object_m, only: object_t

  type, extends(object_t) :: local_distribution_1d
    real(real_w), allocatable :: f( :, : )

  contains
    procedure :: isDefined
    procedure :: markAsDefined
    procedure :: allocLocalDistribution

  end type local_distribution

contains

  pure function isDefined( obj ) result( defined )
    class( local_distribution ), intent( in ) :: obj
    logical :: defined

    defined = obj%user_defined

  end function isDefined

  elemental subroutine mark_as_defined( obj )
    class( local_distribution ), intent( inout ) :: obj

    obj%user_defined = .TRUE.
  end subroutine mark_as_defined

end module Local_Distribution_1D_m
