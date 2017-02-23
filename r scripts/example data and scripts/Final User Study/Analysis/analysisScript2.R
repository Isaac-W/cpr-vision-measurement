################################################################################### 
# Load
################################################################################### 

#QSNO <- read.csv("A:/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/QSNO.csv")
#View(QSNO)

QSNO <- read.csv("C:/Users/sarahms/Dropbox/Research/Glissando/Code and Data/Glissando Data/Final User Study/QsNONO.csv")
View(QSNO)

#QSNO_VERT <- read.csv("A:/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/QSNO_VERT.csv")
#View(QSNO_VERT)

#ALL713 <- read.csv("A:/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/QSNO_Q7-13_ALL.csv")
#View(ALL713)

#GLISS113 <- read.csv("A:/Dropbox/Research/Projects/CHI 2015/Glissando Data/Analysis/QSNO_Q1-13_GLISS.csv")
#View(GLISS113)

################################################################################### 
# Summaries
################################################################################### 
 
summary(QSNO)
# NID             PID                 Age        Gender  Hand        Condition      Question      Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:166   l: 45   control  :247   2Q1    : 38   Min.   : 0.00  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:429   r:550   glissando:348   2Q2    : 38   1st Qu.: 1.30  
# Median :27.00   Median :901205205   Median :20.00                                   2Q3    : 38   Median : 5.00  
# Mean   :26.82   Mean   :858578755   Mean   :21.65                                   2Q4    : 38   Mean   : 4.83  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                   2Q5    : 38   3rd Qu.: 8.00  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                   2Q6    : 38   Max.   :10.00  
# (Other):367                  

#I found the audio feedback helpful
Q1 <- subset(QSNO, Question=="Q1")
summary(Q1)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q1     :18   Min.   : 2.800  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.: 5.700  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median : 7.175  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   : 6.364  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.: 7.500  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#I did not find the audio feedback helpful
Q2 <- subset(QSNO, Question=="Q2")
summary(Q2)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q2     :18   Min.   :0.000  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.:0.275  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median :2.050  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   :2.494  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.:3.500  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :7.800  
# (Other): 0                  

#The audio feedback helped me learn the timing of the gestures
Q3 <- subset(QSNO, Question=="Q3")
summary(Q3)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q3     :18   Min.   :0.000  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.:3.300  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median :5.600  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   :5.358  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.:7.400  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :9.000  
# (Other): 0                  

#The audio feedback did not help me learn the timing of the gestures
Q4 <- subset(QSNO, Question=="Q4")
summary(Q4)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q4     :18   Min.   : 0.000  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.: 1.750  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median : 3.000  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   : 4.031  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.: 7.050  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The audio feedback helped me learn the movement of the gestures
Q5 <- subset(QSNO, Question=="Q5")
summary(Q5)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q5     :18   Min.   : 0.500  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.: 2.850  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median : 5.550  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   : 5.164  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.: 7.050  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The audio feedback did not help me learn the movement of the gestures
Q6 <- subset(QSNO, Question=="Q6")
summary(Q6)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q6     :18   Min.   :0.000  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.:2.600  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median :3.900  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   :4.322  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.:6.275  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :9.300  
# (Other): 0                  

#I found the video demonstration helpful
Q7 <- subset(QSNO, Question=="Q7")
summary(Q7)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q7     :37   Min.   : 0.20  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.: 7.30  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median : 8.40  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   : 8.03  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.: 9.80  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :10.00  
# (Other): 0                  

#I did not find the video demonstration helpful
Q8 <- subset(QSNO, Question=="Q8")
summary(Q8)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q8     :37   Min.   :0.000  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.:0.200  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median :0.800  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   :1.655  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.:2.100  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :7.150  
# (Other): 0                  

#The video demonstration helped me learn the timing of the gestures
Q9 <- subset(QSNO, Question=="Q9")
summary(Q9)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q9     :37   Min.   : 0.100  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.: 6.100  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median : 8.000  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   : 7.401  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.: 9.300  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The video demonstration did not help me learn the timing of the gestures
Q10 <- subset(QSNO, Question=="Q10")
summary(Q10)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q10    :37   Min.   :0.000  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.:0.350  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median :1.100  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   :2.049  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.:3.700  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :9.600  
# (Other): 0                  

