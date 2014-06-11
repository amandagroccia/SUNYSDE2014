ito<-read.csv('ito.csv',header=FALSE,sep=',')
itoerr<-read.csv('itoerr.csv',header=FALSE,sep=',')
summary(ito)
sd(ito$V1)
summary(itoerr)
sd(itoerr$V1)
hist(ito$V1,probability=TRUE,breaks=100)
hist(itoerr$V1,probability=TRUE,breaks=100)


# Does the distribution need to be normal for this CI?
#x<-seq(-3,3,by=0.05)
#points(x,dnorm(x,mean=0,sd=1),type='l',col=4)

# confidence interval for mean  
n=length(ito$V1)
xbar=mean(ito$V1)
s=sd(ito$V1)
error <- qnorm(0.975)*s/sqrt(n)
left<-xbar-error
right<-xbar+error
#p-value calculation
z <- (xbar)/(s/sqrt(n))
2*pnorm(-abs(z))