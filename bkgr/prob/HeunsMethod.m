%% Heun's Method 
% For the system:    y' = ry,   y(0) = 1   over the interval [0,T]
%% True Solution
clear all
N=30:10:500; T=1; r=1; % N is # of approximations to make for y(T)
dt=zeros(N,1);
%c=10; % constant interval of increase for dt
%n=zeros(N,1);
dt = T./N;
y0=1; k=y0; % ytrue(1)=y(0) init. condition
ytrue=k*exp(r*T);
%% Heun's Approximation 
% yheun=zeros(N+1,1); yheun(1)=ytrue(1);
j=1;
errheun=zeros(size(dt,2),1);
while (j<=size(dt,2))
    yheun=y0;
    i=2;
    while (i<=N(j)+1)
        k1=r*yheun; k2=r*(yheun+dt(j)*k1);
        yheun=yheun+.5*dt(j)*(k1+k2);
        i=i+1;
    end
    errheun(j)=abs(yheun-ytrue);
    j=j+1;
end
%loglog([0:c:dt(N)],errheun,'r*')
%% Euler's Method
%yeuler=zeros(N+1,1); yeuler(1)=ytrue(1); 
erreul=zeros(size(dt,2),1);
j=1;
while (j<=size(dt,2))
    yeuler=y0;
    i=2;
    while (i<=(N(j)+1))
        yeuler=yeuler+dt(j)*r*yeuler;
        i=i+1;
    end
    erreul(j)=abs(yeuler-ytrue); 
    j=j+1;
end    
loglog(dt,errheun,'r*',dt,erreul,'*'); %hold off
xlabel('dt')
ylabel('error')
legend('Heuns','Eulers')
