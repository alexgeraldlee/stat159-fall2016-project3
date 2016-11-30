# use 12-13, 13-14, 14-15 data

# scorecard12_13 <- read.csv('../data/MERGED2012_13_PP.csv')
# 
# scorecard13_14 <- read.csv('../data/MERGED2013_14_PP.csv')

scorecard14_15 <- read.csv('../data/MERGED2014_15_PP.csv')

columns <- c(grep("C150_L4", names(scorecard14_15)), 
             grep("MN_EARN_", names(scorecard14_15)), grep("GT_25K_", names(scorecard14_15)),
             grep("CIP", names(scorecard14_15)))

col_names <- c("INSTNM", "CITY", "STABBR", 
               "ZIP", "HIGHDEG", "CONTROL", "TUITFTE", "SATVR25",
               "SATVR75","SATWR25", "SATWR75", "SATMT25", "SATMT75",
               "ACTEN25", "ACTEN75", "ACTWR25", "ACTWR75", "ACTMT25",
               "ACTMT75", "COSTT4_A", "NPT4_PUB", "NPT4_PRIV", "NPT4_PROG",
               "UGDS", "UGDS_MEN", "UGDS_WOMEN", "UGDS_WHITE", "UGDS_BLACK",
               "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR",
               "UGDS_NRA", "UGDS_UNKN", "MARRIED", "DEPENDENT", "VETERAN",
               "FIRST_GEN", "PCTFLOAN", "PCTPELL", "COSTT4_A", "COSTT4_P",
               "C100_4", "C150_4", "C100_L4")

# scorecard12_13_final <- cbind(scorecard12_13[,col_names], scorecard12_13[,columns])
# scorecard13_14_final <- cbind(scorecard13_14[,col_names], scorecard13_14[,columns])
scorecard14_15_final <- cbind(scorecard14_15[,col_names], scorecard14_15[,columns])

# #SCORECARD12-13
# for(i in 1:nrow(scorecard12_13_final)){
#   for(j in 1:ncol(scorecard12_13_final)){
#     if(scorecard12_13_final[i, j] == "NULL" | scorecard12_13_final[i,j] == "PrivacySuppressed"){
#       scorecard12_13_final[i,j] <- NA
#     }
#   }
# }
# 
# for(i in 1:4){
#   scorecard12_13[,i] <- as.character(scorecard12_13_final[,i])
# }
# scorecard12_13_final$HIGHDEG <- as.factor(scorecard12_13_final$HIGHDEG)
# scorecard12_13_final$CONTROL <- as.factor(scorecard12_13_final$CONTROL)
# for(i in 7:317){
#   scorecard12_13_final[,i] <- as.numeric(as.character(scorecard12_13_final[,i]))
# }
# 
# 
# scaled12_13 <- scale(scorecard12_13_final[7:317], center = T, scale = T)
# scorecard12_13_final <- cbind(scorecard12_13_final[1:7], scaled12_13)
# 
# #SCORECARD13-14
# for(i in 1:nrow(scorecard13_14_final)){
#   for(j in 1:ncol(scorecard13_14_final)){
#     if(scorecard13_14_final[i, j] == "NULL" | scorecard13_14_final[i,j] == "PrivacySuppressed"){
#       scorecard13_14_final[i,j] <- NA
#     }
#   }
# }
# 
# for(i in 1:4){
#   scorecard13_14[,i] <- as.character(scorecard13_14_final[,i])
# }
# scorecard13_14_final$HIGHDEG <- as.factor(scorecard13_14_final$HIGHDEG)
# scorecard13_14_final$CONTROL <- as.factor(scorecard13_14_final$CONTROL)
# for(i in 7:317){
#   scorecard13_14_final[,i] <- as.numeric(as.character(scorecard13_14_final[,i]))
# }
# 
# scaled13_14 <- scale(scorecard13_14_final[7:317], center = T, scale = T)
# scorecard13_14_final <- cbind(scorecard13_14_final[1:7], scaled13_14)

#SCORECARD14-15
for(i in 1:nrow(scorecard14_15_final)){
  for(j in 1:ncol(scorecard14_15_final)){
    if(scorecard14_15_final[i, j] == "NULL" | scorecard14_15_final[i, j] == "PrivacySuppressed"){
      scorecard14_15_final[i,j] <- NA
    }
  }
}

for(i in 1:4){
  scorecard14_15_final[,i] <- as.character(scorecard14_15_final[,i])
}
scorecard14_15_final$HIGHDEG <- as.factor(scorecard14_15_final$HIGHDEG)
scorecard14_15_final$CONTROL <- as.factor(scorecard14_15_final$CONTROL)
for(i in 7:317){
  scorecard14_15_final[,i] <- as.numeric(as.character(scorecard14_15_final[,i]))
}

scaled14_15 <- scale(scorecard14_15_final[7:317], center = T, scale = T)
scaled14_15 <- data.frame(scaled14_15)
scorecard14_15_final <- cbind(scorecard14_15_final[1:6], scaled14_15)



# write.csv(scaled12_13, file = '../data/final-12-13.csv')
# write.csv(scaled13_14, file = '../data/final-13-14.csv')
write.csv(scorecard14_15_final, file = '../data/final-14-15.csv')





#This is used to dummify variables.
#Replace C100_4 with any of the C1X variables

#temp <- model.matrix(C100_4 ~ ., data = scorecard12_13_final)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Variable Selections


# select variables:
#- average net price (NPT4)
#- SAT/ACT scores (obvious column names)
#- number of undergraduate students (UGDS)
#- undergraduate student body by race and gender (UGDS)
#- percentage of Pell Students (PCTPELL)
#- receiving Federal Loans (PCTFLOAN)
#- types of school: Public/Private Nonprofit/ Private For-Profit (CONTROL)
#- type of programs (CIP*)
#- tuition and fees (TUITFTE?) (COSTT4_A / COSTT4_P)
#- Undergraduate Student Demographic for Earnings Cohorts (MARRIED, DEPENDENT, VETERAN, FIRST_GEN)
#- completion rate (C100_4, C150_4, C100_L4, C150_L4_* (* BY RACE))
#   -first-time full-time students only (<50% all college students)
#- mean and median earning (MN_EARN_WNE_P*)
#- threshold earning (GT_25k_p*)
#   -earnings data "include only Title IV-receiving students"
#   - >$25000 - median wage of workers 25-34 with only a high school degree
#- PREDDEG - type of degree institution primarily awards


#graduation rate and earnings after graduation
