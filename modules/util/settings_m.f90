! Module for setting the precision in the entire library

module Settings_m

  use iso_fortran_env
  
  integer, parameter :: real_w = 8 ! by default every real data is in double precision
  integer, parameter :: int_w = 8 ! by default every interger data has 8 bytes
  integer, parameter :: imp_w = 2 ! Number of images

end module Settings_m
