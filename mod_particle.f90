! Created by saroj on 1/1/23.

module mod_particle
    use type, only: RealType

    type :: Particle
        real(RealType) :: pos(3)
        real(RealType) :: vel(3)
        real(RealType) :: acc(3)
        real(RealType) :: mass
    end type Particle

end module mod_particle