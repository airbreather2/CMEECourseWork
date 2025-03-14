#########Modules##############



###Version 1:

#Model assumes: 
#Drift is the only Evolutionary Force (No mutation/migration/Selection)
#Random Mating
#Discrete Generations
#COnstant population size
#DIploid
#One biallelic locus ("0" or "1")
# 0 or 1 are both equally likely to be passed on to the next geeneration, without preference thus frequency across population stays proportionally the same across generations


#PARAMETERS: 
#N- Population size
#p- initial frequency of allele "0"
#t - number of generations we want to simulate foward in time

#Output: 
#A vector of  (𝑡+1) allele frequencies over time. 2) A list containing  (𝑡+1) matrices to store all the genotypic configurations across all individuals and time. Each matrix has  𝑁 columns (individuals) and 2 rows (ploidy)

sim_genetic_drift<-function(N=10, t=5, p0=0.5)

{
  # THE BIG LIST OF MATRICES (TO BE FILLED IN LATER)
  population <-list()
  length(population)<-t+1
  # GIVE NAMES TO THE ELEMENTS (Generation 0, generation 2 etc)
  for (i in 1:(t+1))
  {
    names(population)[i]<-paste(c('generation', i-1), collapse='') #i-1 ensures correct stating position and collapse combines itno single string
  }
  # ALSO KEEP TRACK ON THE ALLELE FREQ OVER TIME, AS A VECTOR (Fill with NAS TO BE OVERWRITTEN)
  allele.freq<-rep(NA, t+1)
  # INITIALISE
  # NUMBER OF "0" ALLELE AT THE START, GOVERNED BY p0
  k<-round(2*N*p0)
  population[[1]]<-matrix(sample(c(rep(0, k), rep(1, 2*N-k))), nr=2) # creates 2 row matrix that uses sample() to randomly sample from a vector that contains k copies of allele "0" and 2 * N - k copies of allele "1" to the individuals.
  # THE INITIAL ALLELE FREQ
  allele.freq[1]<-sum(population[[1]]==0)/(2*N) #n times 2 because total number of alleles is twice that of pop (diploid)
  # PROPAGATION (a for loop (length of generations is ran))
  for (i in 1:t)
  {
    # THE GAMETIC FREQ IS JUST THE ALLELE FREQ FROM THE PARENTAL GEN
    population[[i+1]]<-matrix(sample(0:1, size=2*N, prob=c(allele.freq[i], 1-allele.freq[i]), replace=T), nr=2) #adds each gen to population list :randomly samples for next gen, 0:1 are sampled for total size of alleles (N*2), popubabilities are specified for 0 and 1. sampling is replaced to ensure odds stay the same (not removed from pool when sampled) and stored in matrix with 2 rows
    # UPDATE NEW FREQ
    allele.freq[i+1]<-sum(population[[i+1]]==0)/(2*N) #recalculates allele frequency and adds this to a list after each element
  }
  # RETURN A BIG LIST, EXIT
  return(list(population=population, allele.freq=allele.freq))
}

# TEST RUN
sim_genetic_drift()


########Version 2: frequency based

# The binomial distribution is used to model the number of "successes" in a fixed number of trials.
# In this case:
# - Each "trial" represents sampling one allele (either "0" or "1").
# - A "success" is sampling allele "0".
# - The total number of trials is 2*N (diploid population: 2 alleles per individual).
# - The probability of success (sampling "0") is the current allele frequency (p = allele.freq[i]).

# Assumptions of the binomial distribution in this context:
# 1. The population size is fixed (2*N alleles total per generation).
# 2. Each allele is sampled independently of the others.
# 3. The probability of success (allele "0") is constant during the sampling for a single generation.
# 4. Random mating and no selection, mutation, or migration occur.


sim_genetic_drift2<-function(N=10, t=5, p0=0.5)
{
  # A VECTOR FOR ALLELE FREQ
  allele.freq<-rep(NA, t+1)
  # INITIALISE
  allele.freq[1]<-p0
  # PROPAGATION
  # DIVIDE COUNT BY 2*N TO GET FREQ
  for (i in 1:t)
  {
    allele.freq[i+1]<-rbinom(1, size=2*N, prob=allele.freq[i])/(2*N) #generates 1 random number representing the number of successes (e.g., allele "0") in E.G: 20 trials, with each trial having a 50% success probability.
  }
  # RETURN AND EXIT
  return(allele.freq)
}

