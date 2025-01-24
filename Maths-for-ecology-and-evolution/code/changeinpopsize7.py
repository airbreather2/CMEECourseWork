import matplotlib.pyplot as plt # Loads the Matplotlib plotting interface.
from sympy import * #Imports all features of SymPy for symbolic math.
import scipy as sc # Imports SciPy for numerical and scientific computations.
import numpy as np

def changeinpop(N,r,t):
    '''change in population
    
    '''
    return N * np.e**(r*t)

def plot_functions():
    # Generate x values
    x = np.linspace(0.1, 5, num=1000)  # Focus on x values between 0.1 and 10

    # Plot the functions
    plt.figure(figsize=(12, 6))
    plt.plot(x, changeinpop (100, 2, x), linestyle="--", color="blue", label="n=1, b=2")
    plt.plot(x, changeinpop (100, 3, x), linestyle="-", color="orange", label="n=2, b=2")
    
    # Add labels, legend, and grid
    plt.axhline(0, color="black", linewidth=0.5, linestyle="--")
    plt.axvline(0, color="black", linewidth=0.5, linestyle="--")
    #plt.ylim(0, 1000)  # Set appropriate y-axis limits
    plt.xlabel("time")
    plt.ylabel("population")
    plt.title("Moss pop eq")
    plt.legend()
    plt.grid(alpha=0.3)
    plt.show()

plot_functions()

