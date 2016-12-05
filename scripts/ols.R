set.seed(159)

#read in data
edu = read.csv('data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

#fit model
ols = lm(Earning~., data = edu)
ols_summary = summary(ols)

#save data
save(ols, file = 'data/ols.RData')

#plot
pdf("images/ols.pdf")
par(mfrow=c(2,2))
plot(ols)
dev.off()
