function [theRoot] = newtonIterations(x,delta, gamma, rho, R, D, ...
                                      alpha, beta, ...
                                      shrimpRate, jacobian, ...
                                      gammaValues)

    numberGamma = size(gammaValues,2);
    theRoot = zeros(1,2);
    maxiter = 100;
    lupe = 0;
    tol = 1e-7;
    for gamma = gammaValues
        for (iter=1:maxiter)
            xold=x;
            F = shrimpRate(x(1),x(2),delta, gamma, rho, R, D, alpha, beta);
            J = jacobian(x(1),x(2),delta, gamma, rho, R, D, alpha, beta);
            x=xold-J\F;
            if(norm(x-xold,inf)<tol)
                %fprintf('Convergence to within tolerance in iter=%i .\n', ...
                %        iter)
                lupe = lupe + 1;
                theRoot(lupe,1:2) = x';
                break
            end
        end
    end
