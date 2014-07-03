function [x, iter]=newton(x, tol, maxiter)
for (iter=1:maxiter)
    xold=x;
    [F,J]=fncn(xold);
    n=numel(x);
    x=xold(1,2:n)-J\F;
    if(norm(x-xold,inf)<tol)
        fprintf('Convergence to within tolerance in iter=%i .\n', iter)
        return
    end
end
end

function [F,J]=fncn(x)
%F=[15*x(1)+x(2)^2-4*x(3)-13;x(1)^2+10*x(2)-x(3)-11;x(2)^2-25*x(3)+22];
%J=[15 2*x(2) -4;2*x(1) 10 -1;0 2*x(2) -25];
% N=numel(x); h=1/(N+1);
% F(1)=-2*x(1)+h^2*cos(x(1))+x(2);
% F(N,1)=x(N-1)-2*x(N)+h^2*cos(x(N));
% J=sparse(N,N);
% J(1,1:2)=[-2-h^2*sin(x(1)) 1];
% J(N,N-1:N)=[1 -2-h^2*sin(x(N));
N=9;
%n=numel(x);
F=sparse(1,N+1);
F(1)=x(1); % f_0 = 0
F(N+2)=sum(x); % f_N+1 = c_0 + c_1 + ... + c_(N+1)
% %below initial condition and loop make all of the y_k's for the f's
% sumy=0;
% for k=1:N+1
%     sumy=sumy+x(k)*(k/(N+1))^k;
%     y(k)=sumy;
%     %below initial condition and loop make all of the y''_k's for the f's
%     sumydp=0;
%     for j=3:N+2
%         sumydp=sumydp+j*(j-1)*x(j)*()^(j-2)
%     end
% end
sum1=0; sum2=0;
for i=1:N+1
    for k=1:N+2 %makes the y_i for the f_i eqn
        sum1=sum1+x(k)*(i/(N+1))^k;
    end
    for j=3:N+2 %makes first part of f_i eqn
        sum2=sum2+j*(j-1)*x(j)*(i/(N+1))^(j-2);
    end
    F(i)=sum2-exp(sum1);
end
F=F';
J=sparse(N,N); %makes space for Jacobian
for m=1:N %rows
    for k=1:N+2 %makes the y_i for the f_i eqn
        sum1=sum1+x(k)*(i/(N+1))^k;
    end
    for p=2:N+1 %columns
        J(1,p)=p*(p-1)*(i/(N+1))^(p-2)-(i/(N+1))^p*exp(sum1);
    end
    J(m,1)=-(m/(N+1))*exp(sum1);
end
J(N+1,1:N+1)=1;

end