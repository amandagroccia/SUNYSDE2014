y <- read.csv("sillydata.csv")
z <- table(as.factor(y$x))
N <- sum(z)

p1 <- z[1]/N
p2 <- z[2]/N
p3 <- z[3]/N

s12 <- p1*(1-p1)/z[1] #s1 squared 
s22 <- p2*(1-p2)/z[2] #s2 squared 
s32 <- p3*(1-p3)/z[3] #s3 squared 
  
l2 <- qchisq(.95,2) #finds l squared for the Chi Squared test 

lci1 <- p1 - sqrt(s12*l2) #lower confidence interval
hci1 <- p1 + sqrt(s12*l2) #higher confidence interval 
print(paste("The confidence interval for p1 is from", lci1, "to", hci1,"."))

lci2 <- p2 - sqrt(s22*l2)
hci2 <- p2 + sqrt(s22*l2)
print(paste("The confidence interval for p2 is from", lci2, "to", hci2,","))

lci3 <- p3 - sqrt(s32*l2)
hci3 <- p3 + sqrt(s32*l2)
print(paste("The confidence interval for p3 is from", lci3, "to", hci3,"."))