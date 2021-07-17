program main

implicit none
include 'parameters.inc'

    integer i
    integer, dimension(N,N) :: ra_final
    real(kind=8) :: dT, magnet, temp, ma

    dT=T/float(nT)

    tempdo: do i=1, nT
    temp=float(i)*dT
        !call magnetization(temperature)
        ma = magnet(temp)

        !write(1,*) temp, ma
        write(1,*) temp
    end do tempdo

end program main


function magnet(temperature)
! 8 June 2021:
! Ising simulator with Monte Carlos
implicit none
include 'parameters.inc'
!
!    integer i,j,N, sqr_size ! NxN=Size square lattice
    real(kind=8) :: magnet, temperature, prob, ee, a_rand
    integer :: i, j, k, bc, e
    real, dimension(N,N) :: u
    integer, dimension(N,N) :: ra, ra_final, energy_site
    real, dimension(2) :: two_rand
    integer, dimension(2) :: rs
 
    call RANDOM_NUMBER(u)
    ra=nint(u)
    where (ra==0)
        ra=-1
    end where

   rundo: do k= 1, epochs
        call RANDOM_NUMBER(two_rand)
        rs = nint(two_rand*N)+1
        if(rs(1).LE.N.and.rs(2).LE.N) then
            e = 2*ra(rs(1),rs(2))*( jnn*ra(bc(rs(1)-2),rs(2))+jn*ra(bc(rs(1)-1),rs(2)) &
                +jn*ra(bc(rs(1)+1),rs(2))+jnn*ra(bc(rs(1)+2),rs(2))+ jnn*ra(rs(1),bc(rs(2)-2)) &
                +jn*ra(rs(1),bc(rs(2)-1))+jn*ra(rs(1),bc(rs(2)+1)) +jnn*ra(rs(1),bc(rs(2)+2)) )
             ee=float(e)
             prob=exp(-1*ee/temperature)
            !write (3,*) random_site
            call RANDOM_NUMBER(a_rand)
                if(ee.LT.0.0) then
                  ra(rs(1),rs(2))= -1 * ra(rs(1),rs(2))
                else if(prob > a_rand) then
                !
                  ra(rs(1),rs(2))= -1 * ra(rs(1),rs(2))
                end if
        end if
   end do rundo
   magnet=abs(float(sum(ra))/N**2)
   write(2,*) ra

end function magnet

function bc (m)
implicit none
include 'parameters.inc'
 integer :: m, bc
 
 if(m.GE.N) then
    bc =1
 else if(m.LE.0) then
    bc=N
 else
    bc=m
 end if
end function bc

    



