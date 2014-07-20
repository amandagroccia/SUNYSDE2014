% Script to generate a movie for a Milstein approximation for our SDE. 

%randn('state',100)          % set the state of randn
T=6; N=250; dt=T/N;          % Set up the bounds
skip = 5;                    % Plot every "skip" time steps.
colours = ['r-';'b-';'g-'];   % Define the colours to plot in
timeValues = 0:dt:T;         % Set up the time values


delta=.8; gamma=.5; rho=1; R=3; D=7; alpha=.5; beta=.5; upsilon=.1; kappa=.12;
xzero = .7;
yzero = .2;


% Set up the plotting window so it looks all nice and proper like.
clf;
subplot(2,1,1)
hold on
axis([0 T 0 1])
plot([0],[0],'r-',[0],[0],'b-',[0],[0],'g-')
legend('Run 1','Run 2','Run 3','Location','NorthEast');
legend boxoff

clear F;
frameNumber = 1;
for runNumber = 1:size(colours,1),
    
    currentRun = colours(runNumber,:);
    %printf('Printing using colour %s\n',currentRun)
    
    % Generate a sample Milstein approximation.
       % T = 6; N = 1000; dt = T/N;
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

    % Plot it in time.
    for k=2:skip:size(x(1,:),2),
        subplot(2,1,1)
        plot(timeValues(1:k+1),[0,x(1,(1:k))],currentRun)   % plot x against t
        axis([0 T 0 1])
        xlabel('t','FontSize',16)
        ylabel('x(t)','FontSize',16,'Rotation',0)
        title('2D Milstein Approximations')
        drawnow
        
        subplot(2,1,2)
        plot(timeValues(1:k+1),[0,x(2,(1:k))],currentRun)   % plot x against t
        axis([0 T 0 0.6])
        xlabel('t','FontSize',16)
        ylabel('y(t)','FontSize',16,'Rotation',0)
        hold on
        drawnow
        
        F(frameNumber) = getframe(gcf);
        frameNumber = frameNumber + 1;
    end
    
end

%movie(F)

%writerObj = VideoWriter('randomWalk.avi','Uncompressed AVI');
writerObj = VideoWriter('Milstein.mp4','MPEG-4');
open(writerObj);
writeVideo(writerObj,F);
close(writerObj)
