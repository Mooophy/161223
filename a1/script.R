climate <- read.table(file="http://www.massey.ac.nz/~mhazelto/161223/data/climate.txt", header=T)
climate["FullYear"] <- climate[, 1] - 1 + 1863

# E1.1.i
# the last observation was made at location A is 1924, March as shown below

LastObservationAtA <- tail(climate[!is.na(climate$A.temp),], 1)
LastObservationAtA$FullYear
LastObservationAtA$Month

# E1.1.ii
# the first observation was made at location B is 1924, January as shown below

FirstObservationAtB <- head(climate[!is.na(climate$B.temp),], 1)
FirstObservationAtB$FullYear
FirstObservationAtB$Month

# E1.2
# estimates of the mean temperature by month in both locations C and D
tapply(climate$C.temp, climate$Month, mean)
tapply(climate$D.temp, climate$Month, mean)

# E1.3
# plot as below
barplot(
  climate[ climate$FullYear == 1919 ,]$C.temp, 
  main = "Monthly Temperatures At Location C In 1919", 
  xlab = "Months", 
  ylab = "Temperatures", 
  names.arg = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), 
  col = 5
)

legend(
  "topright", 
  legend= c("Real", "Imputed"),
  fill = c(5, 6)
)

# E1.4
source("http://www.massey.ac.nz/~mhazelto/161223/kNNImpute.R")
Imputed <- kNNImpute(climate, k = 5)$x

# plot as below
barplot(
  Imputed[ Imputed$FullYear == 1924 ,]$A.temp, 
  main = "Monthly Temperatures At Location A In 1924", 
  xlab = "Months", 
  ylab = "Temperatures", 
  names.arg = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), 
  col = is.na(climate[ climate$FullYear == 1924 ,]$A.temp)  + 5
)

legend(
  "topright", 
  legend= c("Real", "Imputed"),
  fill = c(5, 6)
)

# E2
athlete <- read.table(file="http://www.massey.ac.nz/~mhazelto/161223/data/athlete.txt",header=T)
pairs(athlete, col = (athlete$Sport == "Sprint") + 1)

# E2.1
plot(athlete$Wt, athlete$LBM, col = (athlete$Sport == "Sprint") + 1)
athlete[athlete$LBM > 55 & athlete$LBM < 60 & athlete$Wt > 55 & athlete$Wt < 60, ]

# as pairs and Wt ~ LBM shown the 247 entry should be incorrected.
a <- athlete
a[247, ]$Wt <- a[247, ]$LBM <- NA

# as shown below, the Wt and LBM should be 63.36 and 55.792  
im <- kNNImpute(a[, 1:11], k = 5)$x
im[247, ]$Wt
im[247, ]$LBM

# E2.2 as shown by pairs plot and the three following plot, the three variables: WCC, HC and RCC are best at separating data between the sprinters and 400m group
plot(athlete$RCC, athlete$WCC, col = (athlete$Sport == "Sprint") + 1)
plot(athlete$RCC, athlete$Hc, col = (athlete$Sport == "Sprint") + 1)
plot(athlete$WCC, athlete$Hc, col = (athlete$Sport == "Sprint") + 1)

# E3 the plot can be obtained by running the following code
par(mar=c(5,4,2,2)+0.1)
zones <- matrix(c(2,0,1,3), ncol=2, byrow=T)
layout(zones, widths=c(3,1), heights=c(1,3))

x <- Imputed$C.temp
y <- Imputed$D.temp

plot(
  x,
  y, 
  xlab = "Temperature at C", 
  ylab = "Temperature at D",
  col = (Imputed$Month < 4 | Imputed$Month > 9) * 3 + 2
)

smoothingSpline = smooth.spline(x, y, spar = 1)
lines(smoothingSpline, lwd = 2)

legend(
  "topleft",
  legend= c("Summer", "Winter"),
  fill = c(2, 5)
)

xhist <- hist(x, breaks = 20, plot = F)
yhist <- hist(y, breaks = 20, plot = F)

par(mar=c(0,4,2,2))
barplot(xhist$counts, axes=F, space=0, horiz=F)

par(mar=c(5,0,2,2))
barplot(yhist$counts, axes=F, space=0, horiz=T)
