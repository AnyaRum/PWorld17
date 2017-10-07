

library(h2o)

h2o.init()

# Import a sample binary outcome train/test set into H2O
train <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-train.csv")

test <- h2o.importFile("https://raw.githubusercontent.com/caiomsouza/ml-open-datasets/master/csv-dataset/kaggle-santander-test.csv")


#head(train)
#summary(train)

#head(test)
#summary(test)


aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 60)

lb <- aml@leaderboard 

#lb

#aml

#aml@leader
#aml@project_name


#pred <- h2o.predict(aml, test)  # predict(aml, test) also works

# or:

pred <- h2o.predict(aml@leader, test)
pred.df <- as.data.frame(pred)

setwd("~/GitHub/PWorld17/AutoML/output")


# Write CSV in R
write.csv(pred.df, file = "pred_h2o_automl.csv")

#test$ID
#head(test)

#pred.df$predict

testIds<-as.data.frame(test$ID)

submission<-data.frame(cbind(testIds,pred.df$predict))

colnames(submission)<-c("ID","PredictedProb")

write.csv(submission,"pred_h2o_automl_with_ID.csv",row.names=T)

write.csv(submission,"pred_h2o_automl_with_ID_no_Row_name.csv",row.names=F)



