################################################################################### 
# Load
################################################################################### 

> TTCS <- read.csv("C:/Users/Sarah/Dropbox/HCI/Project/Analysis/TTCS.csv")
>   View(TTCS)
> TTCSNO <- read.csv("C:/Users/Sarah/Dropbox/HCI/Project/Analysis/TTCSNO.csv")
>   View(TTCSNO)
> Qs <- read.csv("C:/Users/sarahms/Dropbox/HCI/Project/Analysis/Qs.csv")
>   View(Qs)
> `Q2s` <- read.csv("C:/Users/sarahms/Dropbox/HCI/Project/Analysis/Q2s.csv")
>   View(`Q2s`)
> `Q2sNO` <- read.csv("W:/Dropbox/HCI/Project/Analysis/Q2sNO.csv")
>   View(`Q2sNO`)

################################################################################### 
# Summaries
################################################################################### 

> summary(TTCS)
        ParticipantID Handedness       Age        Gender       Condition     Attempt        Correctness 
 10_13_10_31_15:  5   Left : 15   Min.   :18.00   F: 70   GlissandoF:80   Min.   : 0.000   Correct:320  
 10_13_15_29_56:  5   Right:305   1st Qu.:21.00   M:250   GlissandoM:80   1st Qu.: 2.000    
 10_13_15_5_39 :  5   Median :22.00           GlissandoS:80   Median : 3.000    
 10_14_15_42_19:  5   Mean   :25.72           Silenzio  :80   Mean   : 4.481    
 10_14_17_50_47:  5   3rd Qu.:28.00   3rd Qu.: 5.000    
 10_15_14_27_13:  5   Max.   :61.00   Max.   :22.000    
 (Other)       :290 
     Length          AverageLength       Participated
 Min.   :5.569e+08   Min.   :8.085e+08   no :240     
 1st Qu.:1.214e+09   1st Qu.:1.241e+09   yes: 80     
 Median :1.680e+09   Median :1.775e+09   
 Mean   :2.379e+09   Mean   :2.379e+09   
 3rd Qu.:2.399e+09   3rd Qu.:2.344e+09   
 Max.   :2.777e+10   Max.   :1.353e+10         
 
> summary(TTCSNO)
        ParticipantID Handedness       Age        Gender       Condition     Attempt      Correctness      Length         
 10_13_10_31_15:  5   Left : 15   Min.   :18.00   F: 70   GlissandoF:80   Min.   : 0.0   Correct:318   Min.   :5.569e+08  
 10_13_15_29_56:  5   Right:303   1st Qu.:21.00   M:248   GlissandoM:79   1st Qu.: 2.0     1st Qu.:1.214e+09  
 10_13_15_5_39 :  5   Median :22.00           GlissandoS:79   Median : 3.0     Median :1.677e+09  
 10_14_15_42_19:  5   Mean   :25.74           Silenzio  :80   Mean   : 4.5     Mean   :2.261e+09  
 10_14_17_50_47:  5   3rd Qu.:28.00   3rd Qu.: 5.0     3rd Qu.:2.396e+09  
 10_15_14_27_13:  5   Max.   :61.00   Max.   :22.0     Max.   :1.378e+10  
 (Other)       :288       
 AverageLength       Participated
 Min.   :8.085e+08   no :238     
 1st Qu.:1.212e+09   yes: 80     
 Median :1.710e+09   
 Mean   :2.255e+09   
 3rd Qu.:2.322e+09   
 Max.   :9.969e+09     
 
> summary(Qs)
         Participant       Condition      Question      Answer     
 10_13_10_31_15:  6   GlissandoF:102   Answer1:67   Min.   : 0.00  
 10_13_15_29_56:  6   GlissandoM: 96   Answer2:67   1st Qu.: 2.10  
 10_13_15_5_39 :  6   GlissandoS: 96   Answer3:67   Median : 5.00  
 10_14_15_42_19:  6   Silenzio  :108   Answer4:67   Mean   : 4.98  
 10_14_17_50_47:  6        Answer5:67   3rd Qu.: 7.80  
 10_15_14_27_13:  6        Answer6:67   Max.   :10.00  
 (Other)       :366          
 
