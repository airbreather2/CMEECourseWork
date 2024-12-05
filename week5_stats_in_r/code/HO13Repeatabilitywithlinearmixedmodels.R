#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

########Linear Mixed Models ############
# Work much better with unbalanced dataset
#easier way to calculate repeatibility

a<-read.table("../data/Wylde_single.mounted.txt", header=T)
head(a)
library(lme4)

#repeatability of femur length
lmm1<-lmer(Femur_length~1+(1|ID), data=a)
# ~1 specifies we are modelling intercept-only fixed effect 
#(1|ID) specifies a random intercept for each ID: (1 | ID) means that each level of ID (e.g., each individual or subject) has its own intercept, allowing for individual variation around the overall mean. 

summary(lmm1)
