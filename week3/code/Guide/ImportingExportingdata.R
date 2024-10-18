
getwd()

setwd("Documents/CMEECourseWork/week3")

file.exists("data/trees.csv")

MyData <- read.csv("data/trees.csv")


ls(pattern = "My*") # Check that MyData has appeared

class(MyData)

str(MyData) # Note the data types of the three columns

MyData <- read.csv("data/trees.csv", header = F) # Import ignoring headers

head(MyData)

MyData <- read.table("data/trees.csv", sep = ',', header = TRUE) #another way

#you can load data using the more general read.table function: 
MyData <- read.table("../data/trees.csv", sep = ',', header = TRUE) #another way

head(MyData)

MyData <- read.csv("../data/trees.csv", skip = 5) # skip first 5 lines

#save your data frames using
write.csv(MyData, "../results/MyData.csv")

write.table(MyData[1,], file = "../results/MyData.csv",append=TRUE) # append
#You get a warning with here because R thinks it is strange that you are appending headers to a file that already has headers!

write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # write row names
write.table(MyData, "../results/MyData.csv", col.names=FALSE) # ignore col names

