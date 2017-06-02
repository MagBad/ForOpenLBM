! Module for describing a block containing a describtion of the D2Q9 velocity set

module D2Q9Block

    implicit none
    use BlockD

    type, extends(Block2D_t) :: D2Q9Block_t
        real, pointer :: distribution(:, :, :)
        real, pointer :: tempDistribution(:, :, :)
        type(B)
        
     end type D2Q9Block_t

   contains

     subroutine initBlock(this, LX, LY)
       type(Block2D_t), intent(inout) :: newBlock
       interger, intent(in) :: LX, LY

     end subroutine
    
end module D2Q9Block
