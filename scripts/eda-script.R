#Read in data
scorecard=read.csv("data/final.csv")[,-c(1)]

sink("data/eda.txt")
#Summary of Quantitative Variables"

#Mean
sapply(scorecard, mean, na.rm=TRUE)

#SD
sapply(scorecard, sd, na.rm=TRUE)

#Mean, Median, 1st and 3rd Quartile, Min, Max
sapply(scorecard, summary, na.rm=TRUE)

#Range
sapply(scorecard, range, na.rm=TRUE)

#IQR
sapply(scorecard, IQR, na.rm=TRUE)

#Matrix of Correlations for Quantitative Variables
as.matrix(cor(scorecard))

#ANOVA between Earning and other quantitative variables
for (i in 1:(ncol(scorecard)-1)) {
  print(names(scorecard)[i])
  print(summary(aov(Earning~scorecard[,i], data=scorecard)))
}

sink()

#Boxplots

for (i in 1:(ncol(scorecard)-1)) {
pdf(paste("images/boxplots/", names(scorecard[i]), "_boxplot.pdf", sep=""))
boxplot(scorecard[,i],
        main=paste(names(scorecard[i]), "Boxplot", sep= " "),
        ylab= paste(names(scorecard[i])))
dev.off()
}

#Histograms

for (i in 1:(ncol(scorecard)-1)) {
  pdf(paste("images/histograms/", names(scorecard[i]), "_histogram.pdf", sep=""))
  hist(scorecard[,i],
          main=paste(names(scorecard[i]), "Histogram", sep= " "),
          xlab= paste(names(scorecard[i])))
  dev.off()
}
