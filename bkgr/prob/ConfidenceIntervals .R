y <- read.csv("sillydata.csv") #reads in the file (this file is made up)
z <- table(as.factor(y$x)) #puts the numbers into a frequency table for the different categories 
N <- sum(z) #sums up the values for each category 
#category 1: species 1 lives while species 2 dies out
#category 2: species 2 lives while species 1 dies out
#category 3: species 1 and species 2 lives

# calculates sample proportions 
p1 <- z[1]/N #approximation of probability 1: the number of trials where species 1 lives divided by the whole population 
p2 <- z[2]/N #approximation of probability 2: the number of trials where species 2 lives divided by the whole population 
p3 <- z[3]/N #approximation of probability 3: the number of trials where both species live divided by the whole population 

#finding how many of the runs will fall into each category; sample variances for the sample proportions
s12 <- p1*(1-p1)/z[1] #s1 squared: category 1
s22 <- p2*(1-p2)/z[2] #s2 squared: category 2
s32 <- p3*(1-p3)/z[3] #s3 squared: category 3
  
l2 <- qchisq(.95,2) #finds l squared for the Chi Squared test; inverse Chi Squared 

#finds lower and higher confidence intervals for the seperate categories
lci1 <- p1 - sqrt(s12*l2) #lower confidence interval 
hci1 <- p1 + sqrt(s12*l2) #higher confidence interval 
#prints the values for the confidence intervals in a sentence form
print(paste("The confidence interval for p1 is from", lci1, "to", hci1,"."))

lci2 <- p2 - sqrt(s22*l2)
hci2 <- p2 + sqrt(s22*l2)
print(paste("The confidence interval for p2 is from", lci2, "to", hci2,"."))

lci3 <- p3 - sqrt(s32*l2)
hci3 <- p3 + sqrt(s32*l2)
print(paste("The confidence interval for p3 is from", lci3, "to", hci3,"."))