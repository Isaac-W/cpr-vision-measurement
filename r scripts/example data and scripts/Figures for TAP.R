# Requires summarySE.R. If you cannot find this, look @ http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/#Helper functions

library(ggplot2)
library(RColorBrewer)


################################################################################
# This section is for analyzing ideal gesture length - actual gesture length
################################################################################
library(doBy)
summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/SUMMARY_NO.csv")
q2s <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/QsNONO.csv")
wantqs <- subset(q2s, (Question=="2Q1" | Question=="Q13"))

summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/Analysis/TTCSNO.csv")
summaryT <- summarySE(summary, measurevar="AverageLength", groupvars=c("Condition","Type"))

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


sumsumR$outlier = trialTimes$Difference.m[match(sumsumR$Gesture,trialTimes$Gesture)]
sumsumR$outlier2 = trialTimes$Difference.s[match(sumsumR$Gesture,trialTimes$Gesture)]

sumsumR$Filter = IsOutlier(sumsumR$Difference, sumsumR$outlier, sumsumR$outlier2);
numberOfOutliers = nrow(sumsumR[which(sumsumR$Filter==1),]);
numberOfOutliers;
sumsumR = sumsumR[which(sumsumR$Filter==0),]


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
require(grid)

cbPalette <- c("#a6cee3", "#008da6")

windowsFonts(Times=windowsFont("Times New Roman"))

fontsize <- 35

ggplot(summaryFsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))+
  ylab("Gesture Error (ms)") +
  xlab("Gesture \n (a)") +
  theme_bw()  +
  theme(text = element_text(family="Times", size=fontsize), 
        axis.title.y=element_text(vjust=2),
        legend.position="top", 
        legend.title = element_text(size=0, color = "white"),
        legend.key.size = unit(.5, "cm"))+
  scale_fill_manual(values=cbPalette, labels = c("Control     ", "Glissando"));
ggsave("user_study_a.png", dpi=300)

ggplot(summaryRsum, aes(x=Gesture, y=Difference, fill=Condition)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  ggtitle("") +
  geom_errorbar(aes(ymin=Difference-se, ymax=Difference+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))+
  ylab("Gesture Error (ms)") +
  xlab("Gesture \n (b)") +
  theme_bw()  +
  theme(text = element_text(family="Times", size=fontsize), 
        axis.title.y=element_text(vjust=2),
        legend.position="top", 
        legend.title = element_text(size=0, color = "white"),
        legend.key.size = unit(.5, "cm"))+
  scale_fill_manual(values=cbPalette, labels = c("Control     ", "Glissando"));
ggsave("user_study_b.png", dpi=300)

ggplot(wantqs, aes(x=Question, y=Response, fill=Condition))+ 
  geom_boxplot() +
  ggtitle("") +
  ylab("Response") +
  xlab("") +
  theme_bw()  +
  theme(text = element_text(family="Times", size=fontsize), 
        axis.title.y=element_text(vjust=2),
        legend.position="top", 
        legend.title = element_text(size=0, color = "white"),
        legend.key.size = unit(.5, "cm"))+
  scale_x_discrete(labels=c("Helpfulness of Training","Likelihood of Future Use")) +
  scale_fill_manual(values=cbPalette, labels = c("Control     ", "Glissando"));
ggsave("user_study_c.png", dpi=300)


ggplot(summaryT, aes(x=Condition, y=(AverageLength/1000000000), fill=Type)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=(AverageLength/1000000000)-(sd/1000000000), ymax=(AverageLength/1000000000)+(sd/1000000000)),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + 
  theme_bw() + 
  ylab("Average Gesture Length (s)")+ 
  theme_bw()  +
  theme(text = element_text(family="Times", size=fontsize), 
        axis.title.y=element_text(vjust=2),
        legend.position="top", 
        legend.title = element_text(size=0, color = "white"),
        legend.key.size = unit(.5, "cm")) +
  scale_fill_manual(values=cbPalette, labels = c("Control     ", "Prototype"));
ggsave("third_explore_3.png", dpi=300)

