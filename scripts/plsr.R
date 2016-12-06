library(pls)

#read data
edu = read.csv('data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

set.seed(159)

#fit model
plsr = plsr(Earning~., data = edu, validation ="CV", scale = FALSE,standardize = FALSE)

#find coeffs
plsr_coef = plsr$coefficients[,1,which.min(plsr$validation$PRESS)]
plsr_coef

#save data
save(plsr, file = 'data/plsr.RData')

#plot
pdf("images/plsr.pdf")
png("images/plsr.png")
par(mfrow=c(1,1))
plot(plsr)
dev.off()
