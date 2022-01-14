program heat_capacity
  use stats
  implicit none

  !!! READ LECTURE NOTES, SEE WHAT FLUCTUATION FORMUALA IS !!!

  ! Import data file containing temperature values

  ! Calculate mean value of temperature using block averaging (What are the benefits of block averaging???)

  ! Find mean of K (K=3/2*N*T) using block averages

  ! Find mean of K squared (K2=9/4*N2*T2) using block averages

  ! Find average of delta K squared using formula

  ! Calculate Cv using formula

contains
  function deltaK2(avgK,avgK2)
    deltaK2 = avgK2 - ((avgK)**2)
  end function deltaK2

end program heat_capacity
