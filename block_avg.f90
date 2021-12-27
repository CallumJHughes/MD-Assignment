program block_avg
  use stats
  implicit none

  real (kind=dp), dimension(:), allocatable :: blockData

  ! Read data from file and assign it to array blockData
  open (unit=1, file=blob)
  read (1,*) blockData
  
  call BlockAverage
end program block_avg