#The video demonstration helped me learn the movement of the gestures
Q11 <- subset(QSNO, Question=="Q11")
summary(Q11)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q11    :37   Min.   : 0.900  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.: 7.500  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median : 9.200  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   : 8.259  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.: 9.600  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The video demonstration did not help me learn the movement of the gestures
Q12 <- subset(QSNO, Question=="Q12")
summary(Q12)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q12    :37   Min.   :0.000  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.:0.100  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median :0.700  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   :1.626  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.:1.500  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :8.700  
# (Other): 0                  

#If this app existed, I would use it to help me learn motion gestures
Q13 <- subset(QSNO, Question=="Q13")
summary(Q13)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f:10   l: 3   control  :19   Q13    :37   Min.   : 0.200  
# 1st Qu.:17.00   1st Qu.:829024939   1st Qu.:19.00   m:27   r:34   glissando:18   2Q1    : 0   1st Qu.: 4.000  
# Median :27.00   Median :901205205   Median :20.00                                2Q2    : 0   Median : 5.700  
# Mean   :27.08   Mean   :866617627   Mean   :21.68                                2Q3    : 0   Mean   : 5.607  
# 3rd Qu.:36.00   3rd Qu.:902005143   3rd Qu.:23.00                                2Q4    : 0   3rd Qu.: 7.800  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The training session helped me learn the gestures
t_Q1 <- subset(QSNO, Question=="2Q1")
summary(t_Q1)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q1    :38   Min.   : 0.000  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q2    : 0   1st Qu.: 6.475  
# Median :26.50   Median :865125268   Median :20.00                                2Q3    : 0   Median : 7.850  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q4    : 0   Mean   : 7.289  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q5    : 0   3rd Qu.: 9.450  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The training session did not help me learn the gestures
t_Q2 <- subset(QSNO, Question=="2Q2")
summary(t_Q2)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q2    :38   Min.   : 0.000  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q1    : 0   1st Qu.: 0.500  
# Median :26.50   Median :865125268   Median :20.00                                2Q3    : 0   Median : 1.650  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q4    : 0   Mean   : 2.363  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q5    : 0   3rd Qu.: 3.025  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The gestures were easy to learn
t_Q3 <- subset(QSNO, Question=="2Q3")
summary(t_Q3)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q3    :38   Min.   : 2.200  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q1    : 0   1st Qu.: 7.350  
# Median :26.50   Median :865125268   Median :20.00                                2Q2    : 0   Median : 8.300  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q4    : 0   Mean   : 8.005  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q5    : 0   3rd Qu.: 9.400  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The gestures were not easy to learn
t_Q4 <- subset(QSNO, Question=="2Q4")
summary(t_Q4)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q4    :38   Min.   :0.000  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q1    : 0   1st Qu.:0.400  
# Median :26.50   Median :865125268   Median :20.00                                2Q2    : 0   Median :1.250  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q3    : 0   Mean   :1.637  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q5    : 0   3rd Qu.:1.800  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q6    : 0   Max.   :7.400  
# (Other): 0                  

#The gestures were easy to perform
t_Q5 <- subset(QSNO, Question=="2Q5")
summary(t_Q5)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q5    :38   Min.   : 1.300  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q1    : 0   1st Qu.: 6.500  
# Median :26.50   Median :865125268   Median :20.00                                2Q2    : 0   Median : 7.600  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q3    : 0   Mean   : 7.418  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q4    : 0   3rd Qu.: 9.450  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The gestures were not easy to perform
t_Q6 <- subset(QSNO, Question=="2Q6")
summary(t_Q6)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f:10   l: 3   control  :19   2Q6    :38   Min.   :0.000  
# 1st Qu.:16.25   1st Qu.:829022737   1st Qu.:19.00   m:28   r:35   glissando:19   2Q1    : 0   1st Qu.:0.425  
# Median :26.50   Median :865125268   Median :20.00                                2Q2    : 0   Median :1.450  
# Mean   :26.66   Mean   :845993536   Mean   :21.66                                2Q3    : 0   Mean   :2.055  
# 3rd Qu.:35.75   3rd Qu.:902004714   3rd Qu.:22.50                                2Q4    : 0   3rd Qu.:3.350  
# Max.   :48.00   Max.   :912041542   Max.   :40.00                                2Q5    : 0   Max.   :7.500  
# (Other): 0                  


