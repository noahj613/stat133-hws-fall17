###############################################################
#Clean Data Script for HW04
#Input: rawscores.csv
#Output: cleanscores.csv
###############################################################

#Loading required packages
library(readr)

#functions
source('./functions.R')

#Reading in raw scores
rawscores <- read_csv("../data/rawdata/rawscores.csv")

#Replacing NA with 0
for(colname in names(rawscores)) {
  rawscores[[colname]][is.na(rawscores[[colname]])] <- 0
}

#Rescaling the quizzes
rawscores$QZ1 <- rescale100(rawscores$QZ1, xmin = 0, xmax = 12)
rawscores$QZ2 <- rescale100(rawscores$QZ2, xmin = 0, xmax = 18)
rawscores$QZ3 <- rescale100(rawscores$QZ3, xmin = 0, xmax = 20)
rawscores$QZ4 <- rescale100(rawscores$QZ4, xmin = 0, xmax = 20)

#Adding test variables and rescaling
rawscores$Test1 <- rescale100(rawscores$EX1, xmin = 0, xmax = 80)
rawscores$Test2 <- rescale100(rawscores$EX2, xmin = 0, xmax = 90)

#Adding homework scores
rawscores$Homework <- score_homework(rawscores[, 1:9])

sink('../output/tests-reporter.txt')
test_file('tests.R')
sink()


sink('../output/summary-cleanscores.txt')
str(rawscores)
sink()

write_csv(rawscores, path = '../data/cleandata/cleanscores.csv')
