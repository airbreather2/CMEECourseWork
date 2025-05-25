import numpy as np #numeric lib
import scipy.stats as ss #contats different stats functions
import matplotlib.pyplot as plt #standard plotting library 

# Part 1: Warming Up - Conditional Probabilities in a Genetics Context
# We consider a classic Mendelian genetics example with dominant (Y) and recessive (y) alleles.

# Assumptions:
# - Y (yellow) is dominant, y (green) is recessive.
# - Peas are diploid, meaning they have two alleles per gene.
# - Genotypes can be:
#   - Homozygous dominant (YY) -> Yellow
#   - Homozygous recessive (yy) -> Green
#   - Heterozygous (Yy or yY) -> Yellow
# - Equal probability for each genotype:
#   - P(homozygote) = 1/2
#   - P(heterozygote) = 1/2

#Question 1.1 What is the probability of observing a yellow pea  𝑃(yellow)
 
#1*2 * 1*2 = 1/4


#Question 1.2 What is the probability that a yellow pea is heterozygote  𝑃(heteroz.|yellow)
 
#2/3

#Question 1.3 What is the probability that a pea is yellow and heterozygote  𝑃(heteroz.,yellow)

#1/2

#Question 1.4 Use the Bayes' theorem to calculate the probability that a pea is yellow knowing that it is heterozygote  𝑃(yellow|heteroz.)
 


######################Manipulating probabilities with python ##########################################

#someone picks 10 peas at random, what is prob of 5 yellow peas exactly

#Mehtod one, brute force it by sampling 
# When a distribution's closed-form is unknown, we can approximate it empirically by sampling.
# Here, we simulate an experiment where 10 peas are randomly assigned colors based on their probabilities.
# The function below generates one such experiment.

## All these three functions do the same and are interchangable,
# they reproduce the experiment of selecting 10 peas at random
# have a look at them and make sure you understand the python syntax used in each of them

def peas_experiment():
    results = [] #initialise vector to store values for peas
    #1 if yellow 
    #0 if green
    for i in range(10):
        if np.random.rand()<3/4: #np.random.rand(generates a uniform random number in range 0,1)
            results.append(1)
        else:
            results.append(0)
    return results

def peas_experiment_pythonic():
    #non pythonic, avoids loops
    #cleaner
    return[int(x<3/4) for x in np.random.rand(10)]

def peas_experiment_scipy():
    #use scipy.stats funcs that contain implemented prob distributions
    #use bernoulli experiment 10 times
    #is a probability of binary results at a fixed probability . i.e a weighted coin that lands heads 70%of time
    return ss.bernoulli.rvs(p = 3/4, size = 10)


## Test of the functions above. As an example we are calling peas_experiment() 

print("Here are three independent realizations of the experiment:")
for N in range(3):
    print(peas_experiment_pythonic())

#Here you should write the code that returns the answer. 




N = 0
    for j in in range(1000):
        exper = peas_experiment()
        if sum(exper) ==5:
            N = N + 1
    return N
    
    
N = 0
    for j in in range(1000):
        exper = peas_experiment_pythonic()
        if sum(exper) ==5:
            N = N +1
    return N
    

= 0
    for j in in range(1000):
        exper = peas_experimeny_scipy()
        if sum(exper) ==5:
            N = N +1
    return N 