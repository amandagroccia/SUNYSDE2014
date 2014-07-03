delta <- .4
gamma <- .8
rho <- 1
R <- 3
D <- 7
alpha <- .3
beta <-.2

x1 <- seq(0, 1.1, by=.05)
y1 <- ((1-x1)-gamma/(x1+D))     ### x null-cline
plot(x1,y1, xlim=c(0,1.1),ylim=c(0,1.1),col=2,type="l")
points (c(0,0),c(0,1.1),col=2,type="l")

y2 <- seq(0,1.1,by=.005)
x2 <- (rho*(1-y2)-delta/(y2+R))     ### y null-cline
points (x2,y2,col=3,type="l")
points (c(0,1.1),c(0,0),col=3,type="l")      

legend (.8,.8,c("xnullcline","ynullcline"),col=c(2,3), lty=c(1,1))
