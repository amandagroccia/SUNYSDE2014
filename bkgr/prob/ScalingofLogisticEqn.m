clear all
clf
n=10000;
T=5;
dt=T/n;
t=0:dt:T;
r=1; L=1;
q=3; R=2;
m=length(dt);
c = [ -2 .5 3];
col=['r';'g';'b'];
for i=1:3
    y=zeros(m,1);
    yscaled=y;

    y=c(i)*exp(r*t)./(1+(c(i)/L)*exp(r*t));
    yscaled=c(i)*exp(q*t)./(1+(c(i)/R)*exp(q*t));

    subplot(2,1,1) 
    title('Solutions to the Logistic Equation')
    plot(t,y,col(i))
    axis([0 T 0 4])
    xlabel('t')
    ylabel('y')
    hold on

    subplot(2,1,2)
    plot(t,yscaled,col(i))
    axis([0 T 0 4])
    xlabel('t')
    ylabel('y')
    
    hold on
end
hold off
hold off