#####ONLY WORKS BECAUSE ALLELE LIKELIHOOD IS 50% 
#lacks genotypic information which inhibits us from calculating summary statistics such as heterozygosity or Hardy-Weinberg Equilibrium.

sim_genetic_drift2()


##################Drift and population size: ####################################

#The magnitude of drift is inversely proportional to  N,  People have been using drift signals to estimate effective population size, see Waples (1989), Hui, Brenas & Burt (2021).

# SMALL N=50 SCENARIO, WITH 20 REPLICATEAS
af_N50<-matrix(nr=20, nc=51) #20 different populations simulated with each being simulated over 50 generations: initial pop 50
for (i in 1:nrow(af_N50))
{
  af_N50[i,]<-sim_genetic_drift2(N=50, t=50)
}
# LARGE N=500 SCENARIO, WITH 20 REPLICATES
af_N500<-matrix(nr=20, nc=51) #20 different populations simulated with each being simulated over 50 generations: initial pop 500

for (i in 1:nrow(af_N500))
{
  af_N500[i,]<-sim_genetic_drift2(N=500, t=50)
}

par(mfrow=c(1,2))

# PLOTS ALLELE FREQ TRAJECTORIES
matplot(0:50, t(af_N50), type='l', ylim=c(0, 1), 
        xlab='generations', ylab='allele frequency', main='N=50', lwd=2)
matplot(0:50, t(af_N500), type='l', ylim=c(0, 1), 
        xlab='generations', ylab='allele frequency', main='N=500', lwd=2)

#GENETIC DRIFT IS VISIBLY STRONGER IN SMALLER POPULATIONS

################# Monte Carlo methods ####################################

#Variance of Monte Carlo methods

# Classical theory of genetic drift:
# - Drift does not change the mean allele frequency over time.
# - Drift increases the uncertainty (variance) of allele frequency as time (t) increases.
# - This uncertainty is inversely proportional to population size (N) (Waples, 1989).

# Example questions geneticists may ask:
# - What are the mean and variance of allele frequency after t=10 generations, 
#   given p0=0.5 (initial frequency) and N=200 (population size)?

# Approaches to find mean and variance:
# 1. Statistical methods:
#    - Use statistical distributions and moments of allele frequency.
#    - Study the conditional mean and variance of the random variables.
# 2. Diffusion model:
#    - Approximate the Wright-Fisher process using mathematical models.

# Alternative approach: Using the Wright-Fisher simulator.
# - Simulate genetic drift under the given parameters (e.g., p0=0.5, N=200, t=10).
# - Run the simulator many times (e.g., 10,000 independent runs) to generate 
#   final allele frequencies.
# - Compute the empirical mean and variance of these 10,000 simulated final frequencies:
#    - Sample average = Empirical mean. (the mean of the final allele frequency across the 10000 generations)
#    - Sample variance = Empirical variance (found by summing the value of each final frequency minus emperical mean, squared) divided by population size.


# MEAN, VARIANCE, AND DISTRIBUTION OF ALLELE FREQ DUE TO DRIFT
# p0=0.5, N=200, t=10
# 10000 INDEPENDENT SIMS (OR LOCI), NOTE THAT WE'RE ONLY INTERESTED IN THE FINAL ALLELE FREQ

final_af<-rep(NA, 10000) #initialise a numeric vector with length 10000 and populate with Nas
for (i in 1:length(final_af)) #for length of vector (10000 times) run binomial dist function and save result to vector
{
  final_af[i]<-sim_genetic_drift2(N=200, p0=0.5, t=10)[11]
}
# OUR APPROXIMATIONS 
mean(final_af)
var(final_af)
hist(final_af, xlab='allele freq', main='Histogram of 10000 final allele freq, given the initial conditions. ')

# Waples (1989) found the equation: Variance of allele frequency after t generations
# Var[p_t] = p0 * (1 - p0) * (1 - (1 - 1/(2*N))^t)
# For our parameters, this equals ~0.0061.

