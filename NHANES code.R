
setwd ('~/data ')

library(foreign)
library(tidyverse)

# Year 2017-2020
demo <- read.xport("P_DEMO.XPT")
bmi <-  read.xport("P_BMX.XPT")
hdl <-  read.xport("P_HDL.XPT")
chol <- read.xport("P_TCHOL.XPT")
gly <-  read.xport("P_GHB.XPT")
bp <-   read.xport("P_BPXO.XPT")

#Selecting variables
demo1 <- demo %>% 
  select(SEQN, RIDAGEYR) %>% 
  rename(Age = 'RIDAGEYR')
bmi1 <- bmi %>% 
  rename(BMI = 'BMXBMI') %>% 
  select(SEQN, BMI)
hdl1 <- hdl %>% 
  rename(HDL_cholesterol = 'LBDHDD') %>% 
  select(SEQN, HDL_cholesterol)
chol1 <- chol %>% 
  rename(Total_cholesterol = 'LBXTC') %>% 
  select(SEQN, Total_cholesterol)
gly1 <- gly %>% 
  rename(Glycohemoglobin = 'LBXGH') %>% 
  select(SEQN, Glycohemoglobin)
bp1 <- bp %>% 
  rename(Systolic_blood_pressure = 'BPXOSY1') %>% 
  select(SEQN, Systolic_blood_pressure)

# Merging the datasets
nhanes_data <- demo1 %>%
  left_join(bmi1, by = 'SEQN') %>%
  left_join(hdl1, by = 'SEQN') %>%
  left_join(chol1, by = 'SEQN') %>%
  left_join(gly1, by = 'SEQN') %>%
  left_join(bp1, by = 'SEQN') %>%
    filter (Age >= 18)%>%
    drop_na()

str(nhanes_data)  
summary(nhanes_data) 

# Save Dataset
write_csv(nhanes_data, 'nhanes_data.csv')
  
  
  
  
  