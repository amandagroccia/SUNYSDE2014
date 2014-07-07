function [x,y] = Heun(N, T, x0, y0, rho, alpha, beta, gamma, delta, R, D)
dt = T/N;
%currentTime = 0;
step = 1;
x = zeros(N,1); y = zeros(N,1);
x(1) = x0; y(1) = y0; %
while (step <= N) %
    [d1fx,d1fy] = pop(x(step), y(step), rho, alpha, beta, gamma, ...
        delta, R, D);
    x2 = x(step) + .5*dt*d1fx;
    y2 = y(step) + .5*dt*d1fy;
    [d2fx,d2fy] = pop(x2, y2, rho, alpha, beta, gamma, delta, R, D);
    x(step+1) = x(step) + .5*dt*(d1fx + d2fx);
    y(step+1) = y(step) + .5*dt*(d1fy + d2fy);
    step = step + 1;
end
end

function [dx,dy] = pop(x, y, rho, alpha, beta, gamma, delta, R, D)
dx = x*x*(1-x) - alpha*x*y - (gamma*x*x)/(x+D);
dy = rho*y*y*(1-y) - beta*x*y - (delta*y*y)/(y+R);
end