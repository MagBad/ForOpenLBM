! Abstract object for error recursion

module Object_m

  implicit none

  type, abstract :: object_t
    logical :: user_defined = .false.

    contains
      procedure(isDefinedInterface), deferred :: is_defined
      procedure(markAsDefinedInterface), deferred :: mark_as_defined
      generic :: isDefined => is_defined
      generic :: markAsDefined => mark_as_defined

  end type object_t

  abstract interface
    pure function isDefinedInterface(obj) result( defined )
        import
        class( object_t ), intent( in ) :: obj
        logical :: defined

    end function isDefinedInterface

    elemental subroutine markAsDefinedInterface(obj)
      import
      class( object_t ), intent( inout ) :: obj

    end subroutine markAsDefinedInterface
  end interface


end module Object_m
