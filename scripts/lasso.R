library(glmnet)  

edu = read.csv('../data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

grid = 10^seq(10, -2, length=100)

set.seed(159)

lasso = cv.glmnet(as.matrix(edu[,c(1:33)]), as.matrix(edu[,34]), intercept = FALSE, 
                   standardize = FALSE, lambda = grid, alpha = 1)

save(lasso, file = '../data/lasso.RData')