> summary(Q2s)
        ParticipantID      Condition     Answer1          Answer2          Answer3          Answer4          Answer5      
 10_13_10_31_15: 1    GlissandoF:17   Min.   : 1.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 10_13_15_29_56: 1    GlissandoM:16   1st Qu.: 5.500   1st Qu.: 3.200   1st Qu.: 0.800   1st Qu.: 6.300   1st Qu.: 0.600  
 10_13_15_5_39 : 1    GlissandoS:16   Median : 7.600   Median : 6.300   Median : 2.300   Median : 7.600   Median : 2.200  
 10_14_15_42_19: 1    Silenzio  :18   Mean   : 7.042   Mean   : 5.784   Mean   : 3.204   Mean   : 7.016   Mean   : 2.737  
 10_14_17_50_47: 1        3rd Qu.: 8.850   3rd Qu.: 8.250   3rd Qu.: 5.250   3rd Qu.: 8.700   3rd Qu.: 3.950  
 10_15_14_27_13: 1        Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
 (Other)       :61        
    Answer6      
 Min.   : 0.000  
 1st Qu.: 1.650  
 Median : 3.600  
 Mean   : 4.096  
 3rd Qu.: 6.350  
 Max.   :10.000    
 
################################################################################### 
# One-Way Anova - Direct
################################################################################### 
 
> levels(TTCS$Condition)
[1] " GlissandoF" " GlissandoM" " GlissandoS" " Silenzio"  
> fit = aov(Length ~ Condition, data=TTCS)
> summary(fit)
 Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition     3 5.943e+20 1.981e+20   45.66 <2e-16 ***
Residuals   311 1.349e+21 4.338e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Length ~ Condition, data = TTCS)

$Condition
       diff         lwr         upr     p adj
 GlissandoM- GlissandoF   961986393    97295883  1826676903 0.0224093
 GlissandoS- GlissandoF  3540754896  2676064385  4405445406 0.0000000
 Silenzio- GlissandoF     454305941  -410384569  1318996451 0.5273184
 GlissandoS- GlissandoM  2578768503  1728138938  3429398068 0.0000000
 Silenzio- GlissandoM    -507680452 -1358310016   342949113 0.4139197
 Silenzio- GlissandoS   -3086448954 -3937078519 -2235819390 0.0000000
 
> levels(TTCSNO$Condition)
[1] " GlissandoF" " GlissandoM" " GlissandoS" " Silenzio"  
> fit = aov(Length ~ Condition, data=TTCSNO)
> summary(fit)
 Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition     3 4.951e+20 1.650e+20   77.67 <2e-16 ***
Residuals   309 6.565e+20 2.125e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Length ~ Condition, data = TTCSNO)

$Condition
       diff         lwr         upr     p adj
 GlissandoM- GlissandoF   806488008   199477778  1413498237 0.0037845
 GlissandoS- GlissandoF  3248497948  2641487718  3855508178 0.0000000
 Silenzio- GlissandoF     454305941  -150853831  1059465714 0.2138891
 GlissandoS- GlissandoM  2442009940  1842934826  3041085054 0.0000000
 Silenzio- GlissandoM    -352182067  -949382137   245018004 0.4247718
 Silenzio- GlissandoS   -2794192007 -3391392077 -2196991936 0.0000000
 
 
################################################################################### 
# One-Way Anova - Averages of Averages
################################################################################### 
> levels(TTCS$Condition)
[1] "GlissandoF" "GlissandoM" "GlissandoS" "Silenzio"  
> fit = aov(AverageLength ~ Condition, data = TTCS)
> summary(fit)
 Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition     3 6.026e+20 2.009e+20   90.57 <2e-16 ***
Residuals   316 7.008e+20 2.218e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = AverageLength ~ Condition, data = TTCS)

$Condition
     diff         lwr         upr     p adj
GlissandoM-GlissandoF   964745536   356594271  1572896801 0.0003092
GlissandoS-GlissandoF  3543514039  2935362774  4151665304 0.0000000
Silenzio-GlissandoF     457065085  -151086180  1065216350 0.2130524
GlissandoS-GlissandoM  2578768503  1970617238  3186919768 0.0000000
Silenzio-GlissandoM    -507680452 -1115831717   100470813 0.1379846
Silenzio-GlissandoS   -3086448954 -3694600219 -2478297690 0.0000000

