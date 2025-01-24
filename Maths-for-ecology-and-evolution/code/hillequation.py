import matplotlib.pyplot as plt
import numpy as np

def hill_function(x, n, b): 
    '''Hill equation function.'''
    return (x**n) / (b**n + x**n)

def plot_hillfunctions():
    # Generate x values
    x = np.linspace(0.1, 10, num=1000)  # Focus on x values between 0.1 and 10

    # Plot the functions
    plt.figure(figsize=(12, 6))
    plt.plot(x, hill_function(x, 1, 2), linestyle="--", color="blue", label="n=1, b=2")
    plt.plot(x, hill_function(x, 2, 2), linestyle="-", color="orange", label="n=2, b=2")
    plt.plot(x, hill_function(x, 3, 2), linestyle=":", color="green", label="n=3, b=4")

    # Add labels, legend, and grid
    plt.axhline(0, color="black", linewidth=0.5, linestyle="--")
    plt.axvline(0, color="black", linewidth=0.5, linestyle="--")
    plt.yticks(np.arange(0, 1.1, 0.1))  # Proper y-ticks
    plt.ylim(0, 1.1)  # Set appropriate y-axis limits
    plt.xlabel("x (Concentration)")
    plt.ylabel("f(x) (Fractional Saturation)")
    plt.title("Hill Function")
    plt.legend()
    plt.grid(alpha=0.3)
    plt.show()

plot_hillfunctions()
