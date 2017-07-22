! Abstract object for error recursion

module Object_m

  implicit none

  type, abstract :: object_t
    logical :: user_defined = .false.

    contains
      procedure(isDefined), deferred :: is_definied
      procedure(markAsDefinied), deferred :: mark_as_definied
      generic :: isDefined => is_definied
      generic :: markAsDefinied => mark_as_definied

  end type object_t

  interface
    pure function isDefined(obj) result( defined )
        import
        class( object_t ), intent( in ) :: obj
        logical :: defined

    end function isDefined

    elemental subroutine markAsDefinied(obj)
      import
      class( object_t ), intent( inout ) :: obj

    end subroutine markAsDefinied
  end interface


end module Object_m