# Our Monte Carlo (MC) approximation is close to the theoretical variance.

# The histogram confirms E[p_t] ≈ p0 (neutral drift). as likelihood of p was 50 percent
# However, due to chance, allele frequency can drift to extremes (e.g., 0.8 or 0.2).

# Repeated simulations to estimate mean/variance is called the Monte Carlo method.



########################### Variance of MC Estimates #############################

# Monte Carlo (MC) method:
# Repeated simulations are used to estimate quantities like variance (Var[p_t]).
# To get accurate estimates, a large number of independent simulations are needed.

# This code examines how the uncertainty in variance estimates decreases
# as the number of independent loci (simulations) increases (e.g., 50, 100, 200, etc.).

# The uncertainty decreases as the number of loci increases,
# following the relationship: uncertainty ∝ 1/sqrt(number of simulations).

# Parallel computing with the doParallel package is used to speed up simulations
# by running them across multiple CPU cores.

require(doParallel)    # Load the package for parallel computing
cl <- makeCluster(4)   # Create a cluster using 4 CPU threads
registerDoParallel(cl) # Register the cluster for parallel use

num_indep_loci <- c(50, 100, 200, 500, 1000, 2000)
# vector specifies number of independent loci (simulations to test), for each we will calculate uncertainty in the variance estimate


result <- foreach(i = 1:6, .combine = cbind) %dopar% { #loops over the indices 1 to 6 with each index corresponding to a different value of num_indep_loci. combining results of each iteration of the loop into a single matrix, with each output forming a column. Dopar executes the loop in paralell across cores
  temp_result <- rep(NA, 1000) # Store 1000 variance estimates for current setting of numindependentloci
  for (j in 1:length(temp_result)) { #loops 1000 times (one for each row in temp_result
    temp <- rep(NA, num_indep_loci[i]) # stores a temporary vector for storing final allele frequencies (generation 10) for num independent loci
    for (k in 1:num_indep_loci[i]) { #simulate each loci and store final frequency
      temp[k] <- sim_genetic_drift2(p0 = 0.5, N = 200, t = 10)[11] #save results into temp
    }
    temp_result[j] <- var(temp) # Compute variance of final allele frequencies
  }
  return(temp_result)
}

# Output Explanation:
# - The result is a matrix where each column corresponds to a specific value of num_indep_loci 
#   (e.g., 50, 100, 200, 500, 1000, 2000 loci).
# - Each row in the matrix represents one of 1000 Monte Carlo simulations.

# For each value of num_indep_loci:
# - The Monte Carlo simulation generates final allele frequencies for all loci.
# - The variance of these final allele frequencies is computed for each simulation.
# - This process is repeated 1000 times, resulting in 1000 variance estimates.

# Matrix Dimensions:
# - The number of rows is 1000 (one for each Monte Carlo simulation).
# - The number of columns is 6 (one for each value in num_indep_loci: 50, 100, 200, 500, 1000, 2000).

# Use of the Output:
# - Each column allows us to examine the variability (uncertainty) of the variance estimates
#   for a specific number of loci.
# - By comparing across columns, we can observe how increasing the number of loci reduces
#   the uncertainty in variance estimates.

# Key Observations:
# - For smaller num_indep_loci (e.g., 50), variance estimates will show higher variability 
#   across the 1000 simulations due to limited loci.
# - For larger num_indep_loci (e.g., 2000), variance estimates will have less variability, 
#   indicating more accurate and stable estimates.

par(mfrow=c(1,2))

# PLOT THE UNCERTAINTY AROUND THESE VARIANCE ESTIMATES (i.e. SAMPLE VARIANCE OF 1000 REPEATED VARIANCE ESTIMTAES)
plot(num_indep_loci, apply(result, 2, var), #num of loci on x axis, y axis plots: apply function is used to find the variance (var) of every column (2) in the result matrix
     xlab='number of loci used to produce one variance estimate', 
     ylab='variance (or uncertainty) around the estimate')

