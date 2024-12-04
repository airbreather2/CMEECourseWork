#one dimensional like vectors but can contain mixed data types

MyList <- list(1L, "p", FALSE, .001) # an integer, a character, a boolean, and a numeric walk into a bar...
MyListMyList <- list(1L, "p", FALSE, .001) # an integer, a character, a boolean, and a numeric walk into a bar...
MyList

MyList <- list(species=c("Quercus robur","Fraxinus excelsior"), age=c(123, 84))
MyList

#access contents like this 
MyList[[1]]
#'Quercus robur''Fraxinus excelsior'

MyList[[1]][1]
#'Quercus robur'

MyList$species
#'Quercus robur''Fraxinus excelsior'

MyList[["species"]]
#same output

MyList$species[1]
#'Quercus robur'


pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

#you can build off of lists

pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops

#you can access these lists in fancy way 
#pops[[2]]$lat #latitude of second species
#56

