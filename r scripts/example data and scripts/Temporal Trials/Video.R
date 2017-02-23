library(datasets)
myData = sleep
#Find mean of Extra
mean(sleep$extra)
#Find STDev of Extra
sd(sleep$extra)
#Find Range
range(sleep$extra)
#Example summary
summary(sleep$extra)
summary(sleep)

mean(sleep$extra[sleep$group==1])
sleep$extra[sleep$group==1]
group1Data = sleep[sleep$group==1,]
group2Data = sleep[sleep$group==2,]

#T-Test for between subjects
t.test(group1Data$extra, group2Data$extra)
t.test(group1Data$extra, group2Data$extra, var.equal=TRUE)
t.test(extra~group, data=sleep)

#T-Test Paired for within subjects
t.test(extra~group, data=sleep, paired=TRUE )

#Load Data from file
data <- read.table("effective_width.dat",
                   header = TRUE, sep="\t")

data$ID = ID(data$Distance, data$TargetWidth);
data$User<- as.factor(data$User)
data$Distance<- as.ordered(data$Distance)
data$TargetWidth <- as.ordered(data$TargetWidth)
data$ID <- as.ordered(data$ID)
data$TaskName <- as.factor(data$TaskName)

#One-way anova
levels(data$TaskName)
fit = aov(WidthEffective ~ TaskName, data=data)
summary(fit)
#Post-hoc Test
TukeyHSD(fit)

# repeated measures ANOVA
library(ez)
anova = ezANOVA(data=data, dv=.(WidthEffective), within=.(TaskName), wid=.(User),
               type=3, detailed=TRUE, return_aov=TRUE)
anova

#load some helper libraries
library(multcomp)
library(nlme)
lme_we = lme(WidthEffective~TaskName, data=data, random=~1|User)
glht_we = glht(lme_we, linfct=mcp(TaskName="Tukey"))
summary(glht_we, test=adjusted(type="bonferroni"))

#between subject with multiple IV
fit = aov(WidthEffective~TaskName*ID, data=data)
summary(fit)
#Post-hoc Test
TukeyHSD(fit)

#within subject with multiple IV
anova = ezANOVA(data=data, dv=.(WidthEffective), within=.(TaskName, ID), wid=.(User),
                type=3, detailed=TRUE, return_aov=TRUE)
anova

#Do Post Hoc Test
lme_we = lme(WidthEffective~TaskName, data=data, random=~1|User)
glht_we = glht(lme_we, linfct=mcp(TaskName="Tukey"))
summary(glht_we, test=adjusted(type="bonferroni"))

lme_we = lme(WidthEffective~ID, data=data, random=~1|User)
glht_we = glht(lme_we, linfct=mcp(ID="Tukey"))
summary(glht_we, test=adjusted(type="bonferroni"))

## From Agresti(2007) p.39
M <- as.table(rbind(c(762, 327, 468), c(484, 239, 477)))
dimnames(M) <- list(gender = c("M","F"),
                    party = c("Democrat","Independent", "Republican"))
chisq.test(M)
chi = chisq.test(M)
chi$observed
chi$expected