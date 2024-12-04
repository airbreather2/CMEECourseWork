install.packages(c("tidyverse"))

MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = FALSE)) #imports data as is to be able to wrangle it, otherwise assumes headers
class(MyData)

MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = TRUE,  sep=";")# used semi colons as delimiter as there are commas in field descriptions
class(MyMetaData)

myMetaData

head(MyData)

view(MyData)

MyData[MyData == ""] = 0