climate <- read.table(file="http://www.massey.ac.nz/~mhazelto/161223/data/climate.txt", header=T)


# E1.1.i
# the last observation was made at location A is 1924, March as shown below

LastObservationAtA <- tail(climate[!is.na(climate$A.temp),], 1)
LastObservationAtA$Year - 1 + 1863
LastObservationAtA$Month

# E1.1.ii
# the first observation was made at location B is 1924, January as shown below

FirstObservationAtB <- head(climate[!is.na(climate$B.temp),], 1)
FirstObservationAtB$Year - 1 + 1863
LastObservationAtA$Month


barplot(climate[, 5]) # todo: labels + down to 1919
