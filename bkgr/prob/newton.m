function [x, J, iter]=newton(x, tol, maxiter, ...
                             delta, gamma, rho, R, D, alpha, beta)

for (iter=1:maxiter)
    xold=x;
    [F,J]=fncn(xold, delta, gamma, rho, R, D, alpha, beta);
    n=numel(x);
    x=xold-J\F;
    if(norm(x-xold,inf)<tol)
        fprintf('Convergence to within tolerance in iter=%i .\n', iter)
        return
    end
end
end

function [F,J]=fncn(xvec, delta, gamma, rho, R, D, alpha, beta)

x=xvec(1); y=xvec(2);
f1=x*x*(1-x)-alpha*x*y-(gamma*x*x)/(x+D);
f2=rho*y*y*(1-y)-beta*x*y-(delta*y*y)/(y+R);
F=[f1;f2];
df1dx=2*x-3*x*x-alpha*y-gamma*x*((x+2*D)/((x+D).^2));
df1dy=-alpha*x;
df2dx=-beta*y;
df2dy=-rho*y*y+2*rho*y*(1-y)-beta*x-delta*y*((y+2*R)/((y+R).^2));
J=[df1dx df1dy;df2dx df2dy];
end
