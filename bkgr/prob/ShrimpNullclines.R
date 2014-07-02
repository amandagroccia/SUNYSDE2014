delta <- .4
gamma <- .3
rho <- 1
R <- 1.2
D <- 1.1
alpha <- .3
beta <-.2

x1 <- seq(0, 1.1, by=.05)
y1 <- ((1-x1)-gamma/(x1+D)) 
plot(x1,y1, xlim=c(0,1.1),ylim=c(0,1.1),col=2,type="l")
points (c(0,0),c(0,1.1),col=2,type="l")

y2 <- seq(0,1.1,by=.005)
x2 <- (rho*(1-y2)-delta/(y2+R))
points (x2,y2,col=3,type="l")
points (c(0,1.1),c(0,0),col=3,type="l")

