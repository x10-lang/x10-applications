#include <apgas/Task.h>
#include <apgas/Runtime.h>
#include <x10/array/Array_2.h>

#include <stdio.h>
#include <math.h>

using namespace apgas;

// Add timing support
#include <sys/time.h>
double time_stamp()
{
  struct timeval t;
  double time;
  gettimeofday(&t, NULL);
  time = t.tv_sec + 1.0e-6*t.tv_usec;
  return time;
}
double time1, time2;

void driver(void);
void initialize(void);
void jacobi(void);
void error_check(void);

/************************************************************
* program to solve a finite difference 
* discretization of Helmholtz equation :  
* (d2/dx2)u + (d2/dy2)u - alpha u = f 
* using Jacobi iterative method. 
*
* Modified: Sanjiv Shah,       Kuck and Associates, Inc. (KAI), 1998
* Author:   Joseph Robicheaux, Kuck and Associates, Inc. (KAI), 1998
* This c version program is translated by 
* Chunhua Liao, University of Houston, Jan, 2005 
* APGAS version, David Grove, IBM Research, September 2013
* 
* Input :  n - grid dimension in x direction 
*          m - grid dimension in y direction
*          alpha - Helmholtz constant (always greater than 0.0)
*          tol   - error tolerance for iterative solver
*          relax - Successive over relaxation parameter
*          mits  - Maximum iterations for iterative solver
*
* On output 
*       : u(n,m) - Dependent variable (solutions)
*       : f(n,m) - Right hand side function 
*************************************************************/

 #define MSIZE 1000
 int n,m,mits; 
 double tol,relax=1.0,alpha=0.0543; 
 x10::array::Array_2<double>* u = x10::array::Array_2<double>::_make(MSIZE, MSIZE);
 x10::array::Array_2<double>* f = x10::array::Array_2<double>::_make(MSIZE, MSIZE);
 x10::array::Array_2<double>* uold = x10::array::Array_2<double>::_make(MSIZE, MSIZE);
 double dx,dy;

class JacobiWorker : public Task {
  public:
    double error;
    int i_min;
    int i_max;
    JacobiWorker(int min, int max) : i_min(min), i_max(max) { }
    void execute();
};

void partitionBlock(int min, int max, int n, int i, int* myMin, int* myMax) {
    int numElems = max - min + 1;
    int blockSize = numElems/n;
    int leftOver = numElems - n*blockSize;
    *myMin = min + blockSize*i + (i< leftOver ? i : leftOver);
    *myMax = *myMin + blockSize + (i < leftOver ? 0 : -1);
}

class Jacobi : public Task {
  public:
    int P;

    Jacobi() { }

    void execute() {
        float toler;
        /*      printf("Input n,m (< %d) - grid dimension in x,y direction:\n",MSIZE); 
                scanf ("%d",&n);
                scanf ("%d",&m);
                printf("Input tol - error tolerance for iterative solver\n"); 
                scanf("%f",&toler);
                tol=(double)toler;
                printf("Input mits - Maximum iterations for solver\n"); 
                scanf("%d",&mits);
        */
        n=MSIZE;
        m=MSIZE;
        tol=0.0000000001;
        mits=5000;
        P = getRuntime()->numWorkers();

        printf("Running using %d threads...\n",P);

        driver ( ) ;
    }

    /*************************************************************
     * Subroutine driver () 
     * This is where the arrays are allocated and initialized. 
     *
     * Working variables/arrays 
     *     dx  - grid spacing in x direction 
     *     dy  - grid spacing in y direction 
     *************************************************************/
    void driver( )
    {
        initialize();

        time1 = time_stamp();
        /* Solve Helmholtz equation */
        jacobi ();
        time2 = time_stamp();

        printf("------------------------\n");     
        printf("Execution time = %f\n",time2-time1);
        /* error_check (n,m,alpha,dx,dy,u,f)*/
        error_check ( );
    }


    /*      subroutine initialize (n,m,alpha,dx,dy,u,f) 
     ******************************************************
     * Initializes data 
     * Assumes exact solution is u(x,y) = (1-x^2)*(1-y^2)
     *
     ******************************************************/

    void initialize( )
    {
      
        int i,j, xx,yy;
        //double PI=3.1415926;

        dx = 2.0 / (n-1);
        dy = 2.0 / (m-1);

        // Initialize initial condition and RHS */
        for (i=0;i<n;i++)
            for (j=0;j<m;j++)      
            {
                xx =(int)( -1.0 + dx * (i-1));        
                yy = (int)(-1.0 + dy * (j-1)) ;       
                u->x10::array::Array_2<double>::__set(i,j, 0.0);
                f->x10::array::Array_2<double>::__set(i, j, -1.0*alpha *(1.0-xx*xx)*(1.0-yy*yy) - 2.0*(1.0-xx*xx)-2.0*(1.0-yy*yy));
            }

    }

