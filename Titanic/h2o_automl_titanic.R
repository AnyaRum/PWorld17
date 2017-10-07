

# https://www.kaggle.com/c/titanic/data

library(h2o)

h2o.init()

# Import a sample binary outcome train/test set into H2O
#train <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-train.csv")

train <- h2o.importFile("C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\train-pdi-data-prep.csv")

#test <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-test.csv")

test <- h2o.importFile("C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\test-pdi-data-prep.csv")


#head(train)
#summary(train)

#head(test)
#summary(test)

#aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 60)

aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 5)

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
#write.csv(pred.df, file = "C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\pred_h2o_automl_titanic.csv")

#pred.df

#test
#test$PassengerId

#test$ID
#head(test)

#pred.df$predict

#test$

testPassengerId <- as.data.frame(test$PassengerId)
submission<-data.frame(cbind(testPassengerId,pred.df$predict))
colnames(submission)<-c("PassengerId","Survived")


#write.csv(submission,"C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\pred_h2o_automl_with_ID.csv",row.names=T)

write.csv(submission,"C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\predictions_h2o_automl.csv",row.names=F)

#write.csv(submission,"C:\\Users\\cmoreno\\Documents\\GitHub\\PWorld17\\Titanic\\output\\pred_h2o_automl_with_ID_no_Row_name2.csv",row.names=T)


