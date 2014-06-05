%% 
%Probability of k requests in the first minute
clear all
%clc
k=0; lambda=200;
prob=0;
pn=exp(-lambda);
% We had problems with the factorial!
while (k<=150)
   %prob=prob+((exp(-lambda)*lambda^k)/factorial(k));
   prob=prob+pn;
   k=k+1;
   pn=pn*lambda/k;
end
prob
%% 
%You know there were M requests in 1st min/hr. 
%What is prob of k in 2nd min/hr?
%same as just the probability of M in any min/hr? = 0
k=0; prob=0; lambda=200;
while (k==100)
   prob=prob+((exp(-lambda)*lambda^k)/factorial(k));
   k=k+1;
end
prob
