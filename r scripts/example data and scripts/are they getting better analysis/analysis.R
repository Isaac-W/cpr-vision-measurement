################################################################################### 
# Load
################################################################################### 

summary_final <- read.csv("D:/Documents/Courses/UF Research Methods/cpr-vision-measurement/r scripts/example data and scripts/are they getting better analysis/final_study_summary.csv")
View(summary_final)

################################################################################### 
# Summaries
################################################################################### 

summary(summary_final)
# Participant        Condition       Trial            Gesture         X.Val      GestureLength.ns. IdealGestureLength
# Min.   : 7.00            :1935         :1935             :1935   Min.   :0      Min.   :   21.2   Min.   :1000      
# 1st Qu.:16.00   Control  : 955   First : 980   DoubleFlip: 385   1st Qu.:1      1st Qu.:  265.0   1st Qu.:1000      
# Median :27.00   Glissando: 980   Return: 955   FlickDown : 390   Median :2      Median :  402.0   Median :1010      
# Mean   :26.96                                  FlickLeft : 380   Mean   :2      Mean   :  522.2   Mean   :1006      
# 3rd Qu.:37.00                                  FlickRight: 390   3rd Qu.:3      3rd Qu.:  569.5   3rd Qu.:1010      
# Max.   :48.00                                  FlickUp   : 390   Max.   :4      Max.   :20200.0   Max.   :1010      
# NA's   :1935                                                     NA's   :1935   NA's   :1935      NA's   :1935      
# Difference       ABSDifference        X               Slope            X.1         
# Min.   :-19200.0   Min.   :    4.0   Mode:logical   Min.   :-916.400   Mode:logical  
# 1st Qu.:   437.0   1st Qu.:  464.5   NA's:3870      1st Qu.: -24.400   NA's:3870     
# Median :   603.0   Median :  615.0                  Median :   9.600                 
# Mean   :   483.7   Mean   :  635.0                  Mean   :   9.281                 
# 3rd Qu.:   741.0   3rd Qu.:  754.0                  3rd Qu.:  43.600                 
# Max.   :   984.0   Max.   :19200.0                  Max.   :3194.700                 
# NA's   :1935       NA's   :1935                     NA's   :1935     

levels(summary_final$Condition)
#[1] ""          "Control"   "Glissando"
fit = aov(Slope ~ Condition, data=summary_final)
summary(fit)
# Df   Sum Sq Mean Sq F value Pr(>F)  
# Condition      1   129935  129935   3.295 0.0696 .
# Residuals   1933 76223921   39433                 
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 1935 observations deleted due to missingness

subset(summary_final, Trial == "First") -> first_summary_final
View(first_summary_final)

fit = aov(Slope ~ Condition, data=first_summary_final)
summary(fit)
# Df   Sum Sq Mean Sq F value Pr(>F)  
# Condition     1   307105  307105   4.724   0.03 *
#   Residuals   978 63576396   65007                 
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


subset(summary_final, Condition == "Glissando") -> first_summary_final_glissando
subset(summary_final, Condition == "Control") -> first_summary_final_Control

mean(first_summary_final_glissando$Slope)
# 17.36999
mean(first_summary_final_Control$Slope)
# 0.9796335

fit = aov(Slope ~ Condition*Gesture, data=first_summary_final)
summary(fit)

aggregate(first_summary_final_glissando$Slope, by=list(first_summary_final_glissando$Gesture), FUN=mean)[2]
# 1 -9.675225
# 2 -1.342500
# 3 16.367026
# 4 66.928500
# 5 14.372105

aggregate(first_summary_final_Control$Slope, by=list(first_summary_final_Control$Gesture), FUN=mean)[2]
# 1  23.11946
# 2  21.27763
# 3 -29.99211
# 4  22.02711
# 5 -29.35475

levels(first_summary_final_Control$Gesture)
# "DoubleFlip" "FlickDown"  "FlickLeft"  "FlickRight" "FlickUp"