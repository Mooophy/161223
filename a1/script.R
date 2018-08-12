climate <- read.table(file="http://www.massey.ac.nz/~mhazelto/161223/data/climate.txt", header=T)

# add a new column for full year for later use
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

# E1.1.2
# estimates of the mean temperature by month in both locations C and D
tapply(climate$C.temp, climate$Month, mean)
tapply(climate$D.temp, climate$Month, mean)
