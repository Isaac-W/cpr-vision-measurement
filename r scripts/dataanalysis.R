setwd('C:\\Working\\GitHub\\vision-measurement\\data')
data <- read.csv('all_data.csv')

library(doBy)

######################### CORRECTNESS
#Overall correctness
summaryBy(Correct~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(Correct ~ Group, data=data)

#Correctness by trial
summaryBy(Correct~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

g1 <- subset(data, Group == "1")
g2 <- subset(data, Group == "2")
g3 <- subset(data, Group == "3")

boxplot(Correct ~ Trial, data=g1)
boxplot(Correct ~ Trial, data=g2)
boxplot(Correct ~ Trial, data=g3)

#Anova for correctness by trial and group
fit = aov(Correct~as.factor(Group)*as.factor(Trial),data=data)
summary(fit)
TukeyHSD(fit)
#note here that there is no difference by trial

#Anova for correctness by group
fit = aov(Correct~as.factor(Group),data=data)
summary(fit)
TukeyHSD(fit)
#note here that there is no difference between groups 2 and 3

######################### CORRECTNESS

