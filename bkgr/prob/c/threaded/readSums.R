results <- read.csv("mulNoiseResults.csv")
N <- 45000


results$sx <- results$sx/N
results$sy <- results$sy/N
results$sx2 <- (results$sx2-N*results$sx*results$sx)/(N-1)
results$sy2 <- (results$sy2-N*results$sy*results$sy)/(N-1)

library(lattice)

## Plot a contour plot of the means for x for different values of
## gamma and delta.
print("making a contour plot for the x means")
levelplot(results$sx ~ results$gamma*results$delta,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue","white")),
          main="Sample Mean of X")

## Plot a contour plot of the means for y for different values of
## gamma and delta.
print("making a contour plot for the y means")
levelplot(results$sy ~ results$gamma*results$delta,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue","white")),
          main="Sample Mean of Y")

## Plot a contour plot of the means for x for different values of
## gamma and delta.
print("making a contour plot for the x variance")
levelplot(results$sx2 ~ results$gamma*results$delta,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue","white")),
          main="Sample Variance of X")

## Plot a contour plot of the means for y for different values of
## gamma and delta.
print("making a contour plot for the y variance")
levelplot(results$sy2 ~ results$gamma*results$delta,contour=TRUE,
          xlab=expression(gamma),ylab=expression(delta),
          col.regions = colorRampPalette(c("blue","white")),
          main="Sample Variance of Y")


