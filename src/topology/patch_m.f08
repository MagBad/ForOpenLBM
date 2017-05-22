! Module to describe a Patch class, a patch is a leaf/ node in the data structure tree

module Patch

    implicit none
    use Block

    type Patch_t
        type(Patch_t), pointer :: parent => NULL
        type(Patch_t), dimension(1, :), pointer :: children
        type(Patch_t), dimension(1, :), pointer :: neighbours
        type(Block_t), dimension(1, :), pointer :: blocks
        integer :: numberOfChildren 
        integer :: numberOfBlocks
        integer :: numberOfNeighbours

        contains
            procedure :: initilizePatch
            procedure :: addBlock
            procedure :: deleteBlock
            procedure :: addChilds
            procedure :: addNeighbour
            procedure :: getLocalNeighbourBlock
            procedure :: getRemoteNeighbourBlock
            procedure :: adapt

    end type Patch_t  

    ! The initialization routine is called from the grid layer
    subroutine initilizePatch( object, numberOfBlocks, &
        numberOfNeighbours, parent)

        type(Patch_t), intent(inout) :: object
        integer :: numberOfBlocks, numberOfNeighbours
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

        end if

        ! Assign the possible parent
        object%parent = parent

        ! Allocate the new blocks
        allocate(initBlock(1, numberOfBlocks))
        object%blocks = initBlock

        ! Allocate the neighbours
        allocate(neighbours(1, numberOfNeighbours))
        object%neighbours = neighbours

        ! Allocate the array for storing the children, they're initialized without any children. 
        ! The value is changend in another subroutine
        allocate(childern(1, 1))
        children = NULL
        object%children = children

    end subroutine initilizePatch

    subroutine addBlock(object, block)

        type(Patch_t), intent(inout) :: object
        type(Block_t), intent(in) :: block 
        type(Block_t), dimension(1,:), allocatable :: tempBlock

        allocate(tempBlock) 
    end subroutine

end module Patch
