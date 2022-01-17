program heat_capacity
  use stats
  implicit none
  integer, parameter :: dp=selected_real_kind(15,300)
  
  real(kind=dp) :: kB = 1.380649*(10**-23)
  real(kind=dp) :: meanTemp, meanK, meanK2
  integer :: Natoms

  Natoms = 256

  !!! READ LECTURE NOTES, SEE WHAT FLUCTUATION FORMUALA IS !!!

  ! Import data file containing temperature values

  ! Find mean of K (K=3/2*N*T) using block averages
  meanK = (3/2) * Natoms * kB * meanTemp

  ! Find mean of K squared (K2=9/4*N2*T2) using block averages

  ! Find average of delta K squared using formula

  ! DELTA K IS VARIANCE LECTURE NOTES PAGE 41

  ! Calculate Cv using formula

contains
  function deltaK2(avgK,avgK2)
    deltaK2 = avgK2 - ((avgK)**2)
  end function deltaK2

end program heat_capacity
