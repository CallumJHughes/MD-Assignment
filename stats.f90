module stats
  implicit none
  integer :: N, i
  integer, parameter :: dp=selected_real_kind(15,300)
  real (kind=dp), dimension(:), allocatable :: Data, blockData, inputData
  character (len=50) :: dataFile, fileInfo
  
contains
  subroutine FillArray

    ! Allocate size of array 'Data'
    allocate(Data(N))

    ! Loop to assign data from data file to the array 'Data'
    open (unit=1, file=dataFile)
    do i = 1, N
      read (1,*) Data(i)
    end do
    close(1)

  end subroutine
 
  subroutine MeanVariance
    real (kind=dp) :: Mean, Variance, totalMean, totalVariance

    totalMean = sum(inputData)

    Mean = totalMean / N

    print *, 'The mean is: ', Mean

    totalVariance = 0

    do i = 1, N
      totalVariance = totalVariance + ((inputData(i) - Mean)**2)
    end do

    Variance = totalVariance / N 

    print *, 'The variance is: ', Variance

  end subroutine

  subroutine BlockAverage
    implicit none

    N = N / 2

    allocate(blockData(N))

    do i = 1, N
      blockData(i) = ((Data((2*i)-1)) + (Data(2*i))) / 2
    end do

    ! Need mean and variance???

  end subroutine

  subroutine printBlockAverage
    implicit none

    do i = 1, N
      print *, blockData(i)
    end do
  end subroutine

end module stats

! NOTE: If blank space is removed from end of data file then N=9 not 10 i.e. one less than desired
