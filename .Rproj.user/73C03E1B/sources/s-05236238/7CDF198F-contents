# EXERCISE: PREDICTIVE MODELLING
# CARET: https://topepo.github.io/caret/

# you only need to install packages once
install.packages("caret")
install.packages("mlbench")
install.packages("pROC")
install.packages("ggplot2")
install.packages("randomForest")

# you need to load libraries each time you start R
library(caret)
library(mlbench)
library(pROC)
library(ggplot2)
library(randomForest)


# EXERCISE 1 - LINEAR PREDICTION
data(diamonds)
?diamonds
# narrow down to a couple of important numeric variables
diamonds <- diamonds[-c(2,3,4,8,9,10)]

# explore the shortened diamonds dataset
# visualize variable relationships using scatter plots
# visualize variables using boxplots
# partition the data into training and testing
# try to predict "price" using linear regression
# try to predict "price" using other algorithms (e.g. random forest, neural networks, etc.)
# compare algorithms in terms of key metrics on the test set
# compare training-testing partitioning vs. cross-validation


# EXERCISE 2 - BINARY PREDICTION
data(diamonds)
# narrow down to the two best cuts and remove unnecessary variables
diamonds <- diamonds[diamonds$cut == "Premium" | diamonds$cut == "Ideal", ]
diamonds$cut <- droplevels(diamonds$cut)
diamonds <- diamonds[-c(8,9,10)]

# explore the shortened diamonds dataset
# visualize variable relationships using scatter plots
# visualize variables using boxplots
# partition the data into training and testing
# try to predict "cut" using logistic regression (GLM)
# try to predict "cut" using other algorithms (e.g. random forest, neural networks, SVM, etc.)
# compare algorithms in terms of key metrics on the test set
# compare training-testing partitioning vs. cross-validation



