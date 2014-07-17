/* *****************************************************

  Program to approximate the population dynamics for two shrimp
  species.

  Copyright (c) 2014. All rights reserved.

  **************************************************** */

#include <fstream>
#include <iostream>
#include <thread>
#include <mutex>
#include <cstdio>

#include <math.h>
#include <time.h>

#define OUTPUT_FILE "./shrimpPopMulNoiseFULL.csv"
#define NUMBER_THREADS 4
//#define DEBUG


// create a mutex that is used to protect the writing of the data to
// the file.
std::mutex writeToFile;


/* Routine to write out the given data to the file. */
void printResultsCSV(double* x, double gamma, double delta,
                     std::ofstream* dataFile)
{

  std::lock_guard<std::mutex> guard(writeToFile);  // Make sure that
                                                   // only this
                                                   // routine can
                                                   // access the file
                                                   // at any one time.
  *dataFile << x[0]  <<  "," 
            << x[1]  << "," 
            << gamma << "," 
            << delta << std::endl;
  (*dataFile).flush();


}




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
                  double x[2],
				  std::ofstream* dataFile)

{
	int outerLupe=0;
    int lupe=0;
    int N=1000;
    double T=6.0;
    double xinter[2];
    double dt = T/((double)N);
    double stdDev=sqrt(dt);
    double kappa=0.06;
    double upsilon=0.05;
    double dw[2];
    

	for(outerLupe=0;outerLupe<45000;++outerLupe)
		{


			x[0]=x0;
			x[1]=y0;
    
			for (lupe=0;lupe < N;++lupe)
				{
					xinter[0]=x[0];
					xinter[1]=x[1];
        
					normalDistRand(stdDev,dw);
        
					x[0] += f1(xinter[0], xinter[1], alpha, gamma, D)*dt +
						upsilon*xinter[0]*dw[0] +
						upsilon*upsilon*xinter[0]*0.5*(dw[0]*dw[0]-dt);
					x[1] += f2(xinter[0], xinter[1], beta, rho, delta, R)*dt +
						kappa*xinter[1]*dw[1] +
						kappa*kappa*xinter[1]*0.5*(dw[1]*dw[1]-dt);

					if (x[0]< 0.0) x[0] = 0.0;
					if (x[1]< 0.0) x[1] = 0.0;
            
				}

			printResultsCSV(x,gamma,delta,dataFile);

		}
    
}

int main(int argc,char **argv)
{
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
    
	std::ofstream dataFile; // The data file to write the results to.    
    

	// Open the data file and write out a header.
	dataFile.open(OUTPUT_FILE,std::ios::out);
	dataFile << "x,y,gamma,delta" << std::endl;
	std::cout << "opening " << OUTPUT_FILE << std::endl;

	/* thread management */
	std::thread simulation[NUMBER_THREADS];
	int numberThreads = 0;


    
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

        
			if(numberThreads >= NUMBER_THREADS)
				{
					// There are too many threads. Wait for each run to end.
					while(numberThreads>0)
						{
#ifdef DEBUG
							std::cout << "Waiting on thread " 
									  << simulation[numberThreads-1].get_id() 
									  << std::endl;
#endif
							simulation[--numberThreads].join();
						}
				}


			// Make this run a separate thread.
			simulation[numberThreads++] = std::thread(singleApprox,
													  x0, y0, 
													  alpha, beta, 
													  gamma, delta, 
													  R, D, rho, x, 
													  &dataFile);
					
        }
    }

	while(numberThreads>0)
		{
			// close all remaining threads
			simulation[--numberThreads].join();
		}

    
	dataFile.close();
    return(0);
    
    
}


