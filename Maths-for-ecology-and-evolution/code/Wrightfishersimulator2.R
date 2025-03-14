##############################crafting a gene drive simulator #############################

####Features of a basic gene drive simulator

######Drift
#-We assume random sampling of gametes (sample is useful but N will change over time)

######Drive
# Two alleles: "0" (wildtype/WT) and "1" (transgene/TG)
# Initially all mosquitoes are "00" homozygotes

# Super-Mendelian inheritance from heterozygote parents:
# - Gamete "0" produced with probability (1-d)  
# - Gamete "1" produced with probability d
# where d > 0.5 is transmission rate

# Super-Mendelian inheritance means transgene is passed on more frequently 
# than 50/50 Mendelian ratio, enabling spread even at low initial frequencies

# Note: d = 0.5 represents normal Mendelian inheritance (50/50 transmission)

#####Fitness
#in our model the fitness of homozygotics for the gene is 0 meaning adults will not survive, however there is no impact on fitness for heterozygotes

# Fitness effects:
# - "11" (TG homozygotes): fitness = 0 (lethal, no adults survive)
# - "00" (WT homozygotes): fitness = 1 (baseline fitness)
# - "01"/"10" (heterozygotes): fitness = 1 (h = 0, no fitness cost)

# TG frequency can increase without reducing population 
# unless fitness costs are present

###############Selection
#as our model would otherwise decrease as 11 homozygotes are lethal. We introduce the beverton holt model to model the lack of intra-specific competition during low densities
# Beverton-Holt Population Model:
# N(t+1) = (R0 * N(t)) / (1 + N(t)/M)

# Where:
# - N(t+1) is population size at next timestep
# - N(t) is current population size
# - R0 is natural growth rate
# - M is carrying capacity parameter: (R0-1)M = carrying capacity
# - At low density (N<<M): population grows exponentially
# - At high density (N>>M): population approaches carrying capacity

# Purpose: Prevents unrealistic continuous population decline
# by modeling density-dependent growth and resource limitation


################### The following equations describe the gametic frequencies considering drive and selection effects.

# Let x00, x01, x11 be the number of individuals with the following genotypes at the parental generation:
# - x00: Individuals with genotype "00"
# - x01: Individuals with genotype "01"
# - x11: Individuals with genotype "11" (do not contribute to gametic pool)
# - d: Drive parameter, which represents the probability that heterozygotes pass on the "1" allele.

# Gamete production rules:
# - Homozygous "00" individuals produce only "0" gametes (probability = 1).
# - Heterozygous "01" individuals produce "0" gametes with probability (1 - d) and "1" gametes with probability d.
# - Homozygous "11" individuals do not contribute to the gametic pool.

# The total number of contributing individuals is (x00 + x01).

# Wild-type (WT) gametic frequency: 
# This represents the proportion of "0" gametes in the gametic pool.
# WT_gametic_freq = (x00 * 1 + x01 * (1 - d)) / (x00 + x01)

# Transgenic (TG) gametic frequency: 
# This represents the proportion of "1" gametes in the gametic pool.
# TG_gametic_freq = (x01 * d) / (x00 + x01)

# These equations help model the inheritance pattern under the effects of drive and selection.


# 2.1 Input arguments:
# - q0: Initial transgenic (TG) frequency (releasing frequency).
# - t: Number of generations.
# - d: Transmission rate of the TG allele.
# - N0: Initial population size (not constant over time).
# - M, R0: Extra parameters for the Beverton-Holt (BH) model used for population size regulation.

# 2.2 Data types:
# - The data structures and storage methods will be similar to those used in a genetic drift model.
# - Since population size changes over time, we must track TG frequency more efficiently.

# 2.3 Initialisation:
# - Initially, some heterozygous mosquitoes are introduced into a population consisting only of WT (wild-type) homozygotes.

# 2.4 Propagation:
# - Questions to consider for simulation propagation:
#   - How do we update population size?
#   - How do we compute new gametic frequencies?
#   - Should we use sample() for randomization?
#   - How do we calculate and record genotypic frequencies?

# 2.5 Outputs:
# - ??? (To be determined)

# 2.6 Other stopping criteria:
# - Are there conditions that will cause the simulation to stop early?
#   - Possible conditions include population collapse or TG allele extinction.

# 3. The Gene Drive Simulator:

# Considerations when implementing the simulation:

# 1. At the start:
#    - Ensure q0 is between 0 and 0.5.
#    - Ensure d is between 0.5 and 1.
#    - If these conditions are violated, the function will stop() and exit with an error message.

# 2. Two inner functions are defined within the drive simulator:
#    - bh(): Computes the new population size using the Beverton-Holt model.
#    - count_genotype(): Counts and returns the number of "00", "01", and "11" genotypes.
#    - These functions are only accessible within the main function unless explicitly extracted.

# 3. Since we release heterozygous mosquitoes, their initial count should be:
#    - 2 * N0 * q0 (rounded up using ceil()).
#    - The remaining mosquitoes are all WT homozygotes ("00").

# 4. Inside the simulation loop:
#    - First, calculate the new population size using bh().
#    - Only individuals with "00" and "01" genotypes are included.
#    - "11" individuals are assumed dead (they do not consume resources).

