MyVar <- c( 'a' , 'b' , 'c' , 'd' , 'e' )

MyVar[1] # Show element in first position 
MyVar[4] # Show element in fourth position 

MyVar[c(3,2,1)] # reverse order
MyVar[c(1,1,5,5)] # repeat indices

v <- c(0, 1, 2, 3, 4) # Create a vector named v
v[3] # access one element

v[1:3] # access sequential elements
#012
v[-4] # remove elements by index location
#0134

v[c(1, 4)] # access non-sequential indices
# 03

mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #create a matrix
mat1

mat1[1,2]
#2

mat1[1,2:4] #row 1 cols 2 to 4
#2.3.4

mat1[1:2,2:4]#selects a 2 by 3 grid

mat1[1,] # First row, all columns
mat1[,1] # First column, all rows





