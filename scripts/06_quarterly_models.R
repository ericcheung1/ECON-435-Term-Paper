library(tidyverse)
library(sandwich)
library(lmtest)

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

# uncomment to save to directory
# saveRDS(mod1, "models/qtrly_mod1.rds")
# saveRDS(mod2, "models/qtrly_mod2.rds")
# saveRDS(mod3, "models/qtrly_mod3.rds")

RobSE_mod1 <-
  coeftest(mod1, vcov. = NeweyWest(mod1, lag = 4, adjust = TRUE))

RobSE_mod2 <-
  coeftest(mod2, vcov. = NeweyWest(mod2, lag = 4, adjust = TRUE))

RobSE_mod3 <-
  coeftest(mod3, vcov. = NeweyWest(mod3, lag = 4, adjust = TRUE))

# uncomment to save to directory
# saveRDS(RobSE_mod1, "models/qtrly_mod_robust1.rds")
# saveRDS(RobSE_mod2, "models/qtrly_mod_robust2.rds")
# saveRDS(RobSE_mod3, "models/qtrly_mod_robust3.rds")
