! Module to describe a Patch class, a patch is a leaf/ node in the data
! structure tree

module Patch

    use Block
    implicit none

    type Patch_t
        type(Patch_t), pointer :: parent => NULL
        type(Patch_t), dimension(:), pointer :: children
        type(Patch_t), dimension(:), pointer :: neighbours
        type(Block_t), dimension(:), pointer :: blocks
        integer :: numberOfChildren
        integer :: numberOfBlocks
        integer :: numberOfNeighbours

        contains
            procedure :: initilizePatch
            procedure :: addBlock
            procedure :: deleteBlock
            procedure :: addChild
            procedure :: addNeighbour
            procedure :: getLocalNeighbourBlock
            procedure :: getRemoteNeighbourBlock
            procedure :: adapt

    end type Patch_t

    ! The initialization routine is called from the grid layer
    subroutine initilizePatch( object, numberOfBlocks, &
        numberOfNeighbours, parent)

        type(Patch_t), intent(inout) :: object
        integer :: numberOfBlocks
        integer, optional :: numberOfNeighbours => 0
        type(Block_t), dimension( 1, : ) :: initBlock
        type(Patch_t), dimension( 1, : ) :: children
        type(Patch_t), dimension( 1, : ) :: neighbours
        type(Patch_t), intent(inout), optional :: parent
        logical :: dummyParent = NULL

        object%numberOfBlocks = numberOfBlocks
        object%numberOfNeighbours = numberOfNeighbours

        ! Check the optional value parent
        if( .not. present(parent) ) then
            parent = dummyParent
!
        end if

        ! Assign the possible parent
        object%parent = parent

        ! Allocate the new blocks
        allocate(initBlock(1, numberOfBlocks))
        object%blocks = initBlock

        ! Allocate the neighbours
        allocate(neighbours(1, numberOfNeighbours))
        object%neighbours = neighbours

        ! Allocate the array for storing the children, they're initialized
        ! without any children.
        ! The value is changend in another subroutine
        allocate(childern(1, 1))
        children = NULL
        object%children = children
        object%numberOfChildren = 0

    end subroutine initilizePatch

    subroutine addBlock(object, block)

        type(Patch_t), intent(inout) :: object
        type(Block_t), intent(in) :: block
        type(Block_t), dimension(1,:), allocatable :: tempBlock

        ! Allocate an increased array for the new block
        allocate(tempBlock( 1, object%numberOfBlocks + 1))

        tempBlock( 1:object%numberOfBlocks ) = object%blocks
        tempBlock( object%numberOfBlocks + 1 ) = block

        ! Move the new block to the object, the former block array is deallocated
        call move_alloc(object%blocks, tempBlock )

    end subroutine addBlock

    ! A routine to delete a block, necassary in the 'adapt' routine
    subroutine deleteBlock( object, id )
        type(Patch_t), intent(inout) :: object
        integer, intent(in) :: id

        object%blocks(id) = NULL

    end subroutine deleteBlock

    subroutine addChild( object, child)
        type(Patch_t), intent(inout) :: object
        type(Patch_t), intent(in) :: child
        type(Patch_t), dimension(1, :), allocatable :: tempChild
        logical :: testSz

        ! Test wether the object has children or the number of children is
equal to zero. Then the first children can be moved inside the object without a
new allacation.
        testSz = associated(object%children) .or. object%numberOfChildren .eq. 0

        if(testSz) then
            object%children(1) = child
        else

            ! Allocate the new array
            allocate(tempChild(1, object%numberOfChildren + 1))

            ! Copy the data from the object
            tempChild(1, 1:object%numberOfChildren) = object%children

            ! Move the new pointer to the object and deallocate the previous
array
            call move_alloc( object%children, tempChild )
            object%numberOfChildren = object%numberOfChildren + 1

        end if

    end subroutine addChild

    subroutine addNeighbour( object, neighbour )
        type(Patch_t), intent(inout) :: object
        type(Patch_t), intent(in) :: neighbour
        type(Patch_t), dimension(1, :) :: tempNeighbour
        logical :: testSz

        ! Same precidure as the previous subroutine
        testSz = associated(object%neighbours) .or. object%numberOfNeighbours
.eq. 0
        if( testSz ) then
            object%neighbours = neighbour
        else

            ! Allocate the new array
            allocate(tempNeighbour(1, object%numberOfNeighbours + 1))

            ! Copy the data
            tempNeighbour( 1, object%numberOfNeighbours) = object&neighbours
            call move_alloc( object%neighbours, tempNeighbour )
            object%numberOfNeighbours = object%numberOfNeighbours + 1

        end if

    end subroutine addNeighbour

    subroutine getLocalNeighbourBlock( object )
        ! TODO
    end subroutine getLocalNeighbourBlock

    subroutine getRemoteNeighbourBlock( object )
        ! TODO
    end subroutine getRemoteNeighbourBlock

    subroutine adapt( object )
        ! TODO
    end subroutine adapt

end module Patch
