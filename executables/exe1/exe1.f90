program exe1
    use mod1, only : is_two
    implicit none
    integer :: i
    print *, "Hello World"
    do i = 1, 5, 1
        print *, i, is_two(i)
    end do

end program exe1
