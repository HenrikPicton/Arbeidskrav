library(tidyverse)

descriptives <- read_csv("Wingate_data.csv")

modified_descriptives <- descriptives %>% 
  select(FP, Test, Wsnitt) %>% 
  pivot_wider(
    names_from = Test,
    values_from = Wsnitt,
    names_prefix = "Test"
  )

modified_descriptives
