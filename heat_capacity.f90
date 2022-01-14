program heat_capacity
  use stats
  implicit none

  ! Find mean of K (K=3/2*N*T) using block averages

  ! Find mean of K squared (K2=9/4*N2*T2) using block averages

  ! Find average of delta K squared using formula

  ! Calculate Cv using formula

contains
  function deltaK2(avgK,avgK2)
    deltaK2 = avgK2 - ((avgK)**2)
  end function deltaK2

end program heat_capacity
