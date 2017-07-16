! Module for describing a block containing data

module Block_2D

    implicit none
    use Block, only Block_t
    use ParticleDist, only ParticleDist_t

    ! A type for representing a two-dimensional lattice Block of arbitrary dimensions.
    ! Since in any case the x-y-components have a unspecified 3rd dimension degree.
    type, extends(Block_t) :: Block_2D_t
        double precision, allocatable :: distributionField_a(:, :, :)
        double precision, allocatable :: tempDistributionField_a(:, :, :)
        double precision, allocatable :: equilibriumField_a(:, :, :)
        type(B)
        
     end type Block_2D_t

   contains

     subroutine initBlock(this, LX, LY, partDist, active)
       type(Block_2D_t), intent(inout) :: this
       type(ParticleDist_t), intent(in) :: partDist
       integer, intent(in) :: LX, LY
       logical, intent(in) :: active

       this%activeBlock = active


     end subroutine initBlock

     pure logical function isActiveBlock(this) result(active)
       type(Block_2D_t), intent(in) :: this

       active = this%activeBlock

     end function isActiveBlock

     elemental subroutine setActive(this)
       type(Block_2D_t), intent(inout) :: this

       this%activeBlock = .TRUE.

     end subroutine setActive
    
end module Block_2D
