# EXERCISE: FAIRNESS EXPLORATION

# you only need to install packages once
install.packages("caret")
install.packages("pROC")
install.packages("ggplot2")
install.packages("fairness")
install.packages("fairmodels")
install.packages("DALEX")
install.packages("ranger")
install.packages("gbm")
install.packages("nnet")

# you need to load libraries each time you start R
library(caret)
library(pROC)
library(ggplot2)
library(fairness) # both fairness packages have a compas dataset!
library(fairmodels) # both fairness packages have a compas dataset!
library(DALEX)
library(ranger)
library(gbm)
library(nnet)

# EXERCISE 1 - COMPAS (RACE, SEX) - CAN YOU DO A BETTER JOB?
compas <- fairness::compas # explicitly define compas data from "fairness" package
# the outcome is the variable named Two_yr_Recidivism
# before you set up you model, make sure to exclude the last two columns
# compas <- compas[-c(8,9)]

# explore the data (correlations, visualization, etc.)
# create data partitions
# set up predictive models with and without sensitive attributes
# what is the best ROC AUC you can achieve (and with what variable set)?
# assess whether your best performing model is fair
# try various bias mitigation techniques to improve fairness
# assess how bias mitigation impacts predictive validity
# try to make an argument for what is the best metric of fairness in the COMPAS data
# are there other sensitive variables in the dataset you can test for?


# EXERCISE 2 - GERMAN CREDIT (SEX) - CAN YOU DO A BETTER JOB?
germancredit <- fairness::germancredit # explicitly define compas data from "fairness" package
# the outcome is the variable named BAD
# before you set up you model, make sure to exclude the last two columns
# germancredit <- germancredit[-c(22,23)]

# explore the data (correlations, visualization, etc.)
# create data partitions
# set up predictive models with and without sensitive attributes
# what is the best ROC AUC you can achieve (and with what variable set)?
# assess whether your best performing model is fair
# try various bias mitigation techniques to improve fairness
# assess how bias mitigation impacts predictive validity
# try to make an argument for what is the best metric of fairness in the COMPAS data
# are there other sensitive variables in the dataset you can test for?











