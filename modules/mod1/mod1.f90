module mod1

    implicit none

contains

    function is_two(n)
        implicit none
        integer, intent(in) :: n
        logical :: is_two
        is_two = ( n == 2 )
    end function is_two

end module mod1
