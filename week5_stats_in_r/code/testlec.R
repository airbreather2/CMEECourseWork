x <-c(1,2,3,4,8,1,1)
y <-c(4,3,5,7,9,4,5)
model1 <- lm(y~x)
model1
summary(model1)
anova(model1)
resid(model1) # Extract the residuals, or differences between observed and predicted values.
cov(x, y) # Calculate the covariance between 'x' and 'y', showing how they vary together.
var(x) # Calculate the variance of 'x', which measures the spread of 'x' values.
plot(y~x)
abline(model1)    # Adds the regression line from 'model1' to an existing plot of 'y' vs 'x'.

