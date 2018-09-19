library(readr)
library(tidyverse)

CareNeeds <- read_csv("data/CareNeeds_200708to201112_GENdata.csv")

CareNeeds <- bind_rows(CareNeeds,
                       read_csv("data/CareNeeds_201213to201617_GENdata.csv"))

CareNeeds$ADL <- ordered(CareNeeds$ADL, c('H','M','L','N'))
CareNeeds$BEH <- ordered(CareNeeds$BEH, c('H','M','L','N'))
CareNeeds$CHC <- ordered(CareNeeds$CHC, c('H','M','L','N'))


Output_ADL <- CareNeeds %>% 
  group_by(YEAR, ADL) %>% 
  tally() %>%
  spread(key = YEAR, value = n) %>% 
  mutate(Domain = "ADL")
  
Output_BEH <- CareNeeds %>% 
  group_by(YEAR, BEH) %>% 
  tally() %>%
  spread(key = YEAR, value = n) %>% 
  mutate(Domain = "BEH")

Output_CHC <- CareNeeds %>% 
  group_by(YEAR, CHC) %>% 
  tally() %>%
  spread(key = YEAR, value = n) %>% 
  mutate(Domain = "CHC")

Output <- bind_rows(Output_ADL, Output_BEH, Output_CHC)

openxlsx::write.xlsx(Output,"data/ACFI_output.xlsx")
