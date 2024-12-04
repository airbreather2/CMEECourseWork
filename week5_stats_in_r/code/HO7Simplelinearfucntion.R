rm(list=ls())
x<-seq(from = -5, to = 5, by = 1)
x
x[[1]]
## [1] -5
x[[2]]
## [1] -4
x[[9]]
## [1] 3
x[[length(x)]] #the last elements index is the same as the length of the sequence
## [1] 5

i<-1
x[[i]]

i<- seq(0,10,1)
i

a<-2 #intercept 
b<-1 #slope
y<-a+b*x
plot(x,y)


plot(x,y) 
segments(0,-10,0,10, lty=3) #add cartesian axes to see intercept better
segments(-10,0,10,0,lty=3)

?abline #adds line/lines to existing plots

plot(x,y, col="black")
segments(0,-10,0,10, lty=3)
segments(-10,0,10,0,lty=3)
abline(a = 2, b=1) #only need intercept and slope to plot the line

# Add a point at (4, 0) with red color and filled circle symbol
points(4, 0, col="red", pch=19)  # col="red" sets color to red, pch=19 sets the symbol to a filled circle

# Add a point at (-2, 6) with green color and a different symbol (open circle with a plus sign)
points(-2, 6, col="green", pch=9)  # col="green" sets color to green, pch=9 sets the symbol to an open circle with a plus sign

# Plot multiple points defined by vectors x and y, each with a different plotting symbol
points(x, y, pch=c(1,2,3,4,5,6,7,8,9,10,11))  # pch=c(1,2,3,...) assigns a sequence of different symbols for each point

#plot the quadratic function

y<-x^2
plot(x,y)
segments(-30,0,30,0,lty=3) #starts at point -30, 0 and ends at point 30, 0
segments(0,-30,0,30, lty=3)

#give linear function intercept of a-2
x<-seq(from = -5, to = 5, by = 0.1)
a<- -2
y<-a+x^2
plot(x,y)
segments(0,-30,0,30, lty=3)
segments(-30,0,30,0,lty=3)

plot(x,y)
a<- -2
b<-3
y<-a+b*x^2 #gave the curve a higher slope
points(x,y, pch=19, col="red")
segments(0,-30,0,30, lty=3)
segments(-30,0,30,0,lty=3)

#𝑦 = 𝑎 + (𝑏1 ∗ 𝑥) + (𝑏2 ∗ 𝑥 " )

plot(x,y)
a<- -2
b1<- 10
b2<-3
y<-a+b1*x+b2*x^2
points(x,y, pch=19, col="green")
segments(0,-100,0,100, lty=3)
segments(-100,0,100,0,lty=3)

#find highest y point in equation
x<-seq(from = -100, to = 100, by = 1)
plot(x, y, type="n", xlim=c(-100, 100), ylim=c(-1000, 1000), main="Plot with Adjusted Scales")
a<- -1
b1<- 2
b2<-0.15
y<-a+b1*x-b2*x^2
points(x,y, pch=19, col="green")
segments(0,-1000,0,1000, lty=3)
segments(-1000,0,1000,0,lty=3)
max_y_index <- which.max(y)  # Find the index of the maximum y value
highest_x <- x[max_y_index]  # Get the corresponding x value
highest_y <- y[max_y_index]  # Get the highest y value# Find the index of the maximum y value
points(highest_x, highest_y, col="red", pch=19)
text(highest_x, highest_y, labels=paste("Max y =", round(highest_y, 2)), pos=3) # pos=3 places the text above the point for better visibility
