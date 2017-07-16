! Module for describing direction
! mostly empty but needed for easier is patch.

module Direction

    implicit none

    type Direction_t
    end type

    type, extends(Direction_t) :: North
    end type

    type, extends(Direction_t) :: South
    end type

    type, extends(Direction_t) :: West
    end type

    type, extends(Direction_t) :: East
    end type

    type DirectionTuple
        type(Direction_t), allocatable :: directions(:)
    end type


end module Direction
