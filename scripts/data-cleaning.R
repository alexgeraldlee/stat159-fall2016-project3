# use 12-13, 13-14, 14-15 data

scorecard12_13 <- read.csv('../data/MERGED2012_13_PP.csv')

scorecard13_14 <- read.csv('../data/MERGED2013_14_PP.csv')

scorecard14_15 <- read.csv('../data/MERGED2014_15_PP.csv')

columns <- c(scorecard12_13$INSTNM, "INSTNM", "CITY", "STABBR", 
             "ZIP", "HIGHDEG", "CONTROL", "TUITFTE", "SATVR25",
             "SATVR75","SATWR25", "SATWR75", "SATMT25", "SATMT75",
             "ACTEN25", "ACTEN75", "ACTWR25", "ACTWR75", "ACTMT25",
             "ACTMT75", "COSTT4_A", "NPT4_PUB", "NPT4_PRIV", "NPT4_PROG",
             "UGDS", "UGDS_MEN", "UGDS_WOMEN", "UGDS_WHITE", "UGDS_BLACK",
             "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR",
             "UGDS_NRA", "UGDS_UNKN", "MARRIED", "DEPENDENT", "VETERAN",
             "FIRST_GEN", "PCTFLOAN", "PCTPELL")

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

