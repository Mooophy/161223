climate <- read.table(file="http://www.massey.ac.nz/~mhazelto/161223/data/climate.txt",header=T)

year.full = climate[,1] - 1 + 1863
climate["full"] <- year.full
climate
barplot(climate[,5]) # todo: labels + down to 1919
