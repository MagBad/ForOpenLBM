! Module for describing a generic block

module Block

    implicit none
    type Block_t
        integer :: blockID
        logical :: active
    end

    contains
        subroutine isActive( object ) result( active )
            type(Block_t), intent( inout ) :: object
            logical :: active = object%active .eq. .True.

        end subroutine 

        subroutine isNotActive( object ) result( active )
            type(Block_t), intent( inout ) :: object
            logical :: active = object%active .eq. .False.

        end subroutine 

        subroutine setActive( object, val)
            type(Block_n), intent( inout ) :: object
            logical :: val 

            object%active = val

        end subroutine setActive

end module Block
