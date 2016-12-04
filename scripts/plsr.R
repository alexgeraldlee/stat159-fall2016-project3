library(pls)

set.seed(159)

#fit model
plsr = plsr(Earning~., data = edu, validation ="CV", scale = FALSE,standardize = FALSE)

#find coeffs
plsr_coef = plsr$coefficients[,1,which.min(plsr$validation$PRESS)]
plsr_coef

#save data
save(plsr, file = '../data/plsr.RData')

#plot
pdf("~/stat159/stat159-fall2016-project3/images/plsr.pdf")
par(mfrow=c(1,1))
plot(plsr)
dev.off()
