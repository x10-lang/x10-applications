typedef struct Particle_type{
	double x; double y; double z;
	double energy;
	double angle;
	int absorbed;
	int proc;
} Particle;

void Particle_init(Particle *p, double x, double y, double z, 
			double energy, double angle,
			int absorbed, int proc);
int  Particle_comparer(const void *pp1, const void *pp2);
void Particle_free(Particle *p);
void Particle_print(Particle *p, int np, int nprocs);
