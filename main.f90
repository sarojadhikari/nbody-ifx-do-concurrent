! =========================================================
! port of N-BodyMethods/Nbody of DPC++ Intel oneAPI sample
! code to Fortran
! The code performs N-body gravity simulation with a
! specified large number of particles

! attempt to use OpenMP directives to offload to Intel GPUs
! =========================================================

program Nbody
    ! two arguments are used for user-specified input
    ! first argument sets the number of particles and
    ! the second argument sets the number of steps
    use simulation, only: GSimulation

    character(10)  :: n_arg, nstep_arg
    integer :: n, nstep

    type(GSimulation) :: sim
    call sim%Init()

    if (command_argument_count() > 0) then
        call get_command_argument(1, n_arg)
        read (n_arg, *) n
        call sim%SetNumberofParticles(n)
    end if

    if (command_argument_count() > 1) then
        call get_command_argument(2, nstep_arg)
        read (nstep_arg, *) nstep
        call sim%SetNumberOfSteps(nstep)
    end if

    call sim%Start()

end program
