program block_avg
  use stats
  implicit none

  N = 100 ! Needs to be size of data file e.g 10000

  dataFile = 'U_err_110.dat' ! Needs to be looped

  call FillArray ! Fills array Data  with data from dataFile to be used in BlockAverage subroutine

  print *, Data


  !call BlockAverage

  !print *, blockData
  
end program block_avg
