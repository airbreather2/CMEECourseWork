#Dataframes are most versatile, can contain mixed data
#also column and row names

Col1 <- 1:10
Col1
# 12345678910

Col2 <- LETTERS[1:10]
Col2
# 'A''B''C''D''E''F''G''H''I''J'

Col3 <- runif(10) # 10 random numbers from a uniform distribution
Col3

MyDF <- data.frame(Col1, Col2, Col3)
MyDF #now combined into a dataframe

#assign names to the frame
names(MyDF) <- c("MyFirstColumn", "My Second Column", "My.Third.Column")
MyDF

MyDF$MyFirstColumn #to easily access 

#don't name things with spaces
MyDF$My Second Column
#throws error

#replace name
colnames(MyDF)
colnames(MyDF)[2] <- "MySecondColumn"
MyDF

#you can access using numerical indexing
MyDF[,1]
#all elements of column 1
MyDF[1,1]
#1 

MyDF[c("MyFirstColumn","My.Third.Column")] # show two specific columns only


class(MyDF) #'data.frame'

str(MyDF) #gives meaty breakdown

head(MyDF) tail(MyDF)
#print bottom and top few rows 

#matrix and dataframe have difference memory usage
MyMat = matrix(1:8, 4, 4)
MyMat
object.size(MyMat) # returns size of an R object (variable) in bytes
# 280 bytes


MyDF = as.data.frame(MyMat)
MyDF
object.size(MyDF)
#1152 bytes


