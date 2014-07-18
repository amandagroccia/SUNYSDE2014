clear all

delta=.8; gamma=.5; rho=1; R=3; D=7; alpha=.1; beta=.11; upsilon=.05; kappa=.06;
xzero = .2;
yzero = .8;

s=10000;
i=1;
result=zeros(2,s);
while (i<=s)
    T = 6; N = 1000; dt = T/N;
    dW = sqrt(dt).*randn(2,N+1);         % Brownian increments

    x=zeros(2,N+1);
    x([1:2],1)=[xzero;yzero];
    xtemp=x([1:2],1);
    for j = 1:N+1 
        X=xtemp(1,1); Y=xtemp(2,1);
        f1n = X*X*(1-X)-alpha*X*Y-(gamma*X*X)/(X+D); 
        f2n = rho*Y*Y*(1-Y)-beta*X*Y-(delta*Y*Y)/(Y+R); 

          % Additive Noise
        g1n = upsilon;
        g2n = kappa;
        xtemp = xtemp+dt*[f1n;f2n]+[g1n*dW(1,j);g2n*dW(2,j)];

%         % Proportional Noise
%         g1n = upsilon*X;
%         g2n = kappa*Y;
%         dg1dx = upsilon;
%         dg2dy = kappa;
%         xtemp = xtemp+dt*[f1n;f2n]+[g1n*dW(1,j);g2n*dW(2,j)]+...
%             [dg1dx*g1n*.5*((dW(1,j))^2-dt);0]+[0;dg2dy*g2n*.5*(((dW(2,j))^2)-dt)];

        if (xtemp(1,1) < 0)
            xtemp(1,1)=0;
        end
        if (xtemp(2,1) < 0)
            xtemp(2,1)=0;
        end
        x([1,2],j)=xtemp;
    end
    result([1,2],i)=x([1,2],N+1);
    i=i+1;
end
result=result';
% clf
% subplot(2,1,1)
% plot([0:dt:T],x(1,:))
% subplot(2,1,2)
% plot([0:dt:T],x(2,:))