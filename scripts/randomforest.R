library(caret)

#read in data
edu = read.csv('data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

set.seed(159)

#create train/test data
train_index = sample(1:1636, 1336)

train = edu[train_index,]
test = edu[-train_index,]

#fit model
fitControl = trainControl(method = "repeatedcv", number = 10)
model.rf = train(Earning ~ ., data = train, method = 'rf', trControl = fitControl)

importance(model.rf$finalModel)

#save data
save(model.rf, file = 'data/randomforest.RData')

#plot
pdf("images/randomforest.pdf")
plot(model.rf)
dev.off()

png("images/randomforest.png")
plot(model.rf)
dev.off()
