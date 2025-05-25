"""
📌 **Purpose of this Code**
This script calculates the **marginal distribution of Height (X)** from a **bivariate normal distribution** 
of **Height (X) and Weight (Y)** by numerically integrating out **Weight (Y)**. 

✅ **Key Fixes in This Version:**
1. **Corrected Numerical Integration:** 
   - Expanded integration limits to fully capture the range of Y.
2. **Improved Resolution:** 
   - Increased the number of X values for a smoother curve.
3. **Adjusted Correlation:** 
   - Reduced correlation to prevent numerical instability.

📊 **Expected Output:**
A **smooth, bell-shaped marginal distribution** of Height (X), which represents how likely different heights are, 
ignoring weight.

"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal
from scipy.integrate import quad

# Step 1: Define mean vector and covariance matrix
mu = [5, 70]  # Mean of X (Height) and Y (Weight)
Sigma = [[1, 0.5],  # Variance of X and correlation with Y
         [0.5, 4]]  # Correlation with X and variance of Y

# Step 2: Create the joint bivariate normal distribution
rv = multivariate_normal(mu, Sigma)

# Step 3: Define a finer grid for X (height) to ensure smooth integration
x = np.linspace(2, 8, 200)  # More points for better accuracy

# Step 4: Function to compute the marginal PDF of X by integrating out Y
def marginal_x(x, rv):
    """
    Computes the marginal probability density function (PDF) of X by integrating 
    out Y from the joint PDF.

    Parameters:
    x : float - The height value for which we compute f_X(x)
    rv : multivariate_normal - The joint probability distribution object

    Returns:
    float - The marginal probability density function f_X(x)
    """
    # Numerically integrate over Y from -10 to +10 standard deviations of Y to ensure full coverage
    y_min, y_max = mu[1] - 10 * np.sqrt(Sigma[1][1]), mu[1] + 10 * np.sqrt(Sigma[1][1])
    integral, _ = quad(lambda y: rv.pdf([x, y]), y_min, y_max)  
    return integral  # Return the computed marginal density for this X value

# Step 5: Compute the marginal distribution of X for all x values
marginal_x_values = np.array([marginal_x(xi, rv) for xi in x])  

# Step 6: Plot the corrected marginal distribution of X (Height)
plt.figure(figsize=(8,6))
plt.plot(x, marginal_x_values, color='blue', lw=2, label="Corrected Marginal X (Height)")  
plt.xlabel("Height (feet)")  
plt.ylabel("Density")  
plt.title("Fixed Numerically Computed Marginal Distribution of Height")  
plt.legend()  
plt.show()

#

