import numpy as np
import matplotlib.pyplot as plt
import math


def growth_func(x, L, k): 
    '''This function models the growth of the Bertalanffy function which describes indeterminate growth of fish:
    
    x must be > 0
    
    L - is length
    
    x - is age
    
    k - is a growth constant'''
    return L * (1 - np.exp(-k * x))

def find_point (condition, K):
    '''finds point where: the x value equals desired percent of L by returning relevant x value
     condition - the percent where you match age to length (found by converting to decimal and minusing it from 1)
      
     k - growth constant
    '''
    return -math.log(condition)/ K
    



def plot_Bertalanffy():
    # Generate x values
    x = np.linspace(0, 50, num=500)  # Focus on x values between 0 and 50 for clarity

    # Plot the function growth_func
    plt.figure(figsize=(12, 6))
    plt.plot(x, growth_func(x, 20, 1), linestyle="--", color="blue", label="L=20, k=1")
    plt.plot(x, growth_func(x, 20, 0.1), linestyle="--", color="green", label="L=20, k=0.1")
    
    #plot the points for find_point THIS IS SO FUCKING CLAPPED. X IS THE POINT WHERE DESIRED PERCENT REACHED AND Y IS THE EQUIVALENT VALUE BASED ON X 
    plt.scatter(find_point(0.1, 1), growth_func(find_point(0.1, 1), 20, 1), color="red")
    plt.scatter(find_point(0.01, 1), growth_func(find_point(0.01, 1), 20, 0.1), color="red")



    # Add labels, legend, and grid
    plt.axhline(0, color="black", linewidth=0.5, linestyle="--")
    plt.axvline(0, color="black", linewidth=0.5, linestyle="--")
    plt.yticks(np.arange(0, 25, 5))  # Proper y-ticks
    plt.ylim(0, 25)  # Set appropriate y-axis limits
    plt.xlabel("Age")
    plt.ylabel("Length")
    plt.title("Von Bertalanffy Fish Growth Function")
    plt.legend()
    plt.grid(alpha=0.3)
    plt.show()

plot_Bertalanffy()
