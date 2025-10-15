library(tidyverse)
library(gt)
library(irr)


descriptives <- read_csv("Wingate_data.csv")

modified_descriptives <- descriptives %>% 
  select(FP, Test, Wsnitt) %>% 
  group_by(FP) %>% 
  summarise(Gjennomsnitt = mean(Wsnitt),
            SD = sd(Wsnitt))

modified_descriptives

descriptive_table <- modified_descriptives %>% 
  gt() %>% 
  tab_header(
    title = "Gjennomsnittlig Watt fra økter",
    subtitle = "Presentert med gjennomsnitt og standard avvik (SD)"
  ) %>% 
  fmt_number(
    columns = everything(),
    decimals = 0
  ) %>% 
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  )

descriptive_table


descriptives_wide <- descriptives %>% 
  select(FP,Test, Wsnitt) %>% 
  pivot_wider(names_from = Test, values_from = Wsnitt)

icc_descriptives <- descriptives_wide %>% select(-FP)

head(icc_descriptives)

icc_result <- icc(
  icc_descriptives,
  model = "twoway",
  type = "consistency",
  unit = "average"
)

print(icc_result)

print(descriptives)

ggplot(descriptives, aes(x = factor(Test), y = Wsnitt, group = FP, color = factor(FP))) +
  geom_line(alpha = 0.5) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(
    x = "Test",
    y = "Gjennomsnittlig W",
    title = "Repeterte gjennomsnittlige W-målinger per deltaker",
    color = "Deltaker"
  )