> levels(TTCSNO$Condition)
[1] "GlissandoF" "GlissandoM" "GlissandoS" "Silenzio"  
> fit = aov(AverageLength ~ Condition, data = TTCSNO)
> summary(fit)
             Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition     3 5.047e+20 1.682e+20   136.4 <2e-16 ***
Residuals   314 3.871e+20 1.233e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = AverageLength ~ Condition, data = TTCSNO)

$Condition
     diff         lwr         upr     p adj
GlissandoM-GlissandoF   809247151   354370500  1264123803 0.0000371
GlissandoS-GlissandoF  3251257091  2796380440  3706133743 0.0000000
Silenzio-GlissandoF     432189169   -21254797   885633135 0.0680457
GlissandoS-GlissandoM  2442009940  1985705101  2898314780 0.0000000
Silenzio-GlissandoM    -377057982  -831934634    77818669 0.1425152
Silenzio-GlissandoS   -2819067922 -3273944574 -2364191271 0.0000000


Bottom line: smaller P values, but significance did not change

################################################################################### 
# Factorial Anova - Direct
################################################################################### 

> TTCS$Condition = factor(TTCS$Condition)
> TTCS$Attempt = factor(TTCS$Attempt)
> replications (Length ~ Condition * Attempt, data = TTCS)
$Condition
[1] 80

$Attempt
Attempt
 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 20 21 22 
31 39 45 49 49 28 17 12  8  4  6  5  4  6  2  3  3  2  2  2  2  1 

$`Condition:Attempt`
Attempt
Condition     0  1  2  3  4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 22
  GlissandoF  4  6 10 12 11 10 5 3 2 1  3  3  3  3  2  1  1  0  0  0  0  0
  GlissandoM  9  9 11  9 10  5 3 1 2 1  2  2  1  2  0  2  2  2  2  2  2  1
  GlissandoS 10 12 13 13 15  6 3 3 3 1  1  0  0  0  0  0  0  0  0  0  0  0
  Silenzio    8 12 11 15 13  7 6 5 1 1  0  0  0  1  0  0  0  0  0  0  0  0
  
> fit = aov(Length ~ Condition * Attempt, data = TTCS)
> summary(fit)
                    Df    Sum Sq    Mean Sq    F value Pr(>F)    
Condition           3     6.026e+20 2.009e+20  44.423 <2e-16 ***
Attempt            21 	  7.104e+19 3.383e+18   0.748  0.781    
Condition:Attempt  35 	  1.026e+20 2.930e+18   0.648  0.939    
Residuals         260 	  1.176e+21 4.522e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> TukeyHSD(fit)
...
GlissandoM:22-GlissandoM:21  -236914390.0 -11454209669 10980380889 1.0000000
GlissandoS:22-GlissandoM:21NA           NA          NA        NA
...

> TTCSNO$Condition = factor(TTCSNO$Condition)
> TTCSNO$Attempt = factor(TTCSNO$Attempt)
> fit = aov(Length ~ Condition * Attempt, data = TTCSNO)
> summary(fit)
       Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition           3 5.020e+20 1.673e+20  81.832 <2e-16 ***
Attempt21 5.627e+19 2.680e+18   1.311  0.168    
Condition:Attempt  35 7.279e+19 2.080e+18   1.017  0.448    
Residuals         258 5.275e+20 2.045e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

...
GlissandoM:22-GlissandoM:21  -236914390.0  -7780927460  7307098680 1.0000000
GlissandoS:22-GlissandoM:21NA           NA          NA        NA
...

################################################################################### 
# Factorial Anova - Averages of Averages
################################################################################### 
> fit = aov(AverageLength ~ Condition * Attempt, data = TTCS)
> summary(fit)
       Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition           3 6.026e+20 2.009e+20  79.555 <2e-16 ***
Attempt21 2.128e+19 1.013e+18   0.401  0.992    
Condition:Attempt  35 2.307e+19 6.590e+17   0.261  1.000    
Residuals         260 6.565e+20 2.525e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> TukeyHSD(fit)

