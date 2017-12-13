! Coarray module for the description of a abstract 1D Distribution array
! Hence a one-dimensional strip can have Q-compononts

module Object_1D_Co_m

  implicit none

  type, abstract :: object_co_1d_t
    logical, allocatable, codimension[ *  ] :: user_defined( : )

  contains
    procedure( isDefined ), deferred :: is_defined
    procedure( markAsDefined ), deferred :: mark_as_defined
    generic :: isDefined => is_defined
    generic :: markAsDefined => mark_as_defined

  end type object_co_1d_t

  interface
    pure function isDefined( obj ) result( defined )
      import
      class( object_co_1d_t ), intent( in ) :: obj

    end function isDefined

    elemental subroutine markAsDefined( obj )
      import
      class( object_co_1d_t ), intent( inout ) :: obj

    end subroutine markAsDefined
  end interface

end module Object_1D_Co_m
