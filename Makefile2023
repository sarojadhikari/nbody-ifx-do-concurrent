FC = ifx

FFLAGS = -O2 -qopenmp -fopenmp-target-do-concurrent

all: nbody

.SUFFIXES: .f90 .o

SRCS = type.f90 \
       mod_particle.f90 \
       simulation.f90

OBJS = type.o mod_particle.o simulation.o

release = nbody

.f90.o:
	${FC} $(FFLAGS) -c $<

nbody: main.f90 $(OBJS) 
	${FC} $(FFLAGS) $< $(OBJS) -o $@


%.o: %.mod

simulation.o: simulation.f90
type.o: type.f90
mod_particle.o: mod_particle.f90

.PHONY:
clean:
	/bin/rm -f *.o *.mod nbody
