% Heun's Method 
% For the system:
%   y' = ry,   y(0) = 1
%% True Solution
clear all
N=100000; T=5; r=1;
dt=T/N; 
ytrue=zeros(N+1,1); ytrue(1)=.2; k=ytrue(1);
i=2;
while (i<=N+1)
    ytrue(i,1)=k*exp(r*i*dt);
    i=i+1;
end
%% Approximation 
y=zeros(N+1,1); y(1)=ytrue(1); 
i=2;
while (i<=N+1)
    y(i)=y(i-1)+dt*(r*i*dt*y(i-1)+r*i*dt*(y(i-1)+(dt^2)*i*r*y(i-1)))/2;
    i=i+1;
end
%% Error Plots
error=abs(y-ytrue);
%loglog([0:dt:T],error,'r*'); hold on
%% Euler's Method
yeuler=zeros(N+1,1); yeuler(1)=ytrue(1); 
i=2;
while (i<=N+1)
    yeuler(i)=yeuler(i-1)+(dt^2)*i*r*y(i-1);
    i=i+1;
end
erreul=abs(yeuler-ytrue); 
loglog([0:dt:T],error,'r*',[0:dt:T],erreul,'*'); %hold off
xlabel('t')
ylabel('error')
legend('Heuns','Eulers')