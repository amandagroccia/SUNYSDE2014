//
//  random.c
//  killer shrimp
//
//  Created by Amanda Groccia on 7/8/14.
//  Copyright (c) 2014 Amanda. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

/*
 Routine to generate two normally distributed random numbers.  This
 routine uses the Box-Muller transformation and generates two
 numbers.
 */
void normalDistRand(double stdDev,double* randomNumbers)
{
	/* Generate a random number in polar coordinates */
	double radius = sqrt(-2.0*log(drand48()));
	double angle  = 2.0*M_PI*drand48();
    
	/* transform the number back into cartesian coordinates */
	randomNumbers[0] = stdDev*radius*sin(angle);
	randomNumbers[1] = stdDev*radius*cos(angle);
}

double f1(double x, double y, double alpha, double gamma, double D)
{
    return(x*x*(1.0-x)-alpha*x*y-(gamma*x*x)/(D+x));
}

double f2(double x, double y, double beta, double rho, double delta, double R)
{
    return(rho*y*y*(1.0-y)-beta*x*y-(delta*y*y)/(R+y));
}

void singleApprox(double x0, double y0,
                  double alpha, double beta,
                  double gamma, double delta,
                  double R, double D,
                  double rho,
                  double x[2])

{
    int lupe=0;
    int N=1000;
    double T=6.0;
    double xinter[2];
    double dt = T/((double)N);
    double stdDev=sqrt(dt);
    double kappa=0.06;
    double upsilon=0.05;
    double dw[2];
    
    x[0]=x0;
    x[1]=y0;
    
    while (lupe++ < N)
    {
        xinter[0]=x[0];
        xinter[1]=x[1];
        
        normalDistRand(stdDev,dw);
        
        x[0] += f1(xinter[0], xinter[1], alpha, gamma, D)*dt+upsilon*dw[0];
        x[1] += f2(xinter[0], xinter[1], beta, rho, delta, R)*dt+kappa*(dw[1]);
        
        if (x[0]< 0.0) x[0] = 0.0;
        if (x[1]< 0.0) x[1] = 0.0;
            
    }
    
}

int main(int argc,char **argv)
{
    int lupe;
	/* Set the initial seed for the random number generator. */
	srand48(time(NULL));
    double x[2];
    double alpha = 0.1;
    double rho = 1.0;
    double beta = 0.11;
    double R = 3.0;
    double D = 7.0;
    double x0 = 0.2;
    double y0 = 0.8;
    double gamma = 0.5;
    double delta = 0.8;
    
    
    
	/* Call the routine, and the results are in the vector x. Print out the results.*/
	//	printf("%f,%f\n",w[0],w[1]);
    //FILE *fp;
    //fp = fopen("/Users/amandagroccia/Documents/SUNYSDE2014/bkgr/prob/c/shrimpSimulation/shrimpSimulation/shrimpSimulation/shrimpResults.csv","w");
    //fp = fopen("./shrimpResults.csv","w");
    //printf("Ima gonna write something\n");
    //fprintf(fp,"x,y,gamma,delta\n");
    
    /* Call the routine, and the results are in the vector x. Print out the results.*/
	//	printf("%f,%f\n",w[0],w[1]);
    FILE *fp;
    fp = fopen("/Users/amandagroccia/Documents/SUNYSDE2014/bkgr/prob/c/shrimpSimulation/shrimpSimulation/shrimpSimulation/shrimpResults2.csv","w");
    //fp = fopen("./shrimpResults2.csv","w");
    //printf("Ima gonna write something\n");
    fprintf(fp,"x,y,gamma,delta\n");
    
    
    
    double gammaMin=0.0;
    double gammaMax=2.0;
    int numgamma=50;
    double deltagamma=(gammaMax - gammaMin)/((double) numgamma);
    int lupe_gamma;
    
    double deltaMin=0.0;
    double deltaMax=2.0;
    int numdelta=50;
    double deltadelta=(deltaMax - deltaMin)/((double) numdelta);
    int lupe_delta;


    for(lupe_delta = 0; lupe_delta <= numdelta; ++lupe_delta)
    {
        delta=deltaMin+((double)lupe_delta)*deltadelta;
        printf("Delta: %f\n",delta);
      
        for(lupe_gamma = 0; lupe_gamma <= numgamma; ++lupe_gamma)
        {
            gamma=gammaMin+((double)lupe_gamma)*deltagamma;
            printf("Gamma: %f\n",gamma);
        
            for(lupe=0;lupe<45000;++lupe)
            {
                singleApprox(x0, y0, alpha, beta, gamma, delta, R, D, rho, x);
                //fprintf(fp,"s1\n");
                fprintf(fp,"%f,%f,%f,%f\n",x[0],x[1],gamma,delta);
      
            }
        }
    }
    
    fclose(fp);
    return(0);
    
    
}


