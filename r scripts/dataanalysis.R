#setwd('C:\\Working\\GitHub\\vision-measurement\\data') #Isaac's laptop
setwd('D:\\Documents\\Courses\\UF Research Methods\\cpr-vision-measurement\\data') #Sarah's work computer

#data <- read.csv('all_data.csv')
data <- read.csv('comprehensive_data.csv')
databackup <- data

##Lets look at proportion
#data["NBD_Prop"] <- NA
#data$NBD_Prop <- data$NumBadDepth/data$Total

g1 <- subset(data, Group == "1")
g2 <- subset(data, Group == "2")
g3 <- subset(data, Group == "3")

#t1 <- subset(data, Trial == "1")
#t2 <- subset(data, Trial == "2")
#t3 <- subset(data, Trial == "3")

library(doBy)

#Outlier removal script
remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

######################### CORRECTNESS
##Remove outliers by group
g1["Correct_Clean"] <- NA
g1$Correct_Clean <- remove_outliers(g1$Correct)
summaryBy(Correct_Clean ~ Group, data=g1, FUN = function(x) { c(m = mean(x), s = sd(x))})

g2["Correct_Clean"] <- NA
g2$Correct_Clean <- remove_outliers(g2$Correct)
summaryBy(Correct_Clean~Group, data=g2, FUN = function(x) { c(m = mean(x), s = sd(x))})

g3["Correct_Clean"] <- NA
g3$Correct_Clean <- remove_outliers(g3$Correct)
summaryBy(Correct_Clean~Group, data=g3, FUN = function(x) { c(m = mean(x), s = sd(x))})

#Put the three subsets backtogether
databackup <- data #back your stuff up
groupdata <- rbind(g1, g2, g3)

#Check out the differences in overall correctness
summaryBy(Correct~Group, data=groupdata, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(Correct~Group, data=groupdata) #boxplot

summaryBy(Correct_Clean~Group, data=na.omit(groupdata), FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(Correct_Clean~Group, data=groupdata) #Make this a bar chart

#Anova for correctness by group <<<< THIS SHOWS SIGNIFICANT DIFFERENCES
fit = aov(Correct_Clean~as.factor(Group),data=groupdata)
summary(fit)
TukeyHSD(fit)
#note here that there is no difference between groups 2 and 3




###########################################################################
######################## STOP HERE !!!!!!!#################################
###########################################################################


#Correctness by trial
summaryBy(Correct_Clean~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(Correct_Clean ~ Trial, data=t1)
boxplot(Correct_Clean ~ Trial, data=t2)
boxplot(Correct_Clean ~ Trial, data=t3)

#Anova for correctness by trial and group
fit = aov(Correct_Clean~as.factor(Group)*as.factor(Trial),data=trialdata)
summary(fit)
TukeyHSD(fit)
#note here that there is no difference by trial

###########################################################################
####Nothing good below
###########################################################################

######################### AVGDEPTH
#Overall depth
summaryBy(AvgDepth~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(AvgDepth ~ Group, data=data)

#depth by trial
summaryBy(AvgDepth~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

boxplot(AvgDepth ~ Trial, data=g1)
boxplot(AvgDepth ~ Trial, data=g2)
boxplot(AvgDepth ~ Trial, data=g3)

#Anova for depth by trial and group
fit = aov(AvgDepth~as.factor(Group)*as.factor(Trial),data=data)
summary(fit)
TukeyHSD(fit)

#Anova for depth by group
fit = aov(AvgDepth~as.factor(Group),data=data)
summary(fit)
TukeyHSD(fit)

##Note here that this is a big box of nope
#Isaac is disappointed

######################### AVGRECOIL
#Overall recoil
summaryBy(AvgRecoil~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(AvgRecoil ~ Group, data=data)

#recoil by trial
summaryBy(AvgRecoil~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

boxplot(AvgRecoil ~ Trial, data=g1)
boxplot(AvgRecoil ~ Trial, data=g2)
boxplot(AvgRecoil ~ Trial, data=g3)

#Anova for recoil by trial and group
fit = aov(AvgRecoil~as.factor(Group)*as.factor(Trial),data=data)
summary(fit)
TukeyHSD(fit)

#Anova for recoil by group
fit = aov(AvgRecoil~as.factor(Group),data=data)
summary(fit)
TukeyHSD(fit)

##Note here that this is another big box of nope

######################### AVGRATE
#Overall rate
summaryBy(AvgRate~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(AvgRate ~ Group, data=data)

#rate by trial
summaryBy(AvgRate~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

boxplot(AvgRate ~ Trial, data=g1)
boxplot(AvgRate ~ Trial, data=g2)
boxplot(AvgRate ~ Trial, data=g3)

#Anova for rate by trial and group
fit = aov(AvgRate~as.factor(Group)*as.factor(Trial),data=data)
summary(fit)
TukeyHSD(fit)

#Anova for rate by group
fit = aov(AvgRate~as.factor(Group),data=data)
summary(fit)
TukeyHSD(fit)

##Huge pile of nope

######################### NUMBADDEPTH
#Overall numbaddepth
summaryBy(NumBadDepth~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(NumBadDepth ~ Group, data=data)

#numbaddepth by trial
summaryBy(NumBadDepth~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

boxplot(NumBadDepth ~ Trial, data=g1)
boxplot(NumBadDepth ~ Trial, data=g2)
boxplot(NumBadDepth ~ Trial, data=g3)

#Proportion of NBD

summaryBy(NBD_Prop~Group, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})
boxplot(NBD_Prop ~ Group, data=data)

summaryBy(NBD_Prop~Group+Trial, data=data, FUN = function(x) { c(m = mean(x), s = sd(x))})

boxplot(NBD_Prop ~ Trial, data=g1)
boxplot(NBD_Prop ~ Trial, data=g2)
boxplot(NBD_Prop ~ Trial, data=g3)

