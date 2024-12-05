#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

b<-read.table("../data/BTLD.txt", header=T)

mean(b$ClutchsizeAge7, na.rm = TRUE) #mean clutch size when chicks are 7 days old

plot(b$LD.in_AprilDays.~b$Year, ylab="Laying date (April days)", xlab="Year",
     pch=19, cex=0.3)  #hard to see all points do this instead

plot(b$LD.in_AprilDays.~jitter(b$Year), ylab="Laying date (April days)", xlab
     ="Year", pch=19, cex=0.3)

require(ggplot2)
## Loading required package: ggplot2
p <- ggplot(b, aes(x=Year, y=LD.in_AprilDays.)) +
  geom_violin() #violin plot
p
#interpreted year as cxonitnous variable so looks wrong

boxplot(b$LD.in_AprilDays.~b$Year, ylab="Laying date (April days)", xlab="Yea
r") #tilda groups by year

p <- ggplot(b, aes(x=as.factor(Year), y=LD.in_AprilDays.)) +
  geom_violin() #this looks even nicer
p

p + stat_summary(fun.data="mean_sdl", #add mean and SD 
                 geom="pointrange")
