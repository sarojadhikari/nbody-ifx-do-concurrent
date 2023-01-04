! Created by saroj on 1/1/23.


module simulation
    use type, only: RealType
    use mod_particle, only: Particle

    implicit none

    type :: GSimulation
        private

        type(Particle), allocatable :: particles(:)
        integer :: npart               ! number of particles
        integer :: nsteps              ! number of integration steps
        real(RealType) :: tstep        ! time step of the simulation

        integer :: sfreq               ! sample frequency

        real(RealType) :: kenergy      ! kinetic energy

        !doubleprecision total_flops    ! total number of FLOPS

    contains

        procedure, public, pass(self) :: Init
        procedure, public, pass(self) :: SetNumberOfParticles
        procedure, public, pass(self) :: SetNumberOfSteps
        procedure, public, pass(self) :: Start

        procedure, pass(self) :: InitPos
        procedure, pass(self) :: InitVel
        procedure, pass(self) :: InitAcc
        procedure, pass(self) :: InitMass

        procedure, pass(self) :: PrintHeader

    end type GSimulation

contains

    subroutine Init(self)
        class(GSimulation), intent(inout) :: self
        print *, "==============================="
        print *, "Initialize Gravity Simulation"

        self%npart = 16000
        self%nsteps = 10
        self%tstep = 0.1
        self%sfreq = 1

    end subroutine Init

    subroutine SetNumberOfParticles(self, N)
        class(GSimulation) :: self
        integer :: N
        self%npart = N
    end subroutine SetNumberOfParticles

    subroutine SetNumberOfSteps(self, N)
        class(GSimulation) :: self
        integer :: N
        self%nsteps = N
    end subroutine SetNumberOfSteps

    ! initialize the positions of particles randomly
    subroutine InitPos(self)
        class(GSimulation) :: self
        integer :: i

        do i = 1, self%npart
            call random_number(self%particles(i)%pos)
        end do

    end subroutine InitPos

    subroutine InitVel(self)
        class(GSimulation) :: self
        integer :: i

        do i = 1, self%npart
            call random_number(self%particles(i)%vel)
            self%particles(i)%vel = 2.0E-3 * (self%particles(i)%vel - 0.5)
        end do

    end subroutine InitVel

    subroutine InitAcc(self)
        class(GSimulation) :: self
        integer :: i

        do i = 1, self%npart
            self%particles(i)%acc = 0.0
        end do

    end subroutine InitAcc

    subroutine InitMass(self)
        class(GSimulation) :: self
        integer :: i

        do i = 1, self%npart
            call random_number(self%particles(i)%mass)
        end do

    end subroutine InitMass

    subroutine PrintHeader(self)
        class(GSimulation) :: self

        print *, "nPart = ", self%npart
        print *, "nSteps = ", self%nsteps
        print *, "dt = ", self%tstep
        print *, "-------------------------------------"
        print *, "          s   kenergy       time (s)"
        print *, "-------------------------------------"

    end subroutine PrintHeader

    ! main simulation code for Nbody
    subroutine Start(self)
        class(GSimulation) :: self
        real, parameter :: kSofteningSquared = 1.0e-3
        real, parameter :: kG = 6.67259e-11

        real(RealType) :: dt, dx, dy, dz, accx, accy, accz
        real(RealType) :: distance_sqr, distance_inv, distance_inv_cubed
        integer :: cpu_start, cpu_finish
        real :: total_time
        integer :: s, i, j

        allocate (self%particles(self%npart))

        call self%InitPos()
        call self%InitVel()
        call self%InitAcc()
        call self%InitMass()

        call self%PrintHeader()

        dt = self%tstep

        total_time = 0.0
        ! loop across integration steps

        do s = 1, self%nsteps
            call system_clock(cpu_start)

            ! calculate the acceleration for all particles

            !do i = 1, self%npart
            do concurrent (i = 1: self%npart)

                accx = self%particles(i)%acc(1)
                accy = self%particles(i)%acc(2)
                accz = self%particles(i)%acc(3)

                do j = 1, self%npart
                    dx = self%particles(j)%pos(1) - self%particles(i)%pos(1)
                    dy = self%particles(j)%pos(2) - self%particles(i)%pos(2)
                    dz = self%particles(j)%pos(3) - self%particles(i)%pos(3)

                    distance_sqr = dx * dx + dy * dy + dz * dz + kSofteningSquared
                    distance_inv = 1.0/sqrt(distance_sqr)
                    distance_inv_cubed = distance_inv * distance_inv * distance_inv

                    accx = accx + dx * kG * self%particles(j)%mass * distance_inv_cubed
                    accy = accy + dy * kG * self%particles(j)%mass * distance_inv_cubed
                    accz = accz + dz * kG * self%particles(j)%mass * distance_inv_cubed

                end do

                self%particles(i)%acc(1) = accx
                self%particles(i)%acc(2) = accy
                self%particles(i)%acc(3) = accz

            end do

            ! update velocity and positions and also calculate the kinetic energy in each step
            ! note we cannot use do concurrent here
            do i = 1, self%npart

                self%particles(i)%vel = self%particles(i)%vel + self%particles(i)%acc * dt
                self%particles(i)%pos = self%particles(i)%pos + self%particles(i)%vel * dt
                self%particles(i)%acc = 0.0

                self%kenergy = self%kenergy + 0.5 * self%particles(i)%mass  &
                                * dot_product(self%particles(i)%vel, self%particles(i)%vel)

            end do

            call system_clock(cpu_finish)
            total_time = total_time + real(cpu_finish - cpu_start)/1000
            print *, s, self%kenergy, real(cpu_finish - cpu_start)/1000

            self%kenergy = 0.0

        end do

        print *, ""
        print *, "Total Time (s): ", total_time
        print *, "============================="

    end subroutine Start


end module simulation