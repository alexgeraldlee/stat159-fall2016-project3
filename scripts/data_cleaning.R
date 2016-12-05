library('dplyr')

edu <- read.csv('https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-All-Data-Elements.csv', stringsAsFactors = FALSE)

col_names <- c("INSTNM", "HIGHDEG", "CONTROL", "TUITFTE", "SATVR25",
               "SATVR75","SATWR25", "SATWR75", "SATMT25", "SATMT75",
               "ACTEN25", "ACTEN75", "ACTWR25", "ACTWR75", "ACTMT25",
               "ACTMT75", "COSTT4_A", "NPT4_PUB", "NPT4_PRIV", "NPT4_PROG",
               "UGDS", "UGDS_MEN", "UGDS_WOMEN", "UGDS_WHITE", "UGDS_BLACK",
               "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR",
               "UGDS_NRA", "UGDS_UNKN", "MARRIED", "DEPENDENT", "VETERAN",
               "FIRST_GEN", "PCTFLOAN", "PCTPELL", "COSTT4_A", "COSTT4_P",
               "C100_4", "C150_4", "C100_L4", 'GT_25K_P10', 'MN_EARN_WNE_P10')

edu = edu[, col_names]

#pick out private colleges
edu = edu[edu$CONTROL == 2,]
edu = edu[, -c(3)]

#change 'NULL' and 'PrivacySuppressed' to 'NA'
for(i in 1:nrow(edu)){
  for(j in 1:ncol(edu)){
    if(edu[i, j] == "NULL" | edu[i,j] == "PrivacySuppressed"){
      edu[i,j] <- NA
    }
  }
}

#number of NAs by columns
na_col = sort(sapply(edu, function(y) sum(length(which(is.na(y))))))
na_col

#delete columns with more than 1500 NAs
del_na_col = names(na_col[36:44])
edu = edu[ , -which(names(edu) %in% del_na_col)]

#number of NAs by rows
rownames(edu) <- seq(length = nrow(edu))
na_row = sort(apply(edu, MARGIN = 1, FUN = function(x) length(x[is.na(x)])))
na_row

#delete rows with more than 27 NAs
del_na_row = names(na_row[1637:1956])
edu = edu[-which(rownames(edu) %in% del_na_row), ]
rownames(edu) <- seq(length = nrow(edu))

#change column name for target variable (MN_EARN_WNE_P10)
colnames(edu)[35] <- "Earning"
collegenames = edu[1]
edu = edu[,-c(1)]

#NA imputation.  Change NAs into -1.
for (i in names(edu)){
  edu[, i] = as.numeric(edu[, i])
  edu[, i][is.na(edu[,i])] = mean(edu[, i][!is.na(edu[, i])])
}

#mean clustering and standardizing
edu = scale(edu, center = TRUE, scale = TRUE)
edu = as.data.frame(edu) 

#exporting cleaned data
write.csv(edu, file = "data/final.csv")
