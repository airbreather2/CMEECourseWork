import numpy as np
import matplotlib.pyplot as plt

def plot_trig_functions(A=1, omega=1, phi=0, number=0):
    """
    Plot sine, cosine, and tangent functions with adjustable transformations.

    Parameters:
        A (float): Amplitude - Scales the height of the wave (default is 1).
        omega (float): Angular frequency - Changes how many cycles occur in a given interval (default is 1).
        phi (float): Phase shift - Shifts the wave left or right (default is 0).

    How to use:
        - Adjust A to change the amplitude (e.g., try 2 or 0.5).
        - Adjust omega to compress or stretch the graph horizontally (e.g., try 2 for double frequency).
        - Adjust phi to shift the graph horizontally (e.g., try np.pi/4 for a phase shift).
        - Adjust number to move graph up or down
    Example:
        plot_trig_functions(A=2, omega=1, phi=np.pi/4)
    """
    # Generate x values (from -2π to 2π)
    x = np.linspace(-2 * np.pi, 2 * np.pi, 1000)

    # Apply transformations to sine, cosine, and tangent
    sin_y = A * np.sin(omega * x + phi) + number# Transformed sine function
    cos_y = A * np.cos(omega * x + phi) + number # Transformed cosine function
    tan_y = A * np.tan(omega * x + phi) + number# Transformed tangent function

    # Mask tangent function to avoid infinities (for better visualization)
    tan_y[np.abs(tan_y) > 10] = np.nan

    # Plot the functions
    plt.figure(figsize=(12, 6))
    plt.plot(x, sin_y, label=r"$A \sin(\omega x + \phi)$", linestyle="--", color="blue")
    plt.plot(x, cos_y, label=r"$A \cos(\omega x + \phi)$", linestyle="-", color="orange")
    plt.plot(x, tan_y, label=r"$A \tan(\omega x + \phi)$", linestyle=":", color="green")

    # Add labels, legend, and grid
    plt.axhline(0, color="black", linewidth=0.5, linestyle="--")
    plt.axvline(0, color="black", linewidth=0.5, linestyle="--")
    plt.yticks(np.arange(-10,11,1)) #add TICKS IN Y AXIS 
    plt.ylim(-10, 10)  # Limit y-axis for better visualization
    plt.title(f"Trig Functions with A={A}, \u03c9={omega}, \u03c6={phi} (radians)", fontsize=14)
    plt.xlabel("x (radians)", fontsize=12)
    plt.ylabel("f(x)", fontsize=12)
    plt.grid(alpha=0.3)
    plt.legend()
    plt.show()

# Example: Default plot
plot_trig_functions(A=1, omega=1, phi=1, number=0)
