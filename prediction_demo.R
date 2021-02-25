# DEMONSTRATION: PREDICTIVE MODELLING
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

##################################################################
##################################################################
####################### CONTINUOUS OUTCOME #######################
##################################################################
##################################################################

##################################################################
##################################################################
#### BOSTON HOUSING - PREDICTION WITH LINEAR REGRESSION ##########
#################### TRAIN - TEST PARTITIONING ###################
##################################################################
##################################################################

# https://rpubs.com/chocka314/251613

data(BostonHousing)
?BostonHousing
regVar <- c("rm", "lstat", "tax")
str(BostonHousing[, regVar])
BostonHousing$chas <- NULL

featurePlot(x = BostonHousing[, regVar], 
            y = BostonHousing$medv, 
            plot = "scatter", 
            layout = c(3, 1))

# correlations
cor(BostonHousing,BostonHousing$medv)

# DATA PARTITIONING
inTrain <- createDataPartition(y = BostonHousing$medv, p = 0.75, list = FALSE)
training <- BostonHousing[inTrain,]
testing <- BostonHousing[-inTrain,]

# LINEAR MODEL
fit.lm <- lm(medv~.,data = training)
fit.lm
summary(fit.lm)

# PREDICT ON NEW INSTANCES
pred.lm <- predict(fit.lm, newdata = testing)
pred.lm

# Root-mean squared error
rmse.lm <- sqrt(sum((pred.lm - testing$medv)^2)/
                  length(testing$medv))
mae.lm <- mean(abs(pred.lm - testing$medv))

linear.results <- c(MAE = mae.lm, RMSE = rmse.lm, R2 = summary(fit.lm)$r.squared)
linear.results 
summary(BostonHousing$medv)
histogram(BostonHousing$medv)


##################################################################
##################################################################
####### BOSTON HOUSING - PREDICTION WITH RANDOM FOREST ###########
#################### TRAIN - TEST PARTITIONING ###################
##################################################################
##################################################################


# LINEAR MODEL
fit.rf <- randomForest(medv~.,data = training)
fit.rf

# PREDICT ON NEW INSTANCES
pred.rf <- predict(fit.rf, newdata = testing)
pred.rf

# Root-mean squared error
rmse.rf <- sqrt(sum((pred.rf - testing$medv)^2)/
                  length(testing$medv))
mae.rf <- mean(abs(pred.rf - testing$medv))

randomforest.results <- c(MAE = mae.rf, RMSE = rmse.rf, R2 = mean(fit.rf$rsq))
randomforest.results
linear.results


##################################################################
##################################################################
######################### BINARY OUTCOME #########################
##################################################################
##################################################################

##################################################################
##################################################################
########## IRIS - PREDICTION WITH LOGISTIC REGRESSION ############
##################################################################
##################################################################

# PARTITION TO TRAINING AND TEST
data(iris)
?iris
iris <- iris[iris$Species == "virginica" | iris$Species == "versicolor", ]
iris <- iris[-c(3,4)]
iris$Species <- factor(iris$Species)

# VISUALIZATION
ggplot(data=iris,aes(x=Sepal.Width, y=Sepal.Length, color=Species)) + geom_point() + theme_minimal()
#ggplot(data=iris,aes(x=Petal.Width, y=Petal.Length, color=Species)) + geom_point() + theme_minimal()

set.seed(522)
samples <- sample(NROW(iris), NROW(iris) * .5)
data.train <- iris[samples, ]
data.test <- iris[-samples, ]

# TRAIN & TEST, USING LOGISTIC REGRESSION
fitControl <- trainControl(classProbs = TRUE, 
                           summaryFunction = twoClassSummary)
glm.model <- train(Species ~., 
                   data.train,
                   method="glm",
                   trControl = fitControl,
                   metric="ROC")

# TRAIN & TEST, USING RANDOM FOREST
# First train on half of the dataset
forest.model <- train(Species ~., 
                      data.train,
                      trControl = fitControl,
                      method="rf",
                      metric="ROC")
forest.model

# Then predict on test set
result.predicted.prob <- predict(glm.model, data.test, type="prob")
result.predicted.prob