Same BS

> fit = aov(AverageLength ~ Condition * Attempt, data = TTCSNO)
> summary(fit)
       Df    Sum Sq   Mean Sq F value Pr(>F)    
Condition           3 5.047e+20 1.682e+20 122.187 <2e-16 ***
Attempt21 1.352e+19 6.438e+17   0.468  0.979    
Condition:Attempt  35 1.839e+19 5.256e+17   0.382  0.999    
Residuals         258 3.552e+20 1.377e+18       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> TukeyHSD(fit)

Same BS

################################################################################### 
# One-Way Anova - Questionnaire
################################################################################### 

> levels(Qs$Question)
[1] "Answer1" "Answer2" "Answer3" "Answer4" "Answer5" "Answer6"  

> fit = aov(Answer ~ Question, data = Qs)
> summary(fit)
 Df Sum Sq Mean Sq F value Pr(>F)    
Question      5   1206  241.31   32.91 <2e-16 ***
Residuals   396   2903    7.33       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer ~ Question, data = Qs)

$Question
           diff         lwr         upr     p adj
Answer2-Answer1 -1.25820896 -2.59790153  0.08148362 0.0795816
Answer3-Answer1 -3.83731343 -5.17700601 -2.49762086 0.0000000
Answer4-Answer1 -0.02537313 -1.36506571  1.31431944 0.9999999
Answer5-Answer1 -4.30447761 -5.64417019 -2.96478504 0.0000000
Answer6-Answer1 -2.94626866 -4.28596123 -1.60657608 0.0000000
Answer3-Answer2 -2.57910448 -3.91879705 -1.23941190 0.0000009
Answer4-Answer2  1.23283582 -0.10685675  2.57252840 0.0912879
Answer5-Answer2 -3.04626866 -4.38596123 -1.70657608 0.0000000
Answer6-Answer2 -1.68805970 -3.02775228 -0.34836713 0.0046554
Answer4-Answer3  3.81194030  2.47224772  5.15163287 0.0000000
Answer5-Answer3 -0.46716418 -1.80685675  0.87252840 0.9182469
Answer6-Answer3  0.89104478 -0.44864780  2.23073735 0.4007464
Answer5-Answer4 -4.27910448 -5.61879705 -2.93941190 0.0000000
Answer6-Answer4 -2.92089552 -4.26058810 -1.58120295 0.0000000
Answer6-Answer5  1.35820896  0.01851638  2.69790153 0.0447635

################################################################################### 

> levels(Q2s$Condition)
[1] "GlissandoF" "GlissandoM" "GlissandoS" "Silenzio" 
> fit = aov(Answer1 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3    5.7   1.891   0.306  0.821
Residuals   63  388.9   6.173           
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer1 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF -0.1594853 -2.443321 2.124351 0.9977556
GlissandoS-GlissandoF -0.5738603 -2.857696 1.709976 0.9105177
Silenzio-GlissandoF    0.2223203 -1.995190 2.439831 0.9934513
GlissandoS-GlissandoM -0.4143750 -2.732556 1.903806 0.9650131
Silenzio-GlissandoM    0.3818056 -1.871062 2.634673 0.9699223
Silenzio-GlissandoS    0.7961806 -1.456687 3.049048 0.7874770

> fit = aov(Answer2 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   34.6  11.524   1.339   0.27
Residuals   63  542.3   8.607   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer2 ~ Condition, data = Q2s)

$Condition
    diff        lwr      upr     p adj
GlissandoM-GlissandoF  0.9550000 -1.7417359 3.651736 0.7864424
GlissandoS-GlissandoF -0.2950000 -2.9917359 2.401736 0.9915373
Silenzio-GlissandoF    1.4744444 -1.1439749 4.092864 0.4519026
GlissandoS-GlissandoM -1.2500000 -3.9872906 1.487291 0.6259445
Silenzio-GlissandoM    0.5194444 -2.1407238 3.179613 0.9551365
Silenzio-GlissandoS    1.7694444 -0.8907238 4.429613 0.3044271

> fit = aov(Answer3 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   12.3   4.100   0.516  0.673
Residuals   63  500.4   7.942   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer3 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.3484559 -2.242035 2.938947 0.9845244
GlissandoS-GlissandoF  0.4353309 -2.155160 3.025822 0.9706372
Silenzio-GlissandoF   -0.6386275 -3.153887 1.876632 0.9079981
GlissandoS-GlissandoM  0.0868750 -2.542573 2.716323 0.9997598
Silenzio-GlissandoM   -0.9870833 -3.542447 1.568281 0.7387640
Silenzio-GlissandoS   -1.0739583 -3.629322 1.481406 0.6853171

> fit = aov(Answer4 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   20.1   6.713   1.009  0.395
Residuals   63  418.9   6.650   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer4 ~ Condition, data = Q2s)

$Condition
   diff       lwr      upr     p adj
GlissandoM-GlissandoF -1.362904 -3.733220 1.007411 0.4333566
GlissandoS-GlissandoF -1.040404 -3.410720 1.329911 0.6550688
Silenzio-GlissandoF   -1.283529 -3.585008 1.017949 0.4604341
GlissandoS-GlissandoM  0.322500 -2.083461 2.728461 0.9846813
Silenzio-GlissandoM    0.079375 -2.258799 2.417549 0.9997395
Silenzio-GlissandoS   -0.243125 -2.581299 2.095049 0.9927092

> fit = aov(Answer5 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   31.2  10.384   1.626  0.192
Residuals   63  402.4   6.387   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer5 ~ Condition, data = Q2s)

$Condition
     diff        lwr      upr     p adj
GlissandoM-GlissandoF  1.45198529 -0.8710535 3.775024 0.3589399
GlissandoS-GlissandoF  1.77823529 -0.5448035 4.101274 0.1915966
Silenzio-GlissandoF    1.37379085 -0.8817841 3.629366 0.3819770
GlissandoS-GlissandoM  0.32625000 -2.0317237 2.684224 0.9832060
Silenzio-GlissandoM   -0.07819444 -2.3697329 2.213344 0.9997355
Silenzio-GlissandoS   -0.40444444 -2.6959829 1.887094 0.9662484

> fit = aov(Answer6 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   13.0   4.334    0.47  0.705
Residuals   63  581.4   9.228   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer6 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.4591912 -2.333062 3.251444 0.9723944
GlissandoS-GlissandoF  0.9948162 -1.797437 3.787069 0.7833661
Silenzio-GlissandoF   -0.1315033 -2.842666 2.579659 0.9992427
GlissandoS-GlissandoM  0.5356250 -2.298619 3.369869 0.9590673
Silenzio-GlissandoM   -0.5906944 -3.345084 2.163696 0.9417975
Silenzio-GlissandoS   -1.1263194 -3.880709 1.628071 0.7034520

###################################################################

> fit = aov(Answer1 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3    5.7   1.891   0.306  0.821
Residuals   63  388.9   6.173   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer1 ~ Condition, data = Q2sNO)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF -0.1594853 -2.443321 2.124351 0.9977556
GlissandoS-GlissandoF -0.5738603 -2.857696 1.709976 0.9105177
Silenzio-GlissandoF    0.2223203 -1.995190 2.439831 0.9934513
GlissandoS-GlissandoM -0.4143750 -2.732556 1.903806 0.9650131
Silenzio-GlissandoM    0.3818056 -1.871062 2.634673 0.9699223
Silenzio-GlissandoS    0.7961806 -1.456687 3.049048 0.7874770

> fit = aov(Answer2 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   34.6  11.524   1.339   0.27
Residuals   63  542.3   8.607   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer2 ~ Condition, data = Q2sNO)

$Condition
    diff        lwr      upr     p adj
GlissandoM-GlissandoF  0.9550000 -1.7417359 3.651736 0.7864424
GlissandoS-GlissandoF -0.2950000 -2.9917359 2.401736 0.9915373
Silenzio-GlissandoF    1.4744444 -1.1439749 4.092864 0.4519026
GlissandoS-GlissandoM -1.2500000 -3.9872906 1.487291 0.6259445
Silenzio-GlissandoM    0.5194444 -2.1407238 3.179613 0.9551365
Silenzio-GlissandoS    1.7694444 -0.8907238 4.429613 0.3044271

> fit = aov(Answer3 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   12.3   4.100   0.516  0.673
Residuals   63  500.4   7.942   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer3 ~ Condition, data = Q2sNO)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.3484559 -2.242035 2.938947 0.9845244
GlissandoS-GlissandoF  0.4353309 -2.155160 3.025822 0.9706372
Silenzio-GlissandoF   -0.6386275 -3.153887 1.876632 0.9079981
GlissandoS-GlissandoM  0.0868750 -2.542573 2.716323 0.9997598
Silenzio-GlissandoM   -0.9870833 -3.542447 1.568281 0.7387640
Silenzio-GlissandoS   -1.0739583 -3.629322 1.481406 0.6853171

> fit = aov(Answer4 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   20.1   6.713   1.009  0.395
Residuals   63  418.9   6.650   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer4 ~ Condition, data = Q2sNO)

$Condition
   diff       lwr      upr     p adj
GlissandoM-GlissandoF -1.362904 -3.733220 1.007411 0.4333566
GlissandoS-GlissandoF -1.040404 -3.410720 1.329911 0.6550688
Silenzio-GlissandoF   -1.283529 -3.585008 1.017949 0.4604341
GlissandoS-GlissandoM  0.322500 -2.083461 2.728461 0.9846813
Silenzio-GlissandoM    0.079375 -2.258799 2.417549 0.9997395
Silenzio-GlissandoS   -0.243125 -2.581299 2.095049 0.9927092

> fit = aov(Answer5 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   31.2  10.384   1.626  0.192
Residuals   63  402.4   6.387   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer5 ~ Condition, data = Q2sNO)

$Condition
     diff        lwr      upr     p adj
GlissandoM-GlissandoF  1.45198529 -0.8710535 3.775024 0.3589399
GlissandoS-GlissandoF  1.77823529 -0.5448035 4.101274 0.1915966
Silenzio-GlissandoF    1.37379085 -0.8817841 3.629366 0.3819770
GlissandoS-GlissandoM  0.32625000 -2.0317237 2.684224 0.9832060
Silenzio-GlissandoM   -0.07819444 -2.3697329 2.213344 0.9997355
Silenzio-GlissandoS   -0.40444444 -2.6959829 1.887094 0.9662484


R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"
Copyright (C) 2013 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/.RData]

> `Q2s` <- read.csv("W:/Dropbox/HCI/Project/Analysis/Q2s.csv")
>   View(`Q2s`)
> `Q2sNO` <- read.csv("W:/Dropbox/HCI/Project/Analysis/Q2sNO.csv")
>   View(`Q2sNO`)
> levels(Q2s$Condition)
[1] "GlissandoF" "GlissandoM" "GlissandoS" "Silenzio"  
> fit = aov(Answer1 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3    5.7   1.891   0.306  0.821
Residuals   63  388.9   6.173   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer1 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF -0.1594853 -2.443321 2.124351 0.9977556
GlissandoS-GlissandoF -0.5738603 -2.857696 1.709976 0.9105177
Silenzio-GlissandoF    0.2223203 -1.995190 2.439831 0.9934513
GlissandoS-GlissandoM -0.4143750 -2.732556 1.903806 0.9650131
Silenzio-GlissandoM    0.3818056 -1.871062 2.634673 0.9699223
Silenzio-GlissandoS    0.7961806 -1.456687 3.049048 0.7874770

> fit = aov(Answer2 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   34.6  11.524   1.339   0.27
Residuals   63  542.3   8.607   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer2 ~ Condition, data = Q2s)

$Condition
    diff        lwr      upr     p adj
GlissandoM-GlissandoF  0.9550000 -1.7417359 3.651736 0.7864424
GlissandoS-GlissandoF -0.2950000 -2.9917359 2.401736 0.9915373
Silenzio-GlissandoF    1.4744444 -1.1439749 4.092864 0.4519026
GlissandoS-GlissandoM -1.2500000 -3.9872906 1.487291 0.6259445
Silenzio-GlissandoM    0.5194444 -2.1407238 3.179613 0.9551365
Silenzio-GlissandoS    1.7694444 -0.8907238 4.429613 0.3044271

> fit = aov(Answer3 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   12.3   4.100   0.516  0.673
Residuals   63  500.4   7.942   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer3 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.3484559 -2.242035 2.938947 0.9845244
GlissandoS-GlissandoF  0.4353309 -2.155160 3.025822 0.9706372
Silenzio-GlissandoF   -0.6386275 -3.153887 1.876632 0.9079981
GlissandoS-GlissandoM  0.0868750 -2.542573 2.716323 0.9997598
Silenzio-GlissandoM   -0.9870833 -3.542447 1.568281 0.7387640
Silenzio-GlissandoS   -1.0739583 -3.629322 1.481406 0.6853171

> fit = aov(Answer2 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   34.6  11.524   1.339   0.27
Residuals   63  542.3   8.607   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer2 ~ Condition, data = Q2s)

$Condition
    diff        lwr      upr     p adj
GlissandoM-GlissandoF  0.9550000 -1.7417359 3.651736 0.7864424
GlissandoS-GlissandoF -0.2950000 -2.9917359 2.401736 0.9915373
Silenzio-GlissandoF    1.4744444 -1.1439749 4.092864 0.4519026
GlissandoS-GlissandoM -1.2500000 -3.9872906 1.487291 0.6259445
Silenzio-GlissandoM    0.5194444 -2.1407238 3.179613 0.9551365
Silenzio-GlissandoS    1.7694444 -0.8907238 4.429613 0.3044271

> fit = aov(Answer4 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   20.1   6.713   1.009  0.395
Residuals   63  418.9   6.650   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer4 ~ Condition, data = Q2s)

$Condition
   diff       lwr      upr     p adj
GlissandoM-GlissandoF -1.362904 -3.733220 1.007411 0.4333566
GlissandoS-GlissandoF -1.040404 -3.410720 1.329911 0.6550688
Silenzio-GlissandoF   -1.283529 -3.585008 1.017949 0.4604341
GlissandoS-GlissandoM  0.322500 -2.083461 2.728461 0.9846813
Silenzio-GlissandoM    0.079375 -2.258799 2.417549 0.9997395
Silenzio-GlissandoS   -0.243125 -2.581299 2.095049 0.9927092

> fit = aov(Answer5 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   31.2  10.384   1.626  0.192
Residuals   63  402.4   6.387   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer5 ~ Condition, data = Q2s)

$Condition
     diff        lwr      upr     p adj
GlissandoM-GlissandoF  1.45198529 -0.8710535 3.775024 0.3589399
GlissandoS-GlissandoF  1.77823529 -0.5448035 4.101274 0.1915966
Silenzio-GlissandoF    1.37379085 -0.8817841 3.629366 0.3819770
GlissandoS-GlissandoM  0.32625000 -2.0317237 2.684224 0.9832060
Silenzio-GlissandoM   -0.07819444 -2.3697329 2.213344 0.9997355
Silenzio-GlissandoS   -0.40444444 -2.6959829 1.887094 0.9662484

> fit = aov(Answer6 ~ Condition, data=Q2s)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   13.0   4.334    0.47  0.705
Residuals   63  581.4   9.228   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer6 ~ Condition, data = Q2s)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.4591912 -2.333062 3.251444 0.9723944
GlissandoS-GlissandoF  0.9948162 -1.797437 3.787069 0.7833661
Silenzio-GlissandoF   -0.1315033 -2.842666 2.579659 0.9992427
GlissandoS-GlissandoM  0.5356250 -2.298619 3.369869 0.9590673
Silenzio-GlissandoM   -0.5906944 -3.345084 2.163696 0.9417975
Silenzio-GlissandoS   -1.1263194 -3.880709 1.628071 0.7034520

> fit = aov(Answer1 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3    5.7   1.891   0.306  0.821
Residuals   63  388.9   6.173   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer1 ~ Condition, data = Q2sNO)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF -0.1594853 -2.443321 2.124351 0.9977556
GlissandoS-GlissandoF -0.5738603 -2.857696 1.709976 0.9105177
Silenzio-GlissandoF    0.2223203 -1.995190 2.439831 0.9934513
GlissandoS-GlissandoM -0.4143750 -2.732556 1.903806 0.9650131
Silenzio-GlissandoM    0.3818056 -1.871062 2.634673 0.9699223
Silenzio-GlissandoS    0.7961806 -1.456687 3.049048 0.7874770

> fit = aov(Answer2 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   34.6  11.524   1.339   0.27
Residuals   63  542.3   8.607   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer2 ~ Condition, data = Q2sNO)

$Condition
    diff        lwr      upr     p adj
GlissandoM-GlissandoF  0.9550000 -1.7417359 3.651736 0.7864424
GlissandoS-GlissandoF -0.2950000 -2.9917359 2.401736 0.9915373
Silenzio-GlissandoF    1.4744444 -1.1439749 4.092864 0.4519026
GlissandoS-GlissandoM -1.2500000 -3.9872906 1.487291 0.6259445
Silenzio-GlissandoM    0.5194444 -2.1407238 3.179613 0.9551365
Silenzio-GlissandoS    1.7694444 -0.8907238 4.429613 0.3044271

> fit = aov(Answer3 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   12.3   4.100   0.516  0.673
Residuals   63  500.4   7.942   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer3 ~ Condition, data = Q2sNO)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.3484559 -2.242035 2.938947 0.9845244
GlissandoS-GlissandoF  0.4353309 -2.155160 3.025822 0.9706372
Silenzio-GlissandoF   -0.6386275 -3.153887 1.876632 0.9079981
GlissandoS-GlissandoM  0.0868750 -2.542573 2.716323 0.9997598
Silenzio-GlissandoM   -0.9870833 -3.542447 1.568281 0.7387640
Silenzio-GlissandoS   -1.0739583 -3.629322 1.481406 0.6853171

> fit = aov(Answer4 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   20.1   6.713   1.009  0.395
Residuals   63  418.9   6.650   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer4 ~ Condition, data = Q2sNO)

$Condition
   diff       lwr      upr     p adj
GlissandoM-GlissandoF -1.362904 -3.733220 1.007411 0.4333566
GlissandoS-GlissandoF -1.040404 -3.410720 1.329911 0.6550688
Silenzio-GlissandoF   -1.283529 -3.585008 1.017949 0.4604341
GlissandoS-GlissandoM  0.322500 -2.083461 2.728461 0.9846813
Silenzio-GlissandoM    0.079375 -2.258799 2.417549 0.9997395
Silenzio-GlissandoS   -0.243125 -2.581299 2.095049 0.9927092

> fit = aov(Answer5 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3   31.2  10.384   1.626  0.192
Residuals   63  402.4   6.387   
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer5 ~ Condition, data = Q2sNO)

$Condition
     diff        lwr      upr     p adj
GlissandoM-GlissandoF  1.45198529 -0.8710535 3.775024 0.3589399
GlissandoS-GlissandoF  1.77823529 -0.5448035 4.101274 0.1915966
Silenzio-GlissandoF    1.37379085 -0.8817841 3.629366 0.3819770
GlissandoS-GlissandoM  0.32625000 -2.0317237 2.684224 0.9832060
Silenzio-GlissandoM   -0.07819444 -2.3697329 2.213344 0.9997355
Silenzio-GlissandoS   -0.40444444 -2.6959829 1.887094 0.9662484

> fit = aov(Answer6 ~ Condition, data=Q2sNO)
> summary(fit)
Df Sum Sq Mean Sq F value Pr(>F)
Condition    3     14   4.659   0.515  0.674
Residuals   58    525   9.051   
5 observations deleted due to missingness
> TukeyHSD(fit)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Answer6 ~ Condition, data = Q2sNO)

$Condition
    diff       lwr      upr     p adj
GlissandoM-GlissandoF  0.2802679 -2.631979 3.192515 0.9941499
GlissandoS-GlissandoF  1.0771250 -1.782880 3.937130 0.7521538
Silenzio-GlissandoF   -0.1533456 -2.925160 2.618468 0.9988696
GlissandoS-GlissandoM  0.7968571 -2.160344 3.754059 0.8916412
Silenzio-GlissandoM   -0.4336134 -3.305610 2.438383 0.9782307
Silenzio-GlissandoS   -1.2304706 -4.049480 1.588538 0.6575468

Bottom line: no significant difference between groups