library(caret)

edu = read.csv('../data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

train_index = sample(1:1636, 1336)

train = edu[train_index,]
test = edu[-train_index,]

fitControl = trainControl(method = "repeatedcv", number = 10)
model.rf = train(Earning ~ ., data = train, method = 'rf', trControl = fitControl)

importance(model.rf$finalModel)

save(model.rf, file = '../data/randomforest.RData')

