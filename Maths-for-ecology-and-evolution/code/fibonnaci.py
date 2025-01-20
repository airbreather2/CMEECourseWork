import matplotlib.pyplot as plt

# Function to generate Fibonacci sequence
def generate_fibonacci(n):
    fibonacci = [0, 1]
    for i in range(2, n):
        fibonacci.append(fibonacci[-1] + fibonacci[-2])
    return fibonacci

# Number of terms in the Fibonacci sequence
num_terms = 50

# Generate Fibonacci sequence
fibonacci = generate_fibonacci(num_terms)

# Calculate ratios of consecutive terms
ratios = [fibonacci[i + 1] / fibonacci[i] for i in range(1, len(fibonacci) - 1)]

# Generate convergence series for ratios
convergence = []
current_ratio = 1
for ratio in ratios:
    current_ratio = 1 + 1 / current_ratio
    convergence.append(current_ratio)

# Golden Ratio for comparison
golden_ratio = (1 + 5**0.5) / 2

# Plot the results
plt.figure(figsize=(10, 6))
plt.plot(range(len(convergence)), convergence, label="Derived Ratios Convergence", marker="o")
plt.axhline(y=golden_ratio, color="red", linestyle="--", label="Golden Ratio (~1.618)")
plt.title("Convergence of Fibonacci Ratio to the Golden Ratio")
plt.xlabel("Iteration (n)")
plt.ylabel("Convergence Value (Derived from Ratios)")
plt.legend()
plt.grid()
plt.show()
