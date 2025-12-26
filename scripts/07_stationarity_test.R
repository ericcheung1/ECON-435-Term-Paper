library(tidyverse)
library(tseries)

monthly_data <-
  read_csv("data/intermediate/transport_data_intermediate.csv") |>
  select(-c("Date", "covid"))
qtrly_data <-
  read_csv("data/intermediate/transport_data_inter_qtr.csv") |>
  select(-c("qtr", "covid"))
log_diff_monthly_data <-
  read_csv("data/processed/ld_transport_monthly.csv") |>
  select(-c("Date", "covid"))
log_diff_qtrly_data <-
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

adf_results_monthly_data <- adf_test(monthly_data)
adf_results_qtrly_data <- adf_test(drop_na(qtrly_data))
adf_results_log_diff_montly_data <- adf_test(log_diff_monthly_data)
adf_results_log_diff_qtrly_data <- adf_test(log_diff_qtrly_data)

adf_tests <- list(
  "monthly_data" = adf_results_monthly_data,
  "qtrly_data" = adf_results_qtrly_data,
  "log_diff_monthly_data" = adf_results_log_diff_montly_data,
  "log_diff_qtrly_data" = adf_results_log_diff_qtrly_data
)

# saveRDS(adf_tests, "stat_tests/adf_tests.rds")
