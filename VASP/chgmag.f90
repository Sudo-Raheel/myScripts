program chgmag
    ! Read a CHGCAR file and extract the up - down density
    !
    ! args:
    !    CHGCAR file name
    !
    ! Output is written into the CHGCAR_mag
    !

    implicit none

    ! arguments:
    character(len=100)                            :: chgcar

    ! local:
    integer                                       :: i, j, k, nline, nval, io
    integer                                       :: ngxf1, ngyf1, ngzf1
    integer                                       :: ngxf2, ngyf2, ngzf2
    character(len=100)                            :: line, bid
    character(len=100), dimension(:), allocatable :: header
    real(kind=8)                                  :: occ
    real(kind=8), dimension(:,:,:), allocatable   :: rho

    ! get arguments
    call get_command_argument(1, chgcar)

    ! read file
    ! ---------
    write(*, "('Reading file    : ', a)") trim(chgcar)
    open(unit=10, file=chgcar, action="read")
    nline = 1
    read(10, "(a)") line
    do while (.not. line == "")
        read(10, "(a)") line
        nline = nline + 1
    end do
    !write(*,*) nline
    
    read(10, *) ngxf1, ngyf1, ngzf1
    !write(*,"(3i6)") ngxf1, ngyf1, ngzf1
    allocate(rho(ngxf1, ngyf1, ngzf1))
    allocate(header(nline))

    ! read up+down density
    rewind(10)
    do i = 1, nline
        read(10, "(a)") header(i)
    end do
    read(10, *)
    read(10, *) (((rho(i, j, k), i = 1, ngxf1), j = 1, ngyf1), k = 1, ngzf1)

    ! skip augementation occupancies part
    io = 1
    do while (io /= 0)
        read(10, "(3i5)", iostat=io) ngxf2, ngyf2, ngzf2
    end do

!    do while (index(line, "occupancies") /= 0)
!        read(line, *) bid, bid, bid, nval
!        read(10, *) (occ, i = 1, nval)
!        read(10, "(a)") line
!    end do

!    write(*,*) line
!    read(10, *) ngxf2, ngyf2, ngzf2

    ! check array size
    if( ngxf1 /= ngxf2 .or. ngyf1 /= ngyf2 .or. ngzf1 /= ngzf2) then
        write(* ,"('1: NGXF = ', i5, ', NGYF = ',i5,', NGZF = ',i5)") ngxf1, ngyf1, ngzf1
        write(* ,"('2: NGXF = ', i5, ', NGYF = ',i5,', NGZF = ',i5)") ngxf2, ngyf2, ngzf2
        stop "unconsistant grid"
    end if

    ! read up-down density
    read(10, *) (((rho(i, j, k), i = 1, ngxf1), j = 1, ngyf1), k = 1, ngzf1)
    close(10)


    ! write up - down density
    write(*, "('Writting file   : ', a)") "CHGCAR_mag.vasp"
    open(unit=10, file="CHGCAR_mag.vasp", action="write")
    do i = 1, nline
        write(10, "(a)") trim(header(i))
    end do
    write(10, "(3i6)") ngxf1, ngyf1, ngzf1
    write(10, "(5E19.11)") (((rho(i, j, k), i = 1, ngxf1), j = 1, ngyf1), k = 1, ngzf1)
    close(10)

    deallocate(rho)

end program chgmag
