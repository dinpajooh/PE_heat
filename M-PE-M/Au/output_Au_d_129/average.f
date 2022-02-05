           Program aver 
           implicit none

           integer k,i
           double precision x,average,dummy,std,stmean
           double precision,dimension(:), allocatable :: c
           double precision,dimension(:), allocatable :: s
           double precision ::  std_anal, conf_50, conf_60
           double precision ::  conf_70, conf_80, conf_90
           double precision ::  conf_95, conf_99, conf_99_9

c          tStudent parameters for data which includes 7 degrees of freedom
           double precision, parameter :: t50 = 0.711d0 
           double precision, parameter :: t60 = 0.896d0 
           double precision, parameter :: t70 = 1.119d0 
           double precision, parameter :: t80 = 1.415d0 
           double precision, parameter :: t90 = 1.895d0 
           double precision, parameter :: t95 = 2.365d0 
           double precision, parameter :: t99 = 3.499d0 
           double precision, parameter :: t99p9 = 5.408d0 

c****************************************************************
c   Calculates average , standard deviation, and
c   standard error of the mean from some data in a specified file
c**************************************************************** 

      Open(unit=2,file='DATA'
     & ,status="unknown")
           k=0
 10        k=k+1
           Read(2,*,end=11) dummy
           go to 10
 11        k=k-1
           print*, 'k', k 
           allocate(c(k)) 
           c(:)=0.0d0           
           average = 0.0d0

           rewind (2)
           do i = 1,k
              read(2,*) c(i)
              average = average+c(i)
           enddo
       
           average =(average/dble(k))
           deallocate (c)
           allocate (s(k))
           s(:)=0.0d0
           std=0.0d0

           rewind (2)
             do i=1,k
                read(2,*) s(i)
              s(i)= (s(i)-average)**2
              std= std + s(i) 
             end do
           deallocate(s)
           std_anal = std
           std =sqrt(std/(dble(k)))
           stmean=std/(sqrt(dble(k-1)))
           print*, 'average', average 
           print*,'standard deviation', std
           print*, 'standard error of the mean', stmean

           end program
