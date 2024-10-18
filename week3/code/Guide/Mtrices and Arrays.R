#2 dimensional vector, Like vectors can only use one type of data 


mat1 <- matrix(1:25, 5, 5)
mat1

print(mat1)

mat1 <- matrix(1:25, 5, 5)#populates 5x5 matrix from numbers 1 to 25
mat1
mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #orders numbers by row
mat1
dim(mat1) #gives size of matrix


# for storing data in more than 2 dimensions (e.g a stack of 2-D matrices). can only store 1 data type.
# To make an array consisting of two 5
# 5 matrices containing the integers 1-50:
arr1 <- array(1:50, c(5, 5, 2))
arr1[,,1]
arr1[,,1] # will do the matrix with numbers continuing on from 25??

mat1[1,1] <- "one"
mat1
#populates that field with one
#matrix data type became char

arr1 <- array(1:24, dim = c(3, 4, 2))
# This code generates an array with:
#3 rows,
#4 columns, and
#2 slices (third dimension).


