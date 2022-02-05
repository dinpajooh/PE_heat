      program avgfiles 
      implicit none

      integer i,j, nfile, ndata, nn, nnn, nblock
      double precision dummy, Epavg
      character(len=3) str 
      integer, parameter :: nfiles = 10
      double precision, allocatable, dimension(:) ::
     $ step,gr1avg,Xavg, gr1std
      double precision, allocatable, dimension(:,:) ::
     $ grdata,Xdata

      do i=1,1
         if ( i .lt. 10 ) then
             Write(str,'(i1.1)') i
             print*, str
         elseif ( (i .ge. 10) .and. (i .lt. 100) ) then
             Write(str,'(i2.2)') i
             print*, str
         elseif ( i .ge. 100  ) then
             Write(str,'(i3.3)') i
             print*, str
         endif

         open(unit=2,file=str,status="unknown")
         ndata=0
 10      ndata=ndata+1
         read(2,*,end=11) dummy
         go to 10
 11      ndata=ndata-1
         close(2)
      enddo
      allocate(step(ndata))
      allocate(gr1avg(ndata))
      allocate(gr1std(ndata))
      allocate(grdata(nfiles,ndata))
      allocate(Xavg(ndata))
      allocate(Xdata(nfiles,ndata))


      step(:) = 0.0d0
      gr1avg(:) = 0.0d0
      grdata(:,:) = 0.0d0

      Xavg(:) = 0.0d0
      Xdata(:,:) = 0.0d0


      rewind(1)


      do i=1,nfiles
         if ( i .lt. 10 ) then
             Write(str,'(i1.1)') i
             print*, str
         elseif ( (i .ge. 10) .and. (i .lt. 100) ) then
             Write(str,'(i2.2)') i
             print*, str
         elseif ( i .ge. 100  ) then
             Write(str,'(i3.3)') i
             print*, str
         endif
         open(unit=1,file=str,status="unknown")
         do j = 1, ndata
             read(1,*) Xdata(i,j), grdata(i,j) 
         enddo
         close(1)
      enddo


      do i=1,nfiles
         do j=1,ndata
             gr1avg(j) = gr1avg(j) + grdata(i,j)    
             Xavg(j) = Xavg(j) + Xdata(i,j)    
         enddo     
      enddo

      gr1avg(:)=gr1avg(:)/dble(nfiles)
      Xavg(:)=Xavg(:)/dble(nfiles)


      gr1std(:) = 0.0d0
      do i=1,nfiles
         do j=1,ndata
            gr1std(j) = gr1std(j) + (grdata(i,j)-gr1avg(j))**2  
         enddo     
      enddo
      gr1std(:) =sqrt(gr1std(:)/(dble(nfiles-1)))/sqrt(dble(nfiles))



      open(unit=10,file='final',status="unknown")

      do i=1,ndata
          write(10,'(F18.8,2x,F18.8,2x,F18.8)') Xavg(i),
     $    gr1avg(i), gr1std(i) 
      enddo

      close(1)
      close(10)


      end program 
