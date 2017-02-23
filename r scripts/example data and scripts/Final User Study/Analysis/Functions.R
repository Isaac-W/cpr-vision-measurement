#####################
# Libraries
#####################
library(doBy);
library(ggplot2);
library(ez);
#######################
# Functions
######################
ID = function( A, W){
  id = A/W + 1;
  return(log(id,2))
}
IsOutlier = function(trialTime, mean, sd){
  max = mean+sd*3
  min = mean-sd*3
  return(trialTime > max | trialTime < min);
}