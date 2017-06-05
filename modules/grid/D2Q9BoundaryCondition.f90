! Module for desribing a boudary condition for the D2Q9 velocity set

module D2Q9BoundaryCondition

    implicit none
    use Boundary

    type, extends(Boundary_t) :: D2Q9BoundaryCondition_t
    end type
    

end module D2Q9BoundaryCondition
