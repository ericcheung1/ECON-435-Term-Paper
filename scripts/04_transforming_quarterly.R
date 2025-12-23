library(tidyverse)

inter_data <-
  read_csv("data/intermediate/transport_data_inter_qtr.csv")

log_diff_data <-
  inter_data |> mutate(across(!c(qtr, covid), ~ c(NA, diff(log(
    .x
  ))))) |> slice_tail(n = -1) |> slice_head(n = -2)

column_names <- c(
  "Qtr",
  "ld_MassTransit_qtr",
  "ld_Transport_qtr",
  "ld_LandPassTerm_qtr",
  "ld_unemployment_qtr",
  "ld_bus_qtr",
  "ld_rail_qtr",
  "ld_OtherTransMod_qtr",
  "ld_TransEmply_qtr",
  "ld_rgdp",
  "covid"
)

log_diff_data_new_names <- set_names(log_diff_data, column_names)

write_csv(log_diff_data_new_names,
          "data/processed/ld_transport_quarterly.csv")
