library(ggplot2)


library(doBy);
library(nlme);
library(car); #needed for ANOVA function
require(multcomp)

brewerPalette = c("#ffeda0", "#f03b20")

resize.win <- function(Width=5, Height=3) #default for chi intended use paper
{
  # works for windows
  dev.off(); # dev.new(width=6, height=6)
  windows(record=TRUE, width=Width, height=Height)
}
resize.win()

summary<- read.csv("C:/Users/sarahms/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/TTCSNO.csv")
summaryT <- summarySE(summary, measurevar="AverageLength", groupvars=c("Condition","Type"))
# Error bars represent standard error of the mean
g = ggplot(summaryT, aes(x=Condition, y=(AverageLength/1000000000), fill=Type)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=(AverageLength/1000000000)-(sd/1000000000), ymax=(AverageLength/1000000000)+(sd/1000000000)),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))
g+ theme_bw() + ylab("Average Gesture Length (s)")+ scale_fill_manual(values=brewerPalette) + theme(legend.position="none")
ggsave("OldAverageLengthNoLegend.png", dpi=300)







g
resize.win()
ggsave("Box_R_legend_top.png", dpi=300)
