library(tidyverse)

df <- read_csv("data/processed/ld_transport_quarterly.csv")

mod1 <-
  lm(
    ld_unemployment_qtr ~ ld_MassTransit_qtr + ld_Transport_qtr  + ld_LandPassTerm_qtr + covid,
    data = df
  )

mod2 <-
  lm(
    ld_unemployment_qtr ~ ld_MassTransit_qtr + ld_Transport_qtr  + ld_LandPassTerm_qtr +
      ld_bus_qtr + ld_rail_qtr + ld_OtherTransMod_qtr + covid,
    data = df
  )

mod3 <-
  lm(
    ld_unemployment_qtr ~ ld_MassTransit_qtr + ld_Transport_qtr  + ld_LandPassTerm_qtr +
      ld_bus_qtr + ld_rail_qtr + ld_OtherTransMod_qtr + ld_TransEmply_qtr + ld_rgdp + covid,
    data = df
  )

saveRDS(mod1, "models/qtrly_mod1.rds")
saveRDS(mod2, "models/qtrly_mod2.rds")
saveRDS(mod3, "models/qtrly_mod3.rds")