    /*      subroutine jacobi (n,m,dx,dy,alpha,omega,u,f,tol,maxit)
     ******************************************************************
     * Subroutine HelmholtzJ
     * Solves poisson equation on rectangular grid assuming : 
     * (1) Uniform discretization in each direction, and 
     * (2) Dirichlect boundary conditions 
     * 
     * Jacobi method is used in this routine 
     *
     * Input : n,m   Number of grid points in the X/Y directions 
     *         dx,dy Grid spacing in the X/Y directions 
     *         alpha Helmholtz eqn. coefficient 
     *         omega Relaxation factor 
     *         f(n,m) Right hand side function 
     *         u(n,m) Dependent variable/Solution
     *         tol    Tolerance for iterative solver 
     *         maxit  Maximum number of iterations 
     *
     * Output : u(n,m) - Solution 
     *****************************************************************/
    void jacobi() {
        double omega;
        int i,j,k;
        double  error,resid,ax,ay,b;
        //      double  error_local;

        //      float ta,tb,tc,td,te,ta1,ta2,tb1,tb2,tc1,tc2,td1,td2;
        //      float te1,te2;
        //      float second;

        error = 10.0 * tol;
        k = 1;

        JacobiWorker** tasks = Runtime::alloc<JacobiWorker*>(P*sizeof(JacobiWorker*));
        for (int tn = 0; tn<P; tn++) {
            int min, max;
            partitionBlock(1, n-2, P, tn, &min, &max);
            tasks[tn] = new (Runtime::alloc<JacobiWorker>()) JacobiWorker(min, max);
        }

        while ((k<=mits)&&(error>tol)) 
        {
            error = 0.0;    

            /* Copy new solution into old */
            {
                for(i=0;i<n;i++)   
                    for(j=0;j<m;j++)
                        uold->x10::array::Array_2<double>::__set(i, j, u->x10::array::Array_2<double>::__apply(i,j));
                
                myRuntime->runFinish(P, (Task**)tasks);

                for (int tn=0; tn < P; tn++) {
                    error += tasks[tn]->error;
                }
            }

            /* Error check */

            k = k + 1;
            if (k%500==0) 
                printf("Finished %d iteration.\n",k);
            error = sqrt(error)/(n*m);

        }          /*  End iteration loop */

        printf("Total Number of Iterations:%d\n",k); 
        printf("Residual:%E\n", error); 

    }

    /* subroutine error_check (n,m,alpha,dx,dy,u,f) 
     * implicit none 
     ************************************************************
     * Checks error between numerical and exact solution 
     *
     ************************************************************/ 
    void error_check ( )
    { 
        int i,j;
        double xx,yy,temp,error; 

        dx = 2.0 / (n-1);
        dy = 2.0 / (m-1);
        error = 0.0 ;

        for (i=0;i<n;i++)
            for (j=0;j<m;j++)
            { 
                xx = -1.0 + dx * (i-1);
                yy = -1.0 + dy * (j-1);
                temp  = u->x10::array::Array_2<double>::__apply(i, j) - (1.0-xx*xx)*(1.0-yy*yy);
                error = error + temp*temp; 
            }
        error = sqrt(error)/(n*m);
        printf("Solution Error :%E \n",error);
    }

};

void JacobiWorker::execute() {
    double omega=relax;
    double ax = 1.0/(dx*dx); /* X-direction coef */
    double ay = 1.0/(dy*dy); /* Y-direction coef */
    double b  = -2.0/(dx*dx)-2.0/(dy*dy) - alpha; /* Central coeff */ 

    error = 0;
    for (int i= i_min; i <= i_max; i++) {
        for (int j=1; j<(m-1); j++)  { 
            double resid = (ax*(uold->x10::array::Array_2<double>::__apply(i-1, j) + uold->x10::array::Array_2<double>::__apply(i+1, j)) +
                            ay*(uold->x10::array::Array_2<double>::__apply(i, j-1) + uold->x10::array::Array_2<double>::__apply(i, j+1))+
                            b * uold->x10::array::Array_2<double>::__apply(i, j) - f->x10::array::Array_2<double>::__apply(i, j))/b;  

            u->x10::array::Array_2<double>::__set(i, j, uold->x10::array::Array_2<double>::__apply(i, j) - omega * resid);
            error = error + resid*resid ;   
        }
    }
}

int main(int argc, char **argv) {
    Jacobi jb;
    apgas::Runtime aRuntime(&jb);
    aRuntime.start();
}
    