# 5. Early exit conditions:
#    - The simulation stops if the population size drops to <= 1.
#    - The simulation also stops if no TG alleles remain.


#######Simulator: 

sim_gene_drive<-function(q0=0.05, d=0.6, t=10, N0=500, R0=2, M=500)
{
  # SOME CHECKS ON THE INPUT PARAMETERS (OPTIONAL)
  if (q0<=0 || q0>0.5)
  {stop('PLEASE MAKE SURE THAT 0<q0<0.5!')}
  if (d<=0.5 || d>=1)
  {stop('PLEASE MAKE SURE THAT 0.5<d<1!')}
  # INNER FUNCTIONS. THESE INNER FUNCTIONS ARE ONLY VISIBLE WITHIN sim_gene_drive()
  # 1) THE BEVERTON-HOLT MODEL. ceiling() TO ROUND UP. RETURN NEW POPULATION SIZE. 
  bh<-function(N, R0, M)
  {return(ceiling(R0*N/(1+N/M)))}
  # 2) RETURN THE COUNTS FOR 00, 01, 11 GENOTYPES
  count_genotype <- function(x) {
    # Sum the values in each column of x (each mosquito's two alleles)
    temp <- apply(x, 2, sum)  
    
    # Count the number of mosquitoes with each genotype:
    # - sum(temp == 0): Count of individuals with genotype 00 (wild type)
    # - sum(temp == 1): Count of individuals with genotype 01 (heterozygous)
    # - sum(temp == 2): Count of individuals with genotype 11 (homozygous transgenic)
    return(c(sum(temp == 0), sum(temp == 1), sum(temp == 2)))
  }
  # INITIALISE
  # CREATE A LIST TO STORE ALL THE ALLEIC CONFIGURATIONS
  population<-list()
  length(population)<-(t+1)
  for (i in 1:(t+1))
  {names(population)[i]<-paste(c('generation', i-1), collapse='')}
  # ALSO CREATE TWO VECTORS TO STORE THE POPULATION SIZES AND THE FREQ OF TG OVER TIME
  population.size<-rep(NA, t+1)
  TG.freq<-rep(NA, t+1)
  
  # INITIAL POPULATION SIZE AND TG FREQ
  population.size[1]<-N0
  TG.freq[1]<-q0
  
  # WE WILL RELEASE k TRANSGENIC MOSQUITOES, WHO CARRY 01 HETEROZYGOTE
  # WHICH MEANS AT GEN 0 THERE ARE (N0-k) WT MOSQUITOES WITH 00 HOMOZYGOTES
  # Compute the number of heterozygous TG mosquitoes to introduce
  k <- ceiling(2 * N0 * q0)
  
  # Create initial population: mix of wild type (00) and heterozygous (01) mosquitoes
  population[[1]] <- cbind(
    matrix(c(0,0), nr=2, nc=N0-k),  # Wild-type mosquitoes (00) (col represents mosquitoes and rows which allele)
    matrix(c(0,1), nr=2, nc=k)      # Heterozygous mosquitoes (01)
  )
  
  # Count the initial number of each genotype (00, 01, 11)
  genotype <- count_genotype(population[[1]])
  
  # PROPAGATION
  for (i in 1:t)
  {
    # CALCULATE THE NEW POPULATION SIZE. ONLY genotype[1]+genotype[2] WILL SURVIVE TILL ADULTHOOD 
    population.size[i+1]<-bh(genotype[1]+genotype[2], R0, M)	
    # EARLY EXIT CONDITION 1, IF POPULATION SIZE DROP TO 1
    if (population.size[i+1]<=1)
    {
      print(paste(c('Oops! The population crashed after generation ', i-1), collapse=''))
      return(list(population=population[1:i], population.size=population.size[1:i], 
                  TG.freq=TG.freq[1:i]))
    }
    # EARLY EXIT CONDITION 2, IF THERE IS NO MORE TG ALLELE
    if (genotype[2]+genotype[3]==0)
    {
      print(paste(c('Oops! TG allele went extinct at generation ', i-1), collapse=''))
      return(list(population=population[1:i], population.size=population.size[1:i], 
                  TG.freq=TG.freq[1:i]))
    }
    # CALCULATE TG GAMETIC FREQ
    TG.gametic.freq<-d*genotype[2]/(genotype[1]+genotype[2])
    # SAMPLE THE NEXT GENERATION
    population[[i+1]]<-matrix(sample(0:1, size=2*population.size[i+1], 
                                     prob=c(1-TG.gametic.freq, TG.gametic.freq), replace=T), nr=2)
    # CALCULATE NEW GENOTYPE COUNTS AND TG FREQ
    genotype<-count_genotype(population[[i+1]])
    TG.freq[i+1]<-(0.5*genotype[2]+genotype[3])/population.size[i+1]	
  }
  # OUTPUTS. RETURN A BIG LIST OF EVERYTHING
  return(list(population=population, population.size=population.size, TG.freq=TG.freq)) 
}

sim_gene_drive(q0=0.05, d=0.6, t=4)
