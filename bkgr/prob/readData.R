
############################################################
# Define readMonteCarlo
#
# This is a function to read in a data file from the
# Monte Carlo simulation and create new factors based
# on the values of gamma and delta.
#
# Useage:
#
#   data <- readMonteCarlo("path/to/file/filename.csv")
#
readMonteCarlo <- function(fileName,useHeader=TRUE)
    {
        data <- read.csv(fileName,header=useHeader)
        data$gammaFactor <- as.factor(data$gamma)
        data$deltaFactor <- as.factor(data$delta)
        return(data)
    }


# Below here is an example of how to use the function after it has
# been read in.

print("reading the data")
data <- readMonteCarlo("c/shrimpSimulation/shrimpSimulation/shrimpSimulation/shrimpResults.csv")

print("Making a box plot for the x data by gamma")
boxplot(data$x ~ data$gammaFactor,main="Values of x for Different Simulations",
        xlab=expression(gamma))

print("Making a box plot for the x data by delta")
boxplot(data$x ~ data$deltaFactor,main="Values of x for Different Simulations",
        xlab=expression(delta))



# Make a contour plot of the data. First load the lattice module
library(lattice)


# Go through every level of gamma and delta and calc. the mean and
# std. deviation.
gammaLevels <- levels(data$gammaFactor)
deltaLevels <- levels(data$deltaFactor)
xMeans  <- numeric(0)
xStdDev <- numeric(0)
yMeans  <- numeric(0)
yStdDev <- numeric(0)

gammaVals <- numeric(0)
deltaVals <- numeric(0)

print("Calculating the mean and std. dev's of the x and y values")
for (delta in deltaLevels)
    {
        for (gamma in gammaLevels)
            {
                ## Calc. the mean and std. of x for the different values of
                ## delta and gamma.
                xMeans  <- c(xMeans,mean(data$x[(data$gammaFactor==gamma) &
                                                (data$deltaFactor==delta)]))
                xStdDev <- c(xStdDev, sd(data$x[(data$gammaFactor==gamma) &
                                                (data$deltaFactor==delta)]))

                ## Calc. the mean and std. of y for the different values of
                ## delta and gamma.
                yMeans  <- c(yMeans,mean(data$y[(data$gammaFactor==gamma) &
                                                (data$deltaFactor==delta)]))
                yStdDev <- c(yStdDev, sd(data$y[(data$gammaFactor==gamma) &
                                                (data$deltaFactor==delta)]))

                gammaVals <- c(gammaVals,as.double(gamma))
                deltaVals <- c(deltaVals,as.double(delta))
            }
    }

## Plot a contour plot of the means for x for different values of
## gamma and delta.
print("making a contour plot for the x means")
levelplot(xMeans ~ gammaVals*deltaVals,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue", "white")),
          main="Mean X")

## Plot a contour plot of the means for y for different values of
## gamma and delta.
print("making a contour plot for the y means")
levelplot(yMeans ~ gammaVals*deltaVals,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue","white")),
          main="Mean Y")