# Draw ROC curve
result.roc <- roc(data.test$Species, result.predicted.prob$versicolor) 
plot(result.roc, print.thres="best", print.thres.best.method="closest.topleft")

ggroc(result.roc, alpha = 0.5, colour = "red", linetype = 1, size = 1) + 
  theme_minimal() + 
  ggtitle("ROC curve - logistic regression") + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), color="grey", linetype="dashed")

result.roc
#result.roc$auc


##################################################################
##################################################################
############### IRIS - PREDICTION WITH RANDOM FOREST #############
#################### TRAIN - TEST PARTITIONING ###################
##################################################################
##################################################################

# PARTITION TO TRAINING AND TEST
data(iris)
iris <- iris[iris$Species == "virginica" | iris$Species == "versicolor", ]
iris$Species <- factor(iris$Species)

# VISUALIZATION
ggplot(data=iris,aes(x=Sepal.Width, y=Sepal.Length, color=Species)) + geom_point() + theme_minimal()
ggplot(data=iris,aes(x=Petal.Width, y=Petal.Length, color=Species)) + geom_point() + theme_minimal()

ggplot(data=iris,aes(x=Sepal.Width,y=Sepal.Length,color=Species)) +geom_density2d()+ theme_minimal()
ggplot(data=iris,aes(x=Petal.Width,y=Petal.Length,color=Species)) +geom_density2d()+ theme_minimal()

ggplot(data=iris,aes(x=Species, y=Petal.Length,color=Species)) + geom_boxplot() +theme_minimal()+
  theme(legend.position="none")


set.seed(722)
samples <- sample(NROW(iris), NROW(iris) * .5)
data.train <- iris[samples, ]
data.test <- iris[-samples, ]

# TRAIN & TEST, USING LOGISTIC REGRESSION
fitControl <- trainControl(classProbs = TRUE, 
                           summaryFunction = twoClassSummary)
glm.model <- train(Species ~., 
                   data.train,
                   method="glm",
                   trControl = fitControl,
                   metric="ROC")
warnings()

# TRAIN & TEST, USING RANDOM FOREST
# First train on half of the dataset
forest.model <- train(Species ~., 
                      data.train,
                      trControl = fitControl,
                      method="rf",
                      metric="ROC")
forest.model

# Then predict on test set
result.predicted.prob <- predict(glm.model, data.test, type="prob")
result.predicted.prob

# Draw ROC curve
result.roc <- roc(data.test$Species, result.predicted.prob$versicolor) 
plot(result.roc, print.thres="best", print.thres.best.method="closest.topleft")

ggroc(result.roc, alpha = 0.5, colour = "red", linetype = 1, size = 1) + 
  theme_minimal() + 
  ggtitle("ROC curve - logistic regression") + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), color="grey", linetype="dashed")

result.roc
#result.roc$auc


##################################################################
##################################################################
############# SONAR - PREDICTION WITH NEURAL NETWORK #############
#################### TRAIN - TEST PARTITIONING ###################
##################################################################
##################################################################


# TRAIN & TEST, USING CROSS-VALIDATION
data(Sonar)
?Sonar

# DEFINE 5-FOLD CROSS-VALIDATION
set.seed(190)
inTraining <- createDataPartition(Sonar$Class, p = .75, list = FALSE)
training <- Sonar[ inTraining,]
testing  <- Sonar[-inTraining,]

fitControl <- trainControl(method = "cv",
                           number = 5,
                           savePredictions = TRUE, 
                           classProbs = TRUE, 
                           verboseIter = TRUE,
                           summaryFunction = twoClassSummary)

# RUN CROSS-VALIDATION
nnet.fit <- train(Class ~ ., data = training, 
                 method = "nnet", 
                 trControl = fitControl,
                 verbose = F,
                 metric= "ROC")
nnet.fit
plot(nnet.fit)  


# PREDICT ON TEST SET
result.predicted.prob <- predict(nnet.fit, testing, type="prob")
result.predicted.prob

# Draw ROC curve
result.roc <- roc(testing$Class, result.predicted.prob$M) 

ggroc(result.roc, alpha = 0.5, colour = "red", linetype = 1, size = 1) + 
  theme_minimal() + 
  ggtitle("ROC curve") + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), color="grey", linetype="dashed")

result.roc



