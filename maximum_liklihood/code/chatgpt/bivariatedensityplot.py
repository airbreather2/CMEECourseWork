import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal

# Step 1: Define the mean vector (mu) and covariance matrix (Sigma)
mu = [5, 60]  # Mean: X (Height) = 5 ft, Y (Weight) = 70 kg
Sigma = [[0.5, 0.8],  # Variance of X, Covariance of X & Y
         [0.8, 1]]  # Covariance of X & Y, Variance of Y

# Step 2: Generate a grid of X and Y values
x, y = np.meshgrid(np.linspace(2, 8, 100), np.linspace(50, 90, 100))
pos = np.dstack((x, y))  # Combine X and Y into a position grid

# Step 3: Compute the bivariate normal distribution
rv = multivariate_normal(mu, Sigma)  # Create the bivariate normal distribution
pdf = rv.pdf(pos)  # Compute probability density function values

# Step 4: Plot the contour plot (like a 3D heatmap)
plt.figure(figsize=(8,6))
plt.contourf(x, y, pdf, cmap='coolwarm')  # Filled contour plot
plt.colorbar(label="Density")  # Color scale
plt.xlabel("Height (feet)")
plt.ylabel("Weight (kg)")
plt.title("Bivariate Normal Distribution")
plt.show()

