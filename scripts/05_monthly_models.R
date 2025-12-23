library(tidyverse)
library(sandwich)
library(lmtest)

df <- read_csv("data/processed/ld_transport_monthly.csv")

mod1 <-
  lm(ld_unemployment ~ ld_MassTransit + ld_LandPassTerm + ld_Transport + covid,
     data = df)

mod2 <-
  lm(
    ld_unemployment ~ ld_MassTransit + ld_LandPassTerm + ld_Transport +
      ld_OthTransMod + ld_Bus + ld_Rail + covid,
    data = df
  )

mod3 <-
  lm(
    ld_unemployment ~ ld_MassTransit + ld_LandPassTerm + ld_Transport +
      ld_OthTransMod + ld_Bus + ld_Rail + ld_TransEmply + covid,
    data = df
  )

# saveRDS(mod1, "models/monthly_mod1.rds")
# saveRDS(mod2, "models/monthly_mod2.rds")
# saveRDS(mod3, "models/monthly_mod3.rds")

RobSE_mod1 <-
  coeftest(mod1, vcov. = NeweyWest(mod1, lag = 4, adjust = TRUE))
RobSE_mod2 <-
  coeftest(mod2, vcov. = NeweyWest(mod2, lag = 4, adjust = TRUE))
RobSE_mod3 <-
  coeftest(mod3, vcov. = NeweyWest(mod3, lag = 4, adjust = TRUE))

# saveRDS(RobSE_mod1, "models/monthly_mod1_robust.rds")
# saveRDS(RobSE_mod2, "models/monthly_mod2_robust.rds")
# saveRDS(RobSE_mod3, "models/monthly_mod3_robust.rds")
