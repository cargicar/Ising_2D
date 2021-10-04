program ising_2D
! 8 June 2021:
! Ising simulator with Monte Carlos

implicit none
include 'parameters0.inc'
!
!    integer i,j,N, sqr_size ! NxN=Size square lattice
    real(kind=8) :: magnetization, prob, ee, a_rand
    integer :: i, j, k, bc, e
    real, dimension(N,N) :: u
    integer, dimension(N,N) :: ra,  energy_site
    real, dimension(2) :: two_rand
    integer, dimension(2) :: rs
 
    call RANDOM_NUMBER(u)
    ra=nint(u)
    where (ra==0)
        ra=-1
    end where
    
    write( 1,*) ra

   rundo: do k= 1, epochs
        call RANDOM_NUMBER(two_rand)
        rs = nint(two_rand*N)+1
        if(rs(1).LE.N.and.rs(2).LE.N) then
             e = 2*ra(rs(1),rs(2))*( ra(bc(rs(1)-1),rs(2))+ ra(bc(rs(1)+1),rs(2))+ra(rs(1),bc(rs(2)-1))+ra(rs(1),bc(rs(2)+1))  )
             ee=float(e)
             prob=EXP(-1*ee/T)
             call RANDOM_NUMBER(a_rand)
            !write (3,*) random_site
                if(ee.LT.0.0) then
                  ra(rs(1),rs(2))= -1 * ra(rs(1),rs(2))
                else if(prob > a_rand) then
                  !print *, prob
                  ra(rs(1),rs(2))= -1 * ra(rs(1),rs(2))
                end if
         end if
   end do rundo

   !magnetization=abs(float(sum(ra))/N**2)
   !print *, 'final state'
   write(2,*) ra
   !print *,  magnetization

end program ising_2D

function bc (m)
implicit none
include 'parameters0.inc'
 integer :: m, bc
 
 if(m.GE.N) then
    bc =1
 else if(m.LT.0) then
    bc=N
 else
    bc=m
 end if
end function bc

    

