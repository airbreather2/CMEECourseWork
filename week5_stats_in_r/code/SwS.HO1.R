
rm = (list=ls()) #removes variables in workspace

#set wd
getwd() 
setwd("/cloud/project/SwS01Workspace")
getwd()

#create vectors of different formats
myNumericVector <- c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9)
myCharacterVector <- c("low","low","low","low","high","high","high","high")
myLogicalVector <- c(TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE)

str(myNumericVector) #get structure of any variable
#eg first is: ##
#num [1:8] 1.3 2.5 1.9 3.4 5.6 1.4 3.1 2.9

myMixedVector <-c(1, TRUE, FALSE, 3, "help", 1.2, TRUE, "notwhatIplanned")
str(myMixedVector)
#mixing variables causes r to assume it as strings, avoid doing this

install.packages("lme4") #install packages in r
library(lme4)
require(lme4) #returns false if package missing so usually used insdide of a function: like so 

if (require(ggplot2)) {
  # Proceed with ggplot2 functions
} else {
  warning("ggplot2 package not available.")
}

help() #to get help

sqrt(4); 4^0.5; log(0); log(1); log(10); log(Inf)


#function exp and we should type in exp(1)
exp(1)

#enter data in like this: 
d<-read.table("../data/SparrowSize.txt", header=TRUE)
str(d)# In R, str() provides a compact, human-readable summary of an object's structure.
summary(d)# gives mean med and mode etc of data
head(d) #gives data structure, top row of info 


table(d$Year)# gives us how man captures a year (by counting number of years recorded)

table(d$BirdID)

table(table(d$BirdID)) #creates a table of a table and thus how many multiple captures

require(tidyverse)
require(dplyr)

BirdIDCount <- d %>% count(BirdID, sort=TRUE) #pipe passes d into count function, sort puts output in decending order by count
print(BirdIDCount)
nbirdcount <- BirdIDCount %>% count(n) #number of ns are counted in birdID
print(nbirdcount)

sum(nbirdcount[2:nrow(nbirdcount),2]) #sum of frequencies below first row, number of repeated birds

table(d$BirdID, d$Year)

repeat_counts <- d %>% count(Year, BirdID) #gives table year by sex
print(repeat_counts)

table(d$Year,d$Sex) #gives table year by sex



