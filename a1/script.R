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
Imputed <- kNNImpute(climate, k = 1)$x

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

# E3
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
