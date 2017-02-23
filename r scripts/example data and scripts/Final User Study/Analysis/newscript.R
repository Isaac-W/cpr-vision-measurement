resize.win <- function(Width=5, Height=3) #default for chi intended use paper
{
  # works for windows
  dev.off(); # dev.new(width=6, height=6)
  windows(record=TRUE, width=Width, height=Height)
}
resize.win()

IsOutlier = function(trialTime, mean, sd){
  max = mean+sd*3
  min = mean-sd*3
  return(trialTime > max | trialTime < min);
}

IsError = function(value){
  return(value == 'Correct' & 1)
}

summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/SUMMARY_NO.csv")
summary$IsError = ifelse(summary$Outcome=='Correct', 0, 1)
summaryBy(IsError~Condition+Participant,data=summary, FUN = function(x) { c(eRate = sum(x)/25)}) 
summary <- subset(summary, Outcome == "Correct")
summaryF <- subset(summary, Trial == "First")
summaryR <- subset(summary, Trial == "Return")

summaryF$IsError = ifelse(summaryF$Outcome=='Correct', 0, 1)
t = summaryBy(IsError~Condition+Participant+Gesture,data=summaryF, FUN = function(x) { c(eRate = sum(x)/5)}) 
fit = aov(IsError.eRate~Condition*Gesture,data=t)
summary(fit)


t = summaryBy(IsError~Condition+Participant,data=summaryR, FUN = function(x) { c(eRate = sum(x)/25)}) 
t =  subset(t, Participant != 43)
fit = aov(IsError.eRate~Condition,data=t)
summary(fit)
summaryBy(IsError.eRate~Condition, dat=t)
ggplot(t, aes(x=Condition, y=IsError.eRate)) + geom_boxplot()+theme_bw()


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
trialTimes = summaryBy(Difference~Gesture,data=sumsumF, FUN = function(x) { c(m = mean(x), s = sd(x))}) 

sumsumF$outlier = trialTimes$Difference.m[match(sumsumF$Gesture,trialTimes$Gesture)]
sumsumF$outlier2 = trialTimes$Difference.s[match(sumsumF$Gesture,trialTimes$Gesture)]

sumsumF$Filter = IsOutlier(sumsumF$Difference, sumsumF$outlier, sumsumF$outlier2);
numberOfOutliers = nrow(sumsumF[which(sumsumF$Filter==1),]);
numberOfOutliers;
sumsumF = sumsumF[which(sumsumF$Filter==0),]
sumsumF = sumsumF[which(sumsumF$Participant != 8 & sumsumF$Participant != 10),]
sumsumF$Difference = sumsumF$Difference/1000000
g = ggplot(sumsumF, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()+theme_bw()
g
ggsave("Boxplot_F.png", dpi=300)

sumsumR <- summaryBy(Difference~Gesture+Participant+Trial+Condition,data=summaryF, keep.names=TRUE)

trialTimes = summaryBy(Difference~Gesture,data=sumsumR, FUN = function(x) { c(m = mean(x), s = sd(x))}) 

sumsumR$outlier = trialTimes$Difference.m[match(sumsumR$Gesture,trialTimes$Gesture)]
sumsumR$outlier2 = trialTimes$Difference.s[match(sumsumR$Gesture,trialTimes$Gesture)]

sumsumR$Filter = IsOutlier(sumsumR$Difference, sumsumR$outlier, sumsumR$outlier2);
numberOfOutliers = nrow(sumsumR[which(sumsumR$Filter==1),]);
numberOfOutliers;
sumsumR = sumsumR[which(sumsumR$Filter==0),]
ggplot(sumsumR, aes(x=Gesture, y=Difference, fill=Condition)) + geom_boxplot()+theme_bw()
g
ggsave("Boxplot_R.png", dpi=300)


summaryFsum <- summarySE(sumsumF, measurevar="Difference", groupvars=c("Condition","Gesture"))
ggplot(summaryFsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + theme_bw()
ggsave("Bar_F.png", dpi=300)


summaryRsum <- summarySE(sumsumR, measurevar="Difference", groupvars=c("Condition","Gesture"))
ggplot(summaryRsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + theme_bw()
ggsave("Bar_R.png", dpi=300)

fit = aov(Difference ~ Condition*Gesture, data=sumsumF)
summary.aov(fit)
TukeyHSD(fit)
aov = ezANOVA(data=sumsumF, dv=Difference, between=.(Condition,Gesture), wid=Participant, return_aov=TRUE, detailed=TRUE)
aov


fit = aov(Difference ~ Condition*Gesture, data=sumsumR)
summary.aov(fit)
TukeyHSD(fit)
aov = ezANOVA(data=sumsumR, dv=Difference, between=.(Condition,Gesture), wid=Participant, return_aov=TRUE, detailed=TRUE)
aov

summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/SUMMARY_NO.csv")


