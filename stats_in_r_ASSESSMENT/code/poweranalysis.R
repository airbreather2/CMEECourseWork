#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

set.seed(1234)

library(pwr)

#import data
budburst <-read.csv("../data/girthandbudburst.csv")
stratifiedbudburst <-read.csv("../data/stratifiedgirthdata.csv")

#predictors: Location, Period, Girth
#create linear model
model1 <- lm(JulianDay ~ Girth_cm + Period + Location, data = budburst)


model2 <- lm(JulianDay ~ Girth_cm + Period, data = stratifiedbudburst)

#create general linear model
glm_model <- glm(JulianDay ~ Girth_cm + factor(Period), 
                 data = stratifiedbudburst,
                 family = poisson(link = "log"))


summary(model1)
summary(model2)
summary(glm_model)


f21 <- 0.0606 / (1 - 0.0606)
f22 <- 0.05241 / (1 - 0.05241)

#generate power result
power_result <- pwr.f2.test(u = 3, v = 2405 - 3 - 1, f2 = f22, sig.level = 0.05)
print(power_result)
