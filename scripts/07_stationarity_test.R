library(tidyverse)
library(tseries)

pre_ld_monthly <-
  read_csv("data/intermediate/transport_data_intermediate.csv") |>
  select(-c("Date", "covid"))
pre_ld_qtrly <-
  read_csv("data/intermediate/transport_data_inter_qtr.csv") |>
  select(-c("qtr", "covid"))
ld_monthly <-
  read_csv("data/processed/ld_transport_monthly.csv") |>
  select(-c("Date", "covid"))
ld_qtrly <-
  read_csv("data/processed/ld_transport_quarterly.csv") |>
  select(-c("Qtr", "covid"))

### adf test for stationarity

adf_test <- function(df) {
  result_list <- list()
  
  for (col_name in names(df)) {
    ts_data <- df[[col_name]]
    results <- adf.test(ts_data)
    result_list[[col_name]] <- results
  }
  
  return(result_list)
}

adf_pldm <- adf_test(pre_ld_monthly)
adf_pldq <- adf_test(drop_na(pre_ld_qtrly))
adf_ldm <- adf_test(ld_monthly)
adf_ldq <- adf_test(ld_qtrly)

adf_tests <- list(
  "pre_ld_monthly" = adf_pldm,
  "pre_ld_qtrly" = adf_pldq,
  "ld_monthly" = adf_ldm,
  "ld_qtrly" = adf_ldq
)

saveRDS(adf_tests, "stat_tests/adf_tests.rds")
