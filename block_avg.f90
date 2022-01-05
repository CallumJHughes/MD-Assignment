program block_avg
  use stats
  implicit none

  N = 8192 ! Needs to be size of data file e.g 10000 (1*(2**13)=8192)
  
  dataFile = 'U_err_110.dat' ! Needs to be looped (will be looped in main script) (sed???)

  call FillArray ! Fills array Data with data from dataFile to be used in BlockAverage subroutine

  call BlockTheData

  !call printBlockAverage

  ! Now repeat for temperature (Maybe in different file)

  ! Change dataFile to required temperature file e.g. T_err_110.dat

  ! call FillArray

  ! call BlockTheData

contains
  subroutine BlockTheData
    do while (mod(N,2) .EQ. 0) ! Checks if N is even

      call BlockAverage
      allocate(inputData(N))
      do i = 1, N
        inputData(i) = blockData(i)
      end do
      
      print *, 'Size of data set is: ', size(blockData)
      call MeanVariance
      print * ! Prints empty line to space out the output values

      ! If there are still data points to be blocked then the arrays are deallocated for the next loop
      ! Else the loop is exited and the arrays contain the last set of data aquired.
      if (mod(N,2) .EQ. 0) then
        deallocate(blockData)
        deallocate(inputData)
      else
        exit
      end if
      
    end do
  end subroutine
  
end program block_avg
