sim_genetic_drift<-function(N=10, t=5, p0=0.5)
{
    # THE BIG LIST OF MATRICES (TO BE FILLED IN LATER)
    population<-list()
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

# TEST RUN
sim_genetic_drift()