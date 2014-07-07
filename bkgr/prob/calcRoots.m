delta = .4; 
gamma = .8;
rho = 1;
R = 3; 
D = 7;
alpha = .2; 
beta =.2;

x = [.86,.61]';
tol = 1e-6;
maxiter = 100;


shrimpRate = @(x,y,delta, gamma, rho, R, D, alpha, beta) [ ...
    (x*x*(1-x)-alpha*x*y-(gamma*x*x)/(x+D)) ; ...
    (rho*y*y*(1-y)-beta*x*y-(delta*y*y)/(y+R)) ];

jacobian = @(x,y,delta, gamma, rho, R, D, alpha, beta) [ ...
    (2*x-3*x*x-alpha*y-gamma*x*((x+2*D)/((x+D).^2))) ...
    -alpha*x ;
    -beta*y ...
    (-rho*y*y+2*rho*y*(1-y)-beta*x-delta*y*((y+2*R)/((y+R).^2))) ...
    ];
    
x = [0.86,0.61]';
gammaMax = 8;
gammaValues = 0.0:0.001:gammaMax;

theRoot1 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);

x = [0.21,0.85]';
theRoot2 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);

x = [0.93,0.35]';
theRoot3 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);


which = 1;
plot(theRoot1(:,3),theRoot1(:,which),'k', ...
     [0 gammaMax],[0 0],'k', ...
     %[0 gammaMax],[1 1],'k', ...
     theRoot2(:,3),theRoot2(:,which),'k--', ...
     theRoot3(:,3),theRoot3(:,which),'k--')
xlabel('\gamma')
ylabel('Fixed Points (x)')
title('Bifurcation diagram with respect to \gamma')
axis([0 gammaMax -0.1 1.1])
