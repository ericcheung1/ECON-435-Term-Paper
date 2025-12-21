library(tidyverse)

inter_data <-
  read_csv("data/intermediate/transport_data_intermediate.csv")

log_diff_data <-
  inter_data |> mutate(across(!c(Date, covid), ~ c(NA, diff(log(
    .x
  ))))) |> slice_tail(n = -1)

column_names <- c(
  "Date",
  "ld_MassTransit",
  "ld_LandPassTerm",
  "ld_Transport",
  "ld_OthTransMod",
  "ld_Bus",
  "ld_Rail",
  "ld_TransEmply",
  "ld_unemployment",
  "covid"
)

log_diff_data_new_names <- set_names(log_diff_data, column_names)

write_csv(log_diff_data_new_names,
          "data/intermediate/ld_transport_monthly.csv")
