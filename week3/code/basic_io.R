# A simple script to illustrate R input-output.  
# Run line by line and check inputs outputs to understand what is happening  
#setwd("Documents/CMEECourseWork/week3/code")

MyData <- read.csv("../data/trees.csv", header = TRUE) # import with headers

write.csv(MyData, "../results/MyData.csv") #write it out as a new file

write.table(MyData[1,], file = "../results/MyData.csv",append=TRUE) # Append to it

write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # write row names

write.table(MyData, "../results/MyData.csv", col.names=FALSE) # ignore column names

print("Script complete!")

### R CMD BATCH MyCode.R MyResults.Rout creates output file