#If this app existed, I would use it to help me learn motion gestures
GQ13 <- subset(QSNO, Question=="Q13" & Condition == "glissando")
summary(GQ13)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 7.00   Min.   :828221945   Min.   :18.00   f: 6   l: 1   control  : 0   Q13    :18   Min.   : 0.700  
# 1st Qu.:17.50   1st Qu.:829026306   1st Qu.:19.00   m:12   r:17   glissando:18   2Q1    : 0   1st Qu.: 5.562  
# Median :26.00   Median :865124518   Median :20.00                                2Q2    : 0   Median : 6.350  
# Mean   :26.56   Mean   :865869142   Mean   :21.56                                2Q3    : 0   Mean   : 6.461  
# 3rd Qu.:34.50   3rd Qu.:902004214   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.: 7.450  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   
CQ13 <- subset(QSNO, Question=="Q13" & Condition == "control")
summary(CQ13)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   Q13    :19   Min.   : 0.200  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.: 2.025  
# Median :28.00   Median :901213006   Median :19.00                                2Q2    : 0   Median : 4.100  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q3    : 0   Mean   : 4.797  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q4    : 0   3rd Qu.: 8.000  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q5    : 0   Max.   :10.000  
# (Other): 0                   

#The training session helped me learn the gestures
Gt_Q1 <- subset(QSNO, Question=="2Q1" & Condition == "glissando")
summary(Gt_Q1)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q1    :19   Min.   :3.200  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q2    : 0   1st Qu.:6.200  
# Median :25.00   Median :829043832   Median :20.00                                2Q3    : 0   Median :7.700  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q4    : 0   Mean   :7.337  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q5    : 0   3rd Qu.:9.000  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q6    : 0   Max.   :9.900  
# (Other): 0                  
Ct_Q1 <- subset(QSNO, Question=="2Q1" & Condition == "control")
summary(Ct_Q1)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q1    :19   Min.   : 0.000  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q2    : 0   1st Qu.: 6.650  
# Median :28.00   Median :901213006   Median :19.00                                2Q3    : 0   Median : 8.000  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q4    : 0   Mean   : 7.242  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q5    : 0   3rd Qu.: 9.550  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   


#The training session did not help me learn the gestures
Gt_Q2 <- subset(QSNO, Question=="2Q2" & Condition == "glissando")
summary(Gt_Q2)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q2    :19   Min.   :0.100  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q1    : 0   1st Qu.:0.550  
# Median :25.00   Median :829043832   Median :20.00                                2Q3    : 0   Median :1.400  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q4    : 0   Mean   :2.226  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q5    : 0   3rd Qu.:2.700  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q6    : 0   Max.   :7.900  
# (Other): 0                  
Ct_Q2 <- subset(QSNO, Question=="2Q2" & Condition == "control")
summary(Ct_Q2)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q2    :19   Min.   : 0.00  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.: 0.40  
# Median :28.00   Median :901213006   Median :19.00                                2Q3    : 0   Median : 2.00  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q4    : 0   Mean   : 2.50  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q5    : 0   3rd Qu.: 2.85  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q6    : 0   Max.   :10.00  
# (Other): 0                  

