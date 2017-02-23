# Requires summarySE.R. If you cannot find this, look @ http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/#Helper functions

library(ggplot2)

################################################################################
# This section is for analyzing the ratio of correct / attempts
################################################################################

data <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/ATTEMPTS_NO.csv")
dataF <- summarySE(data, measurevar="RatioF", groupvars=c("Group","GestureF"))

#First
# Error bars represent standard error of the mean
ggplot(dataF, aes(x=GestureF, y=RatioF, fill=Group)) + 
  geom_bar(position=position_dodge(), stat="identity") + 
  ggtitle("Correct/Attempts for First Trials") +
  geom_errorbar(aes(ymin=RatioF-se, ymax=RatioF+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

#Return
dataR <- summarySE(data, measurevar="RatioR", groupvars=c("Group","GestureR"))
# Error bars represent standard error of the mean
ggplot(dataR, aes(x=GestureR, y=RatioR, fill=Group)) + 
  geom_bar(position=position_dodge(), stat="identity") +  
  ggtitle("Correct/Attempts for Return Trials") +
  geom_errorbar(aes(ymin=RatioR-se, ymax=RatioR+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))


dataT <- summarySE(data, measurevar="RatioT", groupvars=c("Group","GestureF"))
# Error bars represent standard error of the mean
ggplot(dataT, aes(x=GestureF, y=RatioT, fill=Group)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("Correct/Attempts for All Trials") +
  geom_errorbar(aes(ymin=RatioT-se, ymax=RatioT+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

################################################################################
# This section is for analyzing ideal gesture length - actual gesture length
################################################################################
library(doBy)
summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/SUMMARY_NO.csv")

summary <- subset(summary, Outcome == "Correct")
summaryF <- subset(summary, Trial == "First")
summaryR <- subset(summary, Trial == "Return")

trialTimes = summaryBy(Difference~Gesture,data=summary, FUN = function(x) { c(m = mean(x), s = sd(x))}) 



summary$outlier = trialTimes$Difference.m[match(summary$Gesture,trialTimes$Gesture)]
summary$outlier2 = trialTimes$Difference.s[match(summary$Gesture,trialTimes$Gesture)]

summary$Filter = IsOutlier(summary$Difference, summary$outlier, summary$outlier2);
numberOfOutliers = nrow(summary[which(summary$Filter==1),]);
numberOfOutliers;
summary = summary[which(summary$Filter==0),]



trialTimes = summaryBy(Difference~Gesture,data=summaryF, FUN = function(x) { c(m = mean(x), s = sd(x))}) 
summaryF$outlier = trialTimes$Difference.m[match(summaryF$Gesture,trialTimes$Gesture)]
summaryF$outlier2 = trialTimes$Difference.s[match(summaryF$Gesture,trialTimes$Gesture)]

summaryF$Filter = IsOutlier(summaryF$Difference, summaryF$outlier, summaryF$outlier2);
numberOfOutliers = nrow(summaryF[which(summaryF$Filter==1),]);
numberOfOutliers;
summaryF = summaryF[which(summaryF$Filter==0),]

trialTimes = summaryBy(Difference~Gesture,data=summaryR, FUN = function(x) { c(m = mean(x), s = sd(x))}) 
summaryR$outlier = trialTimes$Difference.m[match(summaryR$Gesture,trialTimes$Gesture)]
summaryR$outlier2 = trialTimes$Difference.s[match(summaryR$Gesture,trialTimes$Gesture)]

summaryR$Filter = IsOutlier(summaryR$Difference, summaryR$outlier, summaryR$outlier2);
numberOfOutliers = nrow(summaryR[which(summaryR$Filter==1),]);
numberOfOutliers;
summaryR = summaryR[which(summaryR$Filter==0),]


sumsumF <- summaryBy(Difference~Gesture+Participant+Trial+Condition,data=summaryF, keep.names=TRUE)
sumsumF$Difference = abs(sumsumF$Difference)
trialTimes = summaryBy(Difference~Gesture,data=sumsumF, FUN = function(x) { c(m = mean(x), s = sd(x))}) 

sumsumF$outlier = trialTimes$Difference.m[match(sumsumF$Gesture,trialTimes$Gesture)]
sumsumF$outlier2 = trialTimes$Difference.s[match(sumsumF$Gesture,trialTimes$Gesture)]

sumsumF$Filter = IsOutlier(sumsumF$Difference, sumsumF$outlier, sumsumF$outlier2);
numberOfOutliers = nrow(sumsumF[which(sumsumF$Filter==1),]);
numberOfOutliers;
sumsumF = sumsumF[which(sumsumF$Filter==0),]
ggplot(sumsumF, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()

sumsumR <- summaryBy(Difference~Gesture+Participant+Trial+Condition,data=summaryF, keep.names=TRUE)
sumsumR$Difference = abs(sumsumR$Difference)
trialTimes = summaryBy(Difference~Gesture,data=sumsumR, FUN = function(x) { c(m = mean(x), s = sd(x))}) 

sumsumR$outlier = trialTimes$Difference.m[match(sumsumR$Gesture,trialTimes$Gesture)]
sumsumR$outlier2 = trialTimes$Difference.s[match(sumsumR$Gesture,trialTimes$Gesture)]

sumsumR$Filter = IsOutlier(sumsumR$Difference, sumsumR$outlier, sumsumR$outlier2);
numberOfOutliers = nrow(sumsumR[which(sumsumR$Filter==1),]);
numberOfOutliers;
sumsumR = sumsumR[which(sumsumR$Filter==0),]
ggplot(sumsumR, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()

sumsum <- summaryBy(Difference~Gesture+Participant+Trial+Condition,data=summary, keep.names=TRUE)
sumsum$Difference = abs(sumsum$Difference)
trialTimes = summaryBy(Difference~Gesture,data=sumsum, FUN = function(x) { c(m = mean(x), s = sd(x))}) 

sumsum$outlier = trialTimes$Difference.m[match(sumsum$Gesture,trialTimes$Gesture)]
sumsum$outlier2 = trialTimes$Difference.s[match(sumsum$Gesture,trialTimes$Gesture)]

sumsum$Filter = IsOutlier(sumsum$Difference, sumsum$outlier, sumsum$outlier2);
numberOfOutliers = nrow(sumsum[which(sumsum$Filter==1),]);
numberOfOutliers;
sumsum = sumsum[which(sumsum$Filter==0),]


summaryF <- subset(summary, Trial == "First")
summaryR <- subset(summary, Trial == "Return")

summaryF <- subset(sumsum, Trial == "First")
summaryR <- subset(sumsum, Trial == "Return")

summaryFsum <- summarySE(sumsumF, measurevar="Difference", groupvars=c("Condition","Gesture"))

summaryRsum <- summarySE(summaryR, measurevar="Difference", groupvars=c("Condition","Gesture"))


##########################################################################################
##########################################################################################
##########################################################################################
##########################################################################################

########## WANT but with a category for ALL
ggplot(summaryFsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

#ggplot(summaryF, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()

########## WANT but with a category for ALL
ggplot(summaryRsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

#ggplot(summaryR, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()

################################################################################
# This section is for analyzing the second questionnaire
################################################################################
#q2s <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/Q2S_NO.csv")
q2s <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/QsNONO.csv")

q2s_sum <- summarySE(q2s, measurevar="Response", groupvars=c("Condition", "Question"))

########## WANT but with only the right questions
ggplot(q2s_short, aes(x=Question, y=Response, fill=Condition)) + geom_boxplot()



#q2s_short <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/Q2S_NO_SHORT.csv")
q2s_short <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis//Q2S_NO_SHORT.csv")
q1 <- subset(q2s_short, Question == "Q1")
q2 <- subset(q2s_short, Question == "Q2")
q3 <- subset(q2s_short, Question == "Q3")
q4 <- subset(q2s_short, Question == "Q4")
q5 <- subset(q2s_short, Question == "Q5")
q6 <- subset(q2s_short, Question == "Q6")

#across the mediums
t.test(Response ~ Group, data = q1)
# Welch Two Sample t-test
# data:  Response by Group
# t = -0.5708, df = 31.558, p-value = 0.5722
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -2.065980  1.161955
# sample estimates:
#   mean in group control mean in group glissando 
# 7.242105                7.694118 

t.test(Response ~ Group, data = q2)
# Welch Two Sample t-test
# data:  Response by Group
# t = 1.0978, df = 29.835, p-value = 0.2811
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.7037886  2.3390827
# sample estimates:
#   mean in group control mean in group glissando 
# 2.500000                1.682353 

t.test(Response ~ Group, data = q3)
# Welch Two Sample t-test
# data:  Response by Group
# t = -0.6698, df = 32.64, p-value = 0.5077
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -1.4180215  0.7158543
# sample estimates:
#   mean in group control mean in group glissando 
# # 7.984211                8.335294 

t.test(Response ~ Group, data = q4)
# Welch Two Sample t-test
# 
# data:  Response by Group
# t = 0.7459, df = 27.529, p-value = 0.4621
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.7242648  1.5527477
# sample estimates:
#   mean in group control mean in group glissando 
# 1.678947                1.264706 

t.test(Response ~ Group, data = q5)
# Welch Two Sample t-test
# 
# data:  Response by Group
# t = -1.4077, df = 31.311, p-value = 0.1691
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -2.4815547  0.4543101
# sample estimates:
#   mean in group control mean in group glissando 
# 7.115789                8.129412 

t.test(Response ~ Group, data = q6)
# Welch Two Sample t-test
# 
# data:  Response by Group
# t = 1.8357, df = 29.17, p-value = 0.07661
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.1301903  2.4174968
# sample estimates:
#   mean in group control mean in group glissando 
# 2.478947                1.335294 

fit = aov(Difference ~ Condition*Gesture, data=summaryF)
summary.aov(fit)
TukeyHSD(fit)

fit = aov(Difference ~ Condition*Gesture, data=sumsumF)
summary.aov(fit)
TukeyHSD(fit)

fit = aov(Difference ~ Condition*Gesture, data=sumsumR)
summary.aov(fit)
TukeyHSD(fit)

fit = aov(Difference ~ Condition*Gesture, data=summaryR)
summary.aov(fit)
TukeyHSD(fit)

fit = aov(Response ~ Group, data=q5)
summary(fit)


################################################################################
# This section is for analyzing all the questionnaires
################################################################################
qs_short <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis//QS_NO_NO_SHORT.csv")

qs_sum <- summarySE(qs_short, measurevar="Response", groupvars=c("Condition", "Question"))

View(qs_sum)

ggplot(qs_sum, aes(x=Question, y=Response, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") + 
  ggtitle("Questionnaire Responses") +
  geom_errorbar(aes(ymin=Response-se, ymax=Response+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

ggplot(qs_sum, aes(x=Question, y=Response, fill=Condition)) + geom_boxplot()
ggplot(qs_short, aes(x=Question, y=Response, fill=Condition)) + geom_boxplot()

q1 <- subset(qs_short, Question == "Q1")
q2 <- subset(qs_short, Question == "Q2")

q7 <- subset(qs_short, Question == "Q7")
q8 <- subset(qs_short, Question == "Q8")
q9 <- subset(qs_short, Question == "Q9")
q10 <- subset(qs_short, Question == "Q10")
q11 <- subset(qs_short, Question == "Q11")
q12 <- subset(qs_short, Question == "Q12")
q13 <- subset(qs_short, Question == "Q13")
q21 <- subset(qs_short, Question == "2Q1")
q22 <- subset(qs_short, Question == "2Q2")
q23 <- subset(qs_short, Question == "2Q3")
q24 <- subset(qs_short, Question == "2Q4")
q25 <- subset(qs_short, Question == "2Q5")
q26 <- subset(qs_short, Question == "2Q6")

# Not Significant
t.test(Response ~ Condition, data = q7)
t.test(Response ~ Condition, data = q8)
t.test(Response ~ Condition, data = q9)
t.test(Response ~ Condition, data = q10)
t.test(Response ~ Condition, data = q11)
t.test(Response ~ Condition, data = q12)
t.test(Response ~ Condition, data = q13)
t.test(Response ~ Condition, data = q21)
t.test(Response ~ Condition, data = q22)
t.test(Response ~ Condition, data = q23)
t.test(Response ~ Condition, data = q24)
t.test(Response ~ Condition, data = q25)
t.test(Response ~ Condition, data = q26)

summary(q1)
summary(q2)

qs_short <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis//QS_NO_SHORT.csv")
summary(qs_short)
q13 <- subset(qs_short, Question == "Q13")
summary(q13)
sd(q13$Age)
