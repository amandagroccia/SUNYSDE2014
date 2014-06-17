% Heun's Method 
% For the system:    y' = ry,   y(0) = 1   over the interval [0,T]
%% True Solution
clear all
N=500; T=10; r=1; 
dt=T/N; 
ytrue=zeros(N+1,1); ytrue(1)=1; k=ytrue(1); % ytrue(1)=y(0) init. condition
i=2;
while (i<=N+1)
    ytrue(i,1)=k*exp(r*(i-1)*dt);
    i=i+1;
end
%% Heun's Approximation 
yheun=zeros(N+1,1); yheun(1)=ytrue(1); 
i=2;
while (i<=N+1)
    k1=r*yheun(i-1); k2=r*(yheun(i-1)+dt*k1);
    yheun(i)=yheun(i-1)+.5*dt*(k1+k2);
    i=i+1;
end
errheun=abs(yheun-ytrue);
%loglog([0:dt:T],error,'r*'); hold on
%% Euler's Method
yeuler=zeros(N+1,1); yeuler(1)=ytrue(1); 
i=2;
while (i<=N+1)
    yeuler(i)=yeuler(i-1)+dt*r*yheun(i-1);
    i=i+1;
end
erreul=abs(yeuler-ytrue); 
loglog([0:dt:T],errheun,'r*',[0:dt:T],erreul,'*'); %hold off
xlabel('t')
ylabel('error')
legend('Heuns','Eulers')