#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
#desc: question3 

# Define the Monod growth function
monod_growth <- function(N, a, k) {
  return((a * N) / (k + N))
}

# Generate a range of N values
N <- seq(0, 20, by = 0.1)

# Define the parameters for each curve
parameters <- list(
  list(a = 5, k = 1),
  list(a = 5, k = 3),
  list(a = 8, k = 1)
)

# Set up the plot
plot(N, monod_growth(N, parameters[[1]]$a, parameters[[1]]$k),
     type = "l", col = "blue", lwd = 2, ylim = c(0, 10),
     xlab = "N (Nutrient Concentration)", ylab = "r(N) (Growth Rate)",
     main = "Monod Growth Function")

# Add the other curves
lines(N, monod_growth(N, parameters[[2]]$a, parameters[[2]]$k), col = "red", lwd = 2)
lines(N, monod_growth(N, parameters[[3]]$a, parameters[[3]]$k), col = "green", lwd = 2)

# Add a legend
legend("bottomright", legend = c("a=5, k=1", "a=5, k=3", "a=8, k=1"),
       col = c("blue", "red", "green"), lty = 1, lwd = 2)
