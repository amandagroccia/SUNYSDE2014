%% Heun's Method for SUNY SDE 2014 System of Equations (Killer Shrimp)
%
%    dx/dt =     (x^2)*(1-x)  - \alpha*x*y - (\gamma*(x^2))/(x+D);
%    dy/dt = \rho*(y^2)*(1-y) - \beta*x*y  - (\delta*(y^2))/(y+R);
% 
% with \rho=1, \alpha=\beta=??, \gamma=??, \delta=??, D=??, R=??.
% 
% Parameters:
%   \rho is a birth rate
%   \alpha & \beta are intraguild predation rates
%   \gamma & \delta are intraspecific predation rates (cannibalism)
%   D & R regulate intraspecific predation rates 
%
% Interval: [0,T]
%
% Let p=\rho, a=\alpha, b=\beta, g=\gamma, d=\delta.
%
%% 
N = 300;
T = 1;
x0 = 1; y0 = 1;
p = 1; 
a = .5; b = .5;
g = .5; d = .5;
D = 5;  R = 5;
[x,y] = Heun(N, T, x0, y0, p, a, b, g, d, R, D);