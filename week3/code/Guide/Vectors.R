#Ordered collection of any of the R data types

a <- 5 
is.vector(a)
#TRUE : is treated as vector length of 1

v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)
v1;v2;v3

#vectors in r can only store a single data type
v1 <- c(0.02, TRUE, 1)
v1 #homogenised to numbers

v1 <- c(0.02, "Mary", 1)
v1
# '0.02''Mary''1'
#gets converted to text as there is a heirarchy

#create empty vectors like this: 
v2 <- character(3) # an empty vector 'character' with 3 elements
v2
#''''''
v3 <- numeric(3) # an empty numeric 'character' with 3 elements
v3
# 0-0-0

