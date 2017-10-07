# References
# http://h2o-release.s3.amazonaws.com/h2o/master/3888/docs-website/h2o-docs/automl.html
# https://www.kaggle.com/c/titanic/data


library(h2o)
h2o.init()

# Import a sample binary outcome train/test set into H2O
#train <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-train.csv")
#test <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-test.csv")

# Load Train and Test Dataset
train <- h2o.importFile("C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\train-pdi-data-prep.csv")
test <- h2o.importFile("C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\test-pdi-data-prep.csv")

#head(train)
#summary(train)
#head(test)
#summary(test)

# Identify predictors and response
y <- "TARGET"
x <- setdiff(names(train), y)

# For binary classification, response should be a factor
train[,y] <- as.factor(train[,y])
test[,y] <- as.factor(test[,y])

#aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 60)
#aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 5)

aml <- h2o.automl(y = y, training_frame = train, max_runtime_secs = 60)

lb <- aml@leaderboard 

lb
aml

aml@leader
aml@project_name


#pred <- h2o.predict(aml, test)  # predict(aml, test) also works

# or:

pred <- h2o.predict(aml@leader, test)
pred.df <- as.data.frame(pred)

#setwd("~/GitHub/PWorld17/AutoML/output")


# Write CSV in R
write.csv(pred.df, file = "C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\only-predictions_h2o_automl_titanic.csv")

#pred.df
#test
#test$PassengerId
#test$ID
#head(test)
#pred.df$predict
#test$

#testPassengerId <- as.data.frame(test$PassengerId)
submission<-data.frame(cbind(testPassengerId,pred.df$predict))
colnames(submission)<-c("PassengerId","Survived")


# Write dataset
write.csv(submission,"C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\kaggle-submission-file-h2o_automl-titanic.csv",row.names=F)

###

#test$PassengerId
#testPassengerId <- as.data.frame(test$PassengerId)

submission<-data.frame(cbind(testPassengerId,pred.df))
#submission

colnames(submission)<-c("PassengerId","predict", "p0","p1")


# Write dataset
write.csv(submission,"C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\full-results-predictions-h2o_automl-titanic.csv",row.names=F)



