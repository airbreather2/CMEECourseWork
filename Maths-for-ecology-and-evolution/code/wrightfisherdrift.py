#########Modules##############

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
    # GIVE NAMES TO THE ELEMENTS (OPTIONAL)
    for (i in 1:(t+1))
    {
        names(population)[i]<-paste(c('generation', i-1), collapse='')
    }
    # ALSO KEEP TRACK ON THE ALLELE FREQ OVER TIME, AS A VECTOR
    allele.freq<-rep(NA, t+1)
    # INITIALISE
    # NUMBER OF "0" ALLELE AT THE START, GOVERNED BY p0
    k<-round(2*N*p0)
    population[[1]]<-matrix(sample(c(rep(0, k), rep(1, 2*N-k))), nr=2)
    # THE INITIAL ALLELE FREQ
    allele.freq[1]<-sum(population[[1]]==0)/(2*N)
    # PROPAGATION
    for (i in 1:t)
    {
        # THE GAMETIC FREQ IS JUST THE ALLELE FREQ FROM THE PARENTAL GEN
        population[[i+1]]<-matrix(sample(0:1, size=2*N, prob=c(allele.freq[i], 1-allele.freq[i]), replace=T), nr=2)
        # UPDATE NEW FREQ
        allele.freq[i+1]<-sum(population[[i+1]]==0)/(2*N)
    }
    # RETURN A BIG LIST, EXIT
    return(list(population=population, allele.freq=allele.freq))
}