#The gestures were easy to learn
Gt_Q3 <- subset(QSNO, Question=="2Q3" & Condition == "glissando")
summary(Gt_Q3)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q3    :19   Min.   :2.200  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q1    : 0   1st Qu.:8.000  
# Median :25.00   Median :829043832   Median :20.00                                2Q2    : 0   Median :8.400  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q4    : 0   Mean   :8.026  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q5    : 0   3rd Qu.:9.300  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q6    : 0   Max.   :9.600  
# (Other): 0                  
Ct_Q3 <- subset(QSNO, Question=="2Q3" & Condition == "control")
summary(Ct_Q3)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q3    :19   Min.   : 3.200  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.: 7.200  
# Median :28.00   Median :901213006   Median :19.00                                2Q2    : 0   Median : 8.000  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q4    : 0   Mean   : 7.984  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q5    : 0   3rd Qu.: 9.750  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The gestures were not easy to learn
Gt_Q4 <- subset(QSNO, Question=="2Q4" & Condition == "glissando")
summary(Gt_Q4)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q4    :19   Min.   :0.000  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q1    : 0   1st Qu.:0.600  
# Median :25.00   Median :829043832   Median :20.00                                2Q2    : 0   Median :1.200  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q3    : 0   Mean   :1.595  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q5    : 0   3rd Qu.:1.700  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q6    : 0   Max.   :7.000  
# (Other): 0                  
Ct_Q4 <- subset(QSNO, Question=="2Q4" & Condition == "control")
summary(Ct_Q4)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q4    :19   Min.   :0.000  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.:0.300  
# Median :28.00   Median :901213006   Median :19.00                                2Q2    : 0   Median :1.300  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q3    : 0   Mean   :1.679  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q5    : 0   3rd Qu.:1.850  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q6    : 0   Max.   :7.400  
# (Other): 0                  


#The gestures were easy to perform
Gt_Q5 <- subset(QSNO, Question=="2Q5" & Condition == "glissando")
summary(Gt_Q5)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q5    :19   Min.   :2.000  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q1    : 0   1st Qu.:6.800  
# Median :25.00   Median :829043832   Median :20.00                                2Q2    : 0   Median :7.600  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q3    : 0   Mean   :7.721  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.:9.550  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q6    : 0   Max.   :9.900  
# (Other): 0                  
Ct_Q5 <- subset(QSNO, Question=="2Q5" & Condition == "control")
summary(Ct_Q5)
# NID             PID                 Age        Gender Hand       Condition     Question     Response     
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q5    :19   Min.   : 1.300  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.: 6.450  
# Median :28.00   Median :901213006   Median :19.00                                2Q2    : 0   Median : 7.600  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q3    : 0   Mean   : 7.116  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q4    : 0   3rd Qu.: 9.000  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q6    : 0   Max.   :10.000  
# (Other): 0                   

#The gestures were not easy to perform
Gt_Q6 <- subset(QSNO, Question=="2Q6" & Condition == "glissando")
summary(Gt_Q6)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 7.00   Min.   : 82902156   Min.   :18.00   f: 6   l: 1   control  : 0   2Q6    :19   Min.   :0.100  
# 1st Qu.:16.00   1st Qu.:829022848   1st Qu.:19.00   m:13   r:18   glissando:19   2Q1    : 0   1st Qu.:0.400  
# Median :25.00   Median :829043832   Median :20.00                                2Q2    : 0   Median :0.900  
# Mean   :25.74   Mean   :824660353   Mean   :21.53                                2Q3    : 0   Mean   :1.632  
# 3rd Qu.:34.00   3rd Qu.:902003284   3rd Qu.:21.00                                2Q4    : 0   3rd Qu.:2.250  
# Max.   :48.00   Max.   :912041542   Max.   :37.00                                2Q5    : 0   Max.   :7.100  
# (Other): 0                  
Ct_Q6 <- subset(QSNO, Question=="2Q6" & Condition == "control")
summary(Ct_Q6)
# NID             PID                 Age        Gender Hand       Condition     Question     Response    
# Min.   : 8.00   Min.   :828224215   Min.   :18.00   f: 4   l: 2   control  :19   2Q6    :19   Min.   :0.000  
# 1st Qu.:18.00   1st Qu.:829026770   1st Qu.:19.00   m:15   r:17   glissando: 0   2Q1    : 0   1st Qu.:0.500  
# Median :28.00   Median :901213006   Median :19.00                                2Q2    : 0   Median :1.900  
# Mean   :27.58   Mean   :867326719   Mean   :21.79                                2Q3    : 0   Mean   :2.479  
# 3rd Qu.:37.00   3rd Qu.:902007883   3rd Qu.:23.50                                2Q4    : 0   3rd Qu.:3.650  
# Max.   :47.00   Max.   :902235621   Max.   :40.00                                2Q5    : 0   Max.   :7.500  
# (Other): 0                  








summary(QSNO)
# PID                 Age       Gender Hand       Condition        Q1               Q2              Q3       
# Min.   :828221945   Min.   :18.0   f: 9   l: 4   control  :19   Min.   : 2.800   Min.   :0.000   Min.   :0.000  
# 1st Qu.:829023740   1st Qu.:19.0   m:28   r:33   glissando:18   1st Qu.: 6.350   1st Qu.:0.825   1st Qu.:4.375  
# Median :829045330   Median :20.0                                Median : 7.275   Median :1.400   Median :6.525  
# Mean   :864362280   Mean   :21.7                                Mean   : 6.733   Mean   :2.189   Mean   :5.503  
# 3rd Qu.:902003427   3rd Qu.:23.0                                3rd Qu.: 7.800   3rd Qu.:3.000   3rd Qu.:7.475  
# Max.   :902035725   Max.   :40.0                                Max.   :10.000   Max.   :7.800   Max.   :9.000  
# NA's   :19       NA's   :19      NA's   :19     
#        Q4               Q5               Q6              Q7               Q8              Q9              Q10       
#  Min.   : 0.000   Min.   : 1.100   Min.   :0.000   Min.   : 0.200   Min.   :0.000   Min.   : 0.100   Min.   :0.000  
#  1st Qu.: 1.000   1st Qu.: 3.175   1st Qu.:1.025   1st Qu.: 8.000   1st Qu.:0.200   1st Qu.: 5.800   1st Qu.:0.400  
#  Median : 2.950   Median : 6.150   Median :3.000   Median : 9.000   Median :0.700   Median : 7.400   Median :1.100  
#  Mean   : 3.792   Mean   : 6.014   Mean   :3.628   Mean   : 8.216   Mean   :1.368   Mean   : 7.228   Mean   :2.205  
#  3rd Qu.: 6.588   3rd Qu.: 8.500   3rd Qu.:6.150   3rd Qu.: 9.800   3rd Qu.:1.800   3rd Qu.: 9.300   3rd Qu.:3.700  
#  Max.   :10.000   Max.   :10.000   Max.   :8.800   Max.   :10.000   Max.   :7.150   Max.   :10.000   Max.   :9.600  
#  NA's   :19       NA's   :19       NA's   :19                                                                       
# Q11              Q12             Q13        
# Min.   : 0.900   Min.   :0.000   Min.   : 0.200  
# 1st Qu.: 7.800   1st Qu.:0.200   1st Qu.: 4.000  
# Median : 9.300   Median :0.500   Median : 5.750  
# Mean   : 8.322   Mean   :1.565   Mean   : 5.447  
# 3rd Qu.: 9.600   3rd Qu.:1.500   3rd Qu.: 7.500  
# Max.   :10.000   Max.   :8.700   Max.   :10.000  

summary(ALL713)
# PID                 Age       Gender Hand       Condition        Q7               Q8              Q9        
# Min.   :828221945   Min.   :18.0   f: 9   l: 4   control  :19   Min.   : 0.200   Min.   :0.000   Min.   : 0.100  
# 1st Qu.:829023740   1st Qu.:19.0   m:28   r:33   glissando:18   1st Qu.: 8.000   1st Qu.:0.200   1st Qu.: 5.800  
# Median :829045330   Median :20.0                                Median : 9.000   Median :0.700   Median : 7.400  
# Mean   :864362280   Mean   :21.7                                Mean   : 8.216   Mean   :1.368   Mean   : 7.228  
# 3rd Qu.:902003427   3rd Qu.:23.0                                3rd Qu.: 9.800   3rd Qu.:1.800   3rd Qu.: 9.300  
# Max.   :902035725   Max.   :40.0                                Max.   :10.000   Max.   :7.150   Max.   :10.000  
# Q10             Q11              Q12             Q13        
# Min.   :0.000   Min.   : 0.900   Min.   :0.000   Min.   : 0.200  
# 1st Qu.:0.400   1st Qu.: 7.800   1st Qu.:0.200   1st Qu.: 4.000  
# Median :1.100   Median : 9.300   Median :0.500   Median : 5.750  
# Mean   :2.205   Mean   : 8.322   Mean   :1.565   Mean   : 5.447  
# 3rd Qu.:3.700   3rd Qu.: 9.600   3rd Qu.:1.500   3rd Qu.: 7.500  
# Max.   :9.600   Max.   :10.000   Max.   :8.700   Max.   :10.000  

summary(GLISS113)
# PID                 Age       Gender Hand       Condition    Feedback        Q1               Q2       
# Min.   :828221945   Min.   :18.0   f:10   l: 4   glissando:36   audio :18   Min.   : 2.800   Min.   :0.000  
# 1st Qu.:829024939   1st Qu.:19.0   m:26   r:32                  visual:18   1st Qu.: 7.213   1st Qu.:0.200  
# Median :865124518   Median :20.0                                            Median : 8.200   Median :0.800  
# Mean   :865300476   Mean   :21.5                                            Mean   : 7.851   Mean   :1.592  
# 3rd Qu.:902005143   3rd Qu.:21.0                                            3rd Qu.: 9.425   3rd Qu.:2.250  
# Max.   :902034643   Max.   :37.0                                            Max.   :10.000   Max.   :7.800  
# Q3               Q4               Q5               Q6       
# Min.   : 0.000   Min.   : 0.000   Min.   : 0.900   Min.   :0.000  
# 1st Qu.: 5.500   1st Qu.: 0.200   1st Qu.: 5.825   1st Qu.:0.200  
# Median : 7.400   Median : 1.650   Median : 8.400   Median :1.300  
# Mean   : 6.685   Mean   : 2.733   Mean   : 7.192   Mean   :2.539  
# 3rd Qu.: 9.000   3rd Qu.: 4.075   3rd Qu.: 9.512   3rd Qu.:4.800  
# Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :8.800 

summary(QSNO_VERT)
# Participant            Condition      Question       Answer     
# Min.   :828221945   control  :133   Q10    : 37   Min.   : 0.00  
# 1st Qu.:829023740   glissando:234   Q11    : 37   1st Qu.: 1.10  
# Median :829045330                   Q12    : 37   Median : 5.00  
# Mean   :864638370                   Q13    : 37   Mean   : 4.83  
# 3rd Qu.:902005143                   Q7     : 37   3rd Qu.: 8.20  
# Max.   :902035725                   Q8     : 37   Max.   :10.00  
# (Other):145                  

levels(QSNO_VERT$Question)
# [1] "Q1"  "Q10" "Q11" "Q12" "Q13" "Q2"  "Q3"  "Q4"  "Q5"  "Q6"  "Q7"  "Q8"  "Q9" 

fit = aov(Answer ~ Question, data = QSNO_VERT)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)    
# Question     12   2465  205.40   32.87 <2e-16 ***
#   Residuals   354   2212    6.25                   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Answer ~ Question, data = QSNO_VERT)
# 
# $Question
# diff        lwr         upr     p adj
# Q10-Q1  -4.52792793 -6.9242263 -2.13162953 0.0000001
# Q11-Q1   1.58828829 -0.8080101  3.98458669 0.5839038
# Q12-Q1  -5.16846847 -7.5647669 -2.77217007 0.0000000
# Q13-Q1  -1.28603604 -3.6823344  1.11026237 0.8535516
# Q2-Q1   -4.54444444 -7.3240003 -1.76488854 0.0000071
# Q3-Q1   -1.23055556 -4.0101115  1.54900035 0.9603843
# Q4-Q1   -2.94166667 -5.7212226 -0.16211076 0.0270652
# Q5-Q1   -0.71944444 -3.4990003  2.06011146 0.9997055
# Q6-Q1   -3.10555556 -5.8851115 -0.32599965 0.0138721
# Q7-Q1    1.48288288 -0.9134155  3.87918128 0.6890592
# Q8-Q1   -5.36576577 -7.7620642 -2.96946736 0.0000000
# Q9-Q1    0.49504505 -1.9012534  2.89134345 0.9999732
# Q11-Q10  6.11621622  4.1775154  8.05491708 0.0000000
# Q12-Q10 -0.64054054 -2.5792414  1.29816032 0.9967273
# Q13-Q10  3.24189189  1.3031910  5.18059276 0.0000037
# Q2-Q10  -0.01651652 -2.4128149  2.37978189 1.0000000
# Q3-Q10   3.29737237  0.9010740  5.69367077 0.0004463
# Q4-Q10   1.58626126 -0.8100371  3.98255966 0.5859714
# Q5-Q10   3.80848348  1.4121851  6.20478189 0.0000154
# Q6-Q10   1.42237237 -0.9739260  3.81867077 0.7453819
# Q7-Q10   6.01081081  4.0721099  7.94951167 0.0000000
# Q8-Q10  -0.83783784 -2.7765387  1.10086303 0.9670643
# Q9-Q10   5.02297297  3.0842721  6.96167384 0.0000000
# Q12-Q11 -6.75675676 -8.6954576 -4.81805589 0.0000000
# Q13-Q11 -2.87432432 -4.8130252 -0.93562346 0.0000877
# Q2-Q11  -6.13273273 -8.5290311 -3.73643433 0.0000000
# Q3-Q11  -2.81884384 -5.2151422 -0.42254544 0.0067882
# Q4-Q11  -4.52995495 -6.9262534 -2.13365655 0.0000001
# Q5-Q11  -2.30773273 -4.7040311  0.08856567 0.0718945
# Q6-Q11  -4.69384384 -7.0901422 -2.29754544 0.0000000
# Q7-Q11  -0.10540541 -2.0441063  1.83329546 1.0000000
# Q8-Q11  -6.95405405 -8.8927549 -5.01535319 0.0000000
# Q9-Q11  -1.09324324 -3.0319441  0.84545762 0.8054994
# Q13-Q12  3.88243243  1.9437316  5.82113330 0.0000000
# Q2-Q12   0.62402402 -1.7722744  3.02032243 0.9996865
# Q3-Q12   3.93791291  1.5416145  6.33421131 0.0000061
# Q4-Q12   2.22680180 -0.1694966  4.62310020 0.0983688
# Q5-Q12   4.44902402  2.0527256  6.84532243 0.0000001
# Q6-Q12   2.06291291 -0.3333855  4.45921131 0.1754016
# Q7-Q12   6.65135135  4.7126505  8.59005222 0.0000000
# Q8-Q12  -0.19729730 -2.1359982  1.74140357 1.0000000
# Q9-Q12   5.66351351  3.7248126  7.60221438 0.0000000
# Q2-Q13  -3.25840841 -5.6547068 -0.86211001 0.0005663
# Q3-Q13   0.05548048 -2.3408179  2.45177888 1.0000000
# Q4-Q13  -1.65563063 -4.0519290  0.74066777 0.5151332
# Q5-Q13   0.56659159 -1.8297068  2.96288999 0.9998856
# Q6-Q13  -1.81951952 -4.2158179  0.57677888 0.3562861
# Q7-Q13   2.76891892  0.8302181  4.70761978 0.0002040
# Q8-Q13  -4.07972973 -6.0184306 -2.14102887 0.0000000
# Q9-Q13   1.78108108 -0.1576198  3.71978194 0.1081076
# Q3-Q2    3.31388889  0.5343330  6.09344479 0.0055581
# Q4-Q2    1.60277778 -1.1767781  4.38233368 0.7806216
# Q5-Q2    3.82500000  1.0454441  6.60455590 0.0004457
# Q6-Q2    1.43888889 -1.3406670  4.21844479 0.8825836
# Q7-Q2    6.02732733  3.6310289  8.42362573 0.0000000
# Q8-Q2   -0.82132132 -3.2176197  1.57497708 0.9954033
# Q9-Q2    5.03948949  2.6431911  7.43578789 0.0000000
# Q4-Q3   -1.71111111 -4.4906670  1.06844479 0.6964479
# Q5-Q3    0.51111111 -2.2684448  3.29066702 0.9999926
# Q6-Q3   -1.87500000 -4.6545559  0.90455590 0.5551088
# Q7-Q3    2.71343844  0.3171400  5.10973684 0.0116091
# Q8-Q3   -4.13521021 -6.5315086 -1.73891181 0.0000014
# Q9-Q3    1.72560060 -0.6706978  4.12189900 0.4449744
# Q5-Q4    2.22222222 -0.5573337  5.00177813 0.2752750
# Q6-Q4   -0.16388889 -2.9434448  2.61566702 1.0000000
# Q7-Q4    4.42454955  2.0282511  6.82084795 0.0000002
# Q8-Q4   -2.42409910 -4.8203975 -0.02780070 0.0444261
# Q9-Q4    3.43671171  1.0404133  5.83301011 0.0001863
# Q6-Q5   -2.38611111 -5.1656670  0.39344479 0.1787763
# Q7-Q5    2.20232733 -0.1939711  4.59862573 0.1077679
# Q8-Q5   -4.64632132 -7.0426197 -2.25002292 0.0000000
# Q9-Q5    1.21448949 -1.1818089  3.61078789 0.8974309
# Q7-Q6    4.58843844  2.1921400  6.98473684 0.0000000
# Q8-Q6   -2.26021021 -4.6565086  0.13608819 0.0866147
# Q9-Q6    3.60060060  1.2043022  5.99689900 0.0000639
# Q8-Q7   -6.84864865 -8.7873495 -4.90994778 0.0000000
# Q9-Q7   -0.98783784 -2.9265387  0.95086303 0.8938310
# Q9-Q8    5.86081081  3.9221099  7.79951167 0.0000000

