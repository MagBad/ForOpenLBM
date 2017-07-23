! Module for describing a generic block

module Block

    implicit none

    type, abstract :: Block_t
      logical :: activeBlock

      contains
        ! Declaring the interface for the allocation of child objects
        procedure(initBlockInterface), deferred :: initBlock_abs
        procedure(isActiveBlockInterface), deferred :: isActiveBlock_abs
        procedure(setActiveInterface), deferred :: setActive_abs
        generic :: initBlock => initBlock_abs
        generic :: isActiveBlock => isActiveBlock_abs
        generic :: setActive => setActive_abs

     end type Block_t

     interface
        ! Interface for the Block_t allocation
        subroutine initBlockInterface( self, active )
          import
          class(Block_t), intent(inout) :: self
          logical, intent(in) :: active

        end subroutine initBlockInterface

        function isActiveBlockInterface( self ) result( active )
          import
          class(Block_t), intent(in) :: self
          logical :: active

        end function isActiveBlockInterface

        function setActiveInterface( self )
            import
            class(Block_t), intent(inout) :: self
        end  function setActiveInterface
     end interface

end module Block
