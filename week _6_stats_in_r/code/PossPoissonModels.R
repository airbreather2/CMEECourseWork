require(ggplot2)
require(MASS)
require(ggpubr)
fish<- read.csv("../data/fisheries.csv", stringsAsFactors = T)

str(fish)

#Our basic model consists of total abundance as our response variable and mean depth as our explanatory variable. 
ggplot(fish, aes(x=MeanDepth, y=TotAbund))+ geom_point()+ labs(x= "Mean Depth (km)", y="Total Abundance")+
theme_classic()

M1<- glm(TotAbund~MeanDepth, data = fish, family = "poisson")
summary(M1)
#The summary output is very similar to that we are used to for a regular linear model . We have estimated values for the intercept and slope parameters, standard errors, a z-value (synonymous with the t-value in the t-test) and a p-value.

#two steps in the model validation process
#checking diagnostics
#finding and examining dispersion parameters
par(mfrow=c(2,2)) #partitioning the plot window into a 2X2
plot(M1)

#we have many of outliers, lets explore these
sum(cooks.distance(M1)>1)
#29
#Cook's Distance quantifies the influence of each data point on the overall regression results. It combines the information from both the leverage of a point (how far an observation is from the mean of the predictor variables) and its residual (the difference between the observed and predicted value
#we have 29 outliers

scatterplot<-ggplot(fish, aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  geom_point()+
  labs(x= "Mean Depth (km)", y="Total Abundance")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))
boxplot<- ggplot(fish, aes(x=factor(Period, labels=c("1979-1989", "1997-2002")), y=TotAbund))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Period", y="Total Abundance")
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

