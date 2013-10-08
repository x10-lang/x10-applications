#include "MC.h"

void MC_Set_particles(MC* mc, Particle *p, int np, int sizep){
  mc->particles = p;
  mc->nparticles = np;
  mc->sizep = sizep;
}
