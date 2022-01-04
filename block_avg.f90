program block_avg
  use stats
  implicit none

  ! Work out standard deviation

  N = 8192 ! Needs to be size of data file e.g 10000
  
  dataFile = 'U_err_110.dat' ! Needs to be looped (will be looped in main script)

  call FillArray ! Fills array Data  with data from dataFile to be used in BlockAverage subroutine

  do while (mod(N,2) .EQ. 0)
    call BlockAverage
    allocate(inputData(N))
    do i = 1, N
      inputData(i) = blockData(i)
    end do
    print *, size(blockData)
    call MeanVariance
    if (mod(N,2) .EQ. 0) then
      deallocate(blockData)
      deallocate(inputData)
    else
      exit
    end if
  end do

  !call printBlockAverage


end program block_avg
