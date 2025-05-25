import numpy as np
import matplotlib.pyplot as plt

# Define p (probability of success)
p = 0.7  # Change this to see different distributions

# Bernoulli values (X = 0 or 1)
x_values = [0, 1]
probabilities = [1 - p, p]

# Plot the Bernoulli distribution
plt.bar(x_values, probabilities, color=['blue', 'red'], alpha=0.7)
plt.xticks([0, 1], labels=["X = 0", "X = 1"])
plt.ylabel("Probability")
plt.title("Bernoulli Distribution (p = {:.1f})".format(p))
plt.show()


# Simulate Bernoulli random values
n_samples = 100
samples = np.random.choice([0, 1], size=n_samples, p=[1 - p, p])

# Plot the sampled values
plt.scatter(range(n_samples), samples, alpha=0.5, label="Samples (X)")
plt.axhline(y=p, color='r', linestyle='dashed', label="E(X) = p")

plt.xlabel("Trial Number")
plt.ylabel("X Value")
plt.title("Bernoulli Trials and Expected Value")
plt.legend()
plt.show()

# Compute variance manually
var_x = p * (1 - p)

# Histogram of sampled values
plt.hist(samples, bins=2, alpha=0.6, color='blue', edgecolor='black', density=True)
plt.axvline(x=p, color='r', linestyle='dashed', label="E(X) = p")
plt.axvline(x=p+np.sqrt(var_x), color='g', linestyle='dotted', label="E(X) + sqrt(Var(X))")
plt.axvline(x=p-np.sqrt(var_x), color='g', linestyle='dotted', label="E(X) - sqrt(Var(X))")

plt.xticks([0, 1])
plt.ylabel("Frequency")
plt.title("Distribution of X with Expected Value and Variance")
plt.legend()
plt.show()
