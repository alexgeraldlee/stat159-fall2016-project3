library(glmnet)  

#read data
edu = read.csv('data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

grid = 10^seq(10, -2, length=100)

set.seed(159)

#fit model
lasso = cv.glmnet(as.matrix(edu[,c(1:32)]), as.matrix(edu[,33]), intercept = FALSE, 
                   standardize = FALSE, lambda = grid, alpha = 1)

lasso$glmnet.fit$beta[,which(lasso$lambda == lasso$lambda.min)]

#save data
save(lasso, file = '../data/lasso.RData')

#plot
pdf("images/lasso.pdf")
plot(lasso)
dev.off()
