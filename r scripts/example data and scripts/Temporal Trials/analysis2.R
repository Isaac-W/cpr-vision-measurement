
########################################################################
#First trials
#All Gestures
mean(data$RatioF)
mean(subset(data, data$Group == "Glissando")$RatioF)
mean(subset(data, data$Group == "Control")$RatioF)

#FL
data.flf <- subset(data, data$GestureF == "FL")
mean(data.flf$RatioF)
mean(subset(data.flf, data.flf$Group == "Glissando")$RatioF)
mean(subset(data.flf, data.flf$Group == "Control")$RatioF)

#FU
data.fuf <- subset(data, data$GestureF == "FU")
mean(data.fuf$RatioF)
mean(subset(data.fuf, data.fuf$Group == "Glissando")$RatioF)
mean(subset(data.fuf, data.fuf$Group == "Control")$RatioF)

#DF
data.dffr <- subset(data,data$GestureF == "DFR")
data.dffl <- subset(data,data$GestureF == "DFL")
data.dff <- rbind (data.dffr, data.dffl)

mean(data.dff$RatioF)
mean(subset(data.dff, data.dff$Group == "Glissando")$RatioF)
mean(subset(data.dff, data.dff$Group == "Control")$RatioF)

#FR
data.frf <- subset(data, data$GestureF == "FR")
mean(data.frf$RatioF)
mean(subset(data.frf, data.frf$Group == "Glissando")$RatioF)
mean(subset(data.frf, data.frf$Group == "Control")$RatioF)

#FD
data.fdf <- subset(data, data$GestureF == "FD")
mean(data.fdf$RatioF)
mean(subset(data.fdf, data.fdf$Group == "Glissando")$RatioF)
mean(subset(data.fdf, data.fdf$Group == "Control")$RatioF)

########################################################################
#Return trials
mean(data$RatioR)
mean(subset(data, data$Group == "Glissando")$RatioR)
mean(subset(data, data$Group == "Control")$RatioR)

#FL
data.flr <- subset(data, data$GestureF == "FL")
mean(data.flr$RatioR)
mean(subset(data.flr, data.flr$Group == "Glissando")$RatioR)
mean(subset(data.flr, data.flr$Group == "Control")$RatioR)

#FU
data.fur <- subset(data, data$GestureF == "FU")
mean(data.fur$RatioR)
mean(subset(data.fur, data.fur$Group == "Glissando")$RatioR)
mean(subset(data.fur, data.fur$Group == "Control")$RatioR)

#DF
data.dffr <- subset(data,data$GestureF == "DFR")
data.dffl <- subset(data,data$GestureF == "DFL")
data.dfr <- rbind (data.dffr, data.dffl)

mean(data.dfr$RatioR)
mean(subset(data.dfr, data.dfr$Group == "Glissando")$RatioR)
mean(subset(data.dfr, data.dfr$Group == "Control")$RatioR)

#FR
data.frr <- subset(data, data$GestureF == "FR")
mean(data.frr$RatioR)
mean(subset(data.frr, data.frr$Group == "Glissando")$RatioR)
mean(subset(data.frr, data.frr$Group == "Control")$RatioR)

#FD
data.fdr <- subset(data, data$GestureF == "FD")
mean(data.fdr$RatioR)
mean(subset(data.fdr, data.fdr$Group == "Glissando")$RatioR)
mean(subset(data.fdr, data.fdr$Group == "Control")$RatioR)

########################################################################
#All trials
#All Gestures
mean(data$RatioT)
mean(subset(data, data$Group == "Glissando")$RatioT)
mean(subset(data, data$Group == "Control")$RatioT)

#FL
data.flt <- subset(data, data$GestureF == "FL")
mean(data.flt$RatioT)
mean(subset(data.flt, data.flr$Group == "Glissando")$RatioT)
mean(subset(data.flt, data.flr$Group == "Control")$RatioT)

#FU
data.fut <- subset(data, data$GestureF == "FU")
mean(data.fut$RatioT)
mean(subset(data.fut, data.fut$Group == "Glissando")$RatioT)
mean(subset(data.fut, data.fut$Group == "Control")$RatioT)

#DF
data.dffr <- subset(data,data$GestureF == "DFR")
data.dffl <- subset(data,data$GestureF == "DFL")
data.dft <- rbind (data.dffr, data.dffl)

mean(data.dft$RatioT)
mean(subset(data.dft, data.dft$Group == "Glissando")$RatioT)
mean(subset(data.dft, data.dft$Group == "Control")$RatioT)

#FR
data.frt <- subset(data, data$GestureF == "FR")
mean(data.frt$RatioT)
mean(subset(data.frt, data.frt$Group == "Glissando")$RatioT)
mean(subset(data.frt, data.frt$Group == "Control")$RatioT)

#FD
data.fdt <- subset(data, data$GestureF == "FD")
mean(data.fdt$RatioT)
mean(subset(data.fdt, data.fdt$Group == "Glissando")$RatioT)
mean(subset(data.fdt, data.fdt$Group == "Control")$RatioT)

########################################################################
########################################################################
library(ggplot2)

#All Gestures
dfc <- summarySE(df, measurevar="RatioF", groupvars=c("Glissando","Control"))

mean(data$RatioF)
mean(subset(data, data$Group == "Glissando")$RatioF)
mean(subset(data, data$Group == "Control")$RatioF)

#FL
data.flf <- subset(data, data$GestureF == "FL")
mean(data.flf$RatioF)
mean(subset(data.flf, data.flf$Group == "Glissando")$RatioF)
mean(subset(data.flf, data.flf$Group == "Control")$RatioF)

#FU
data.fuf <- subset(data, data$GestureF == "FU")
mean(data.fuf$RatioF)
mean(subset(data.fuf, data.fuf$Group == "Glissando")$RatioF)
mean(subset(data.fuf, data.fuf$Group == "Control")$RatioF)

#DF
data.dffr <- subset(data,data$GestureF == "DFR")
data.dffl <- subset(data,data$GestureF == "DFL")
data.dff <- rbind (data.dffr, data.dffl)

mean(data.dff$RatioF)
mean(subset(data.dff, data.dff$Group == "Glissando")$RatioF)
mean(subset(data.dff, data.dff$Group == "Control")$RatioF)

#FR
data.frf <- subset(data, data$GestureF == "FR")
mean(data.frf$RatioF)
mean(subset(data.frf, data.frf$Group == "Glissando")$RatioF)
mean(subset(data.frf, data.frf$Group == "Control")$RatioF)

#FD
data.fdf <- subset(data, data$GestureF == "FD")
mean(data.fdf$RatioF)
mean(subset(data.fdf, data.fdf$Group == "Glissando")$RatioF)
mean(subset(data.fdf, data.fdf$Group == "Control")$RatioF)




#http://ggplot2.org/
#http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/
