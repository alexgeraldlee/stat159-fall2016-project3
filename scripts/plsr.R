library(pls)

set.seed(159)

plsr = plsr(Earning~., data = edu, validation ="CV", scale = FALSE,standardize = FALSE)

plsr_coef = plsr$coefficients[,1,which.min(plsr$validation$PRESS)]
plsr_coef

save(plsr, file = '../data/plsr.RData')


