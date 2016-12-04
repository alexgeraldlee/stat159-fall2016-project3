set.seed(159)

edu = read.csv('../data/final.csv', stringsAsFactors = FALSE)
edu = edu[, -c(1)]

ols = lm(Earning~., data = edu)
ols_summary = summary(ols)

save(ols, file = '../data/ols.RData')
