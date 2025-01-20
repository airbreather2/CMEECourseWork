import numpy as np
import matplotlib.pyplot as plt


# Let's compare discrete and continuous growth numerically.

mu = 0.7      # continuous growth rate per time unit
N0_cont = 1   # initial population
t_end = 10.0  # total time

# We'll solve dN/dt = mu N(t) analytically:
def N_continuous(t, N0, mu):
    return N0 * np.exp(mu * t)

# And for discrete steps, let's pick a time step dt.
dt = 1.0
R_derived = np.exp(mu*dt)

# We'll do 10 steps, each of length dt=1:
num_steps = int(t_end/dt)
N_discrete_model = [N0_cont]
for step in range(num_steps):
    N_next = R_derived * N_discrete_model[-1]
    N_discrete_model.append(N_next)

# Now we'll sample the continuous solution at integer times
time_array = np.linspace(0, t_end, 100)
N_continuous_vals = [N_continuous(t, N0_cont, mu) for t in time_array]

# Plot both
plt.figure(figsize=(6,4))
plt.plot(time_array, N_continuous_vals, 'b-', label='Continuous')
plt.plot(np.arange(num_steps+1), N_discrete_model, 'ro--', label='Discrete (dt=1)')
plt.xlabel('Time')
plt.ylabel('Population Size')
plt.title('Continuous vs. Discrete Growth')
plt.legend()
plt.show()