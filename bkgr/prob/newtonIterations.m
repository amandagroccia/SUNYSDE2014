function [theRoot] = newtonIterations(x,delta, gamma, rho, R, D, ...
                                      alpha, beta, ...
                                      shrimpRate, jacobian, ...
                                      gammaValues)

    numberGamma = size(gammaValues,2);
    theRoot = zeros(1,3);
    maxiter = 100;
    lupe = 0;
    tol = 1e-7;
    for gamma = gammaValues
        startx = x;
        for (iter=1:maxiter)
            xold=x;
            F = shrimpRate(x(1),x(2),delta, gamma, rho, R, D, alpha, beta);
            J = jacobian(x(1),x(2),delta, gamma, rho, R, D, alpha, beta);
            x=xold-J\F;
            if(norm(x-xold)<tol)
                %fprintf('Convergence to within tolerance in iter=%i .\n', ...
                %        iter)
                lupe = lupe + 1;
                theRoot(lupe,1:2) = x';
                theRoot(lupe,3) = gamma;
                break
            elseif (norm(x-startx)>0.2)
                return
            end
        end
    end