levels(QSNO_VERT$Condition)
#[1] "control"   "glissando"

fit = aov(Q7 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)  
# Condition    1  19.89  19.887   4.486 0.0414 *
#   Residuals   35 155.17   4.433                 
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q7 ~ Condition, data = QSNO)
# 
# $Condition
# diff        lwr      upr     p adj
# glissando-control 1.466813 0.06084925 2.872776 0.0413528

fit = aov(Q8 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1   4.88   4.880   1.741  0.196
# Residuals   35  98.13   2.804               
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q8 ~ Condition, data = QSNO)
# 
# $Condition
# diff       lwr       upr     p adj
# glissando-control -0.7266082 -1.844668 0.3914516 0.1956241

fit = aov(Q9 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1  14.28  14.281   2.093  0.157
# Residuals   35 238.86   6.825               
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q9 ~ Condition, data = QSNO)
# 
# $Condition
# diff        lwr      upr     p adj
# glissando-control 1.242982 -0.5014184 2.987383 0.1569159
# 

fit = aov(Q10 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1   9.86   9.861   1.856  0.182
# Residuals   35 185.97   5.314  

TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q10 ~ Condition, data = QSNO)
# 
# $Condition
# diff       lwr       upr     p adj
# glissando-control -1.032895 -2.572103 0.5063134 0.1818014

fit = aov(Q11 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1   0.08   0.080   0.015  0.903
# Residuals   35 186.57   5.331               
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q11 ~ Condition, data = QSNO)
# 
# $Condition
# diff      lwr      upr     p adj
# glissando-control 0.09312865 -1.44854 1.634797 0.9030983

fit = aov(Q12 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1   0.46   0.462   0.081  0.778
# Residuals   35 200.35   5.724               
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q12 ~ Condition, data = QSNO)
# 
# $Condition
# diff      lwr      upr     p adj
# glissando-control -0.2236842 -1.82127 1.373901 0.7778988

fit = aov(Q13 ~ Condition, data=QSNO)
summary(fit)
# Df Sum Sq Mean Sq F value Pr(>F)
# Condition    1  14.43  14.429   1.871   0.18
# Residuals   35 269.87   7.711               
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q13 ~ Condition, data = QSNO)
# 
# $Condition
# diff      lwr     upr     p adj
# glissando-control 1.249415 -0.60476 3.10359 0.1800422

t.test(Response~Condition, data=t_Q1)
# 
# Welch Two Sample t-test
# 
# data:  Response by Condition
# t = -0.1173, df = 33.283, p-value = 0.9073
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -1.736884  1.547410
# sample estimates:
#   mean in group control mean in group glissando 
# 7.242105                7.336842 
# 
t.test(Response~Condition, data=t_Q3)
# 
# Welch Two Sample t-test
# 
# data:  Response by Condition
# t = -0.0703, df = 35.959, p-value = 0.9444
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -1.257339  1.173128
# sample estimates:
#   mean in group control mean in group glissando 
# 7.984211                8.026316 
# 
t.test(Response~Condition, data=t_Q5)
# 
# Welch Two Sample t-test
# 
# data:  Response by Condition
# t = -0.7864, df = 34.837, p-value = 0.437
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -2.1680328  0.9575065
# sample estimates:
#   mean in group control mean in group glissando 
# 7.115789                7.721053 