# OR PLOT THE RECIPROCAL OF THE UNCERTAINTY?
plot(num_indep_loci, 1/apply(result, 2, var), 
     xlab='number of loci used to produce one variance estimate', 
     ylab='1/variance (or uncertainty) around the estimate')
abline(lm(1/apply(result, 2, var)~num_indep_loci), lty=2)

#########################Persistence time of an allele ##############################

#drift will ultimately drive an allele to fixation/extinction. Of which the time to either is a random variable, depending on p and N. 
#We can use montecarlo to approximate a time to fixation/extinction by tweaking our simulator by: 
#1- asking it to run until fixed/extinct (and that t is no longer an input argument)
#2- return number of generations elapsed before fixation/extinction
#this can be achieved with a while loop

# MODIFY sim_genetic_drift2() TO RUN UNTIL THE LOCUS IS FIXED
sim_genetic_drift3<-function(N=10, p0=0.5)
{
  # WE CAN USE UPDATE AND REUSE THE SAME VARIABLE p
  p<-p0
  # KEEP TRACK OF t
  t<-0
  # PROPAGATION. WHILE IT REMAINS POLYMORPHIC
  while (p>0 & p<1) #while both alleles exist
  {
    p<-rbinom(1, size=2*N, prob=p)/(2*N) #randomly select an allele out of 0 or 1 for all alleles in population based on probability that is updated after each generation 
    t<-t+1
  }
  # RETURN t AND EXIT
  return(t)
}
sim_genetic_drift3()

# MEAN PERSISTENCE TIME, AND ITS DISTRIBUTION
# p0=0.02, N=200
# DON'T TRY WITH LARGE N
persistence_time<-rep(NA, 10000)
for (i in 1:length(persistence_time))
{
  persistence_time[i]<-sim_genetic_drift3(p0=0.02, N=200)
}
mean(persistence_time)
var(persistence_time)
hist(persistence_time)


# From our Monte Carlo simulation, the mean persistence time is approximately 79 generations.
# However, the variance is very large (~37203), indicating high variability in persistence times.

# The distribution is heavily skewed with a long tail.
# This means that while most simulations result in short persistence times, 
# a small number of simulations produce extremely large persistence times, which inflate the variance.

# Why is the variance so large?
# - Persistence time measures how long an allele with initial frequency p0 = 0.02 persists before fixation or loss.
# - At very low initial frequencies (like p0 = 0.02), alleles are more likely to be quickly lost due to genetic drift.
# - However, in rare cases, the allele survives and drifts toward fixation, which can take a very long time.
# - This rare but extreme outcome creates a long tail in the distribution, leading to a massive variance.

# Comparison with theoretical results:
# You can compare the mean persistence time (from MC simulation) with the approximation by Kimura and Ohta (1969):
# Mean persistence time (approximation) ≈ -4 * N * [p0 * log(p0) + (1 - p0) * log(1 - p0)]
# This formula provides a diffusion approximation for persistence time under genetic drift.


#######################BONUS: USEFUL APPLICATIONS OF SAMPLE #######################################

#SHUFFLING
sample(1:10)
sample(letters)
#if input is vector, the output returned will be essentially a shuffled version of same length e.g: 
#10692451378
#'l''c''j''q''z''g''r''s''y''n''v''w''a''i''t''k''m''e''f''u''b''x''d''h''o''p'


#Sampling without replacement (size has to be smaller to or equal to vector)
sample(1:10, size = 4)
sample(letters, size = 5)
sample(1:10, size = 11) #ERROR
#EXAMPLE OUTPUT: 
#5428 
#C Y H N K


#SAMPLING WITH REPLACEMENT (NOW YOU CAN SAMPLE AS MANY AS YOU WANT AS VALUES ARE AUTOMATICALLY REPLACED)
sample(1:10, size=20, replace=T) # IT IS NOW OK TO SAMPLE 20 ITEMS FROM A VECTOR OF LENGTH 10 WITH REPLACEMENT
sample(letters, size=11, replace=T)
sample(1:10, replace=T) # OK BUT CONFUSING

#SAMPLING WITH SET PROBABILITIES:
sample(1:10, size=20, prob=c(0.4, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0, 0, 0), replace=T) # LOADS OF 1, BUT NO 8, 9, 10
