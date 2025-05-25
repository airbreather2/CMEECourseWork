import numpy as np

# Define weather categories
weather = ["Hot", "Cloudy", "Rainy"]
prob_x = np.array([0.4, 0.4, 0.2])  # Probabilities of each weather type
expected_sales_given_x = np.array([100, 50, 10])  # Cups sold for each weather type

# Compute total expectation
overall_expected_sales = np.sum(expected_sales_given_x * prob_x)

# Print results
print(f"Expected Sales per Weather: {dict(zip(weather, expected_sales_given_x))}")
print(f"Weather Probabilities: {dict(zip(weather, prob_x))}")
print(f"Overall Expected Sales: {overall_expected_sales}")
