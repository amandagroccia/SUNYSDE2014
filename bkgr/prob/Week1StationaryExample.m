% Find stationary matrix and probability vector
clear all
%clc
n=1000;
P=[0 1/3 .5 .5 0;1/3 0 .5 0 .5;1/3 1/3 0 0 0;1/3 0 0 0 .5;0 1/3 0 .5 0];
p0=[1 0 0 0 0]'; %initial condition
[V,L]=eig(P);
%Say we want to know the probability of going to any point on the nth step
invV=inv(V);
Pn=V*(L^n)*invV;
prob=Pn*p0; % prob=[P(X=A), P(X=B), ..., P(X=E)] --- stationary distribution
%sum(prob)   %Check that cols add to 1
%% Simulation
clear all
N=20000;
data=zeros((N/2),1);
state=1;
P=[0 1/3 .5 .5 0;1/3 0 .5 0 .5;1/3 1/3 0 0 0;1/3 0 0 0 .5;0 1/3 0 .5 0];
t=1;
while (t<=N)
    if (t>N/2) 
        data(t-N/2,1)=state; %enters data for the second increments 
    end
    r=rand(1); newstate=1;
    while (r>0)
        r=r-P(newstate,state);
        if (r>0)
            newstate=newstate+1;
        end
    end
    state=newstate;
    t=t+1;
end
i=1; countdata=zeros(5,1);
while (i<N/2)
    X=data(i,1);
    countdata(X,1)=countdata(X,1)+1; %number of occurances of each state
    i=i+1;
end
freq=countdata./(N/2) 
%% Save data
save('travelingenvelopedata.csv','data','-ascii')