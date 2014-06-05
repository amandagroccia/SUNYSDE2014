# make histogram
setwd("~/Summer 2014/REU")
data<-read.csv('bpath1firststeps.csv',header=FALSE,sep=',')
names(data)
hist(data$V1,probability=TRUE,breaks=100)
x<-seq(-3,3,by=0.05)
points(x,dnorm(x,mean=0,sd=1),type='l',col=2)

# confidence interval for mean
n=length(data$V1)
xbar=mean(data$V1)
s=sd(data$V1)
error <- qnorm(0.975)*s/sqrt(n)
left<-xbar-error
right<-xbar+error
#p-value calculation
z <- (xbar)/(s/sqrt(n))
2*pnorm(-abs(z))

#variance testing
chisq<- (n-1)*s^2