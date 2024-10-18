a <- 4 #store 4 as a variable a
a
a * a 

a_squared <- a * a

sqrt(a_squared) # square root

v  <- c(0,1,2,3,4)

v # Display the vector-valued variable you created

is.vector (v) #check if v's a vector
#TRUE

mean(v) 
#mean

var(v) #variance
#2.5

median(v) #median 

sum(v) #sum all elements

sum (v) #sum all elements

prod (v + 1) # adds one to each element of vector
#then multiplies so new vector is c(0,1,2,3,4,5)

length(v) # how many elements in the vector

#In R you can name variables in the following way
#to keep track of variables

wing.width.cm <- 1.2 #using dot notation
wing.length.cm <- c(4.7, 5.2, 4.8)
wing. #hitting tab brings up variables with name style

#usual variables are available in r

x <- (1 + (2*3)
#will show + on next line to indicate this is a continuation statement
#closing brackets fixes this
x <- (1 + (2*3))

x[4] 4th element of the vector x
li[[3]] #third element of list

#variable types

v <- TRUE
v

class(v) #logical
#class tells you what type any variable is in the workspace

v <- 3.2 
class(v)
#numeric

v <- 2L
#integer

v <- "A string"
#character

b <- NA
#logical

is.na(b)
#is.*  family of functions allows you to check if the variable is specific to r

b <- 0/0
b 

is.nan (b)
b <- 5/0
b

is.nan(b)

is.infinite(b)
#TRUE
is.finite(b)
#TRUE
is.finite(0/0)
#FALSE

as.* commands all convert a variable from one type to another
as.integer(3.1)
#3

as.numeric(4)
#4

as.roman(155)
#CLV roman numerals

as.logical(5)
#TRUE

as.logical(0)
#false
#0 false any other number true




