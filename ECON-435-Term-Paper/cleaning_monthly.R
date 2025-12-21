library(tidyverse)

raw_data <-
  read_csv("data/raw/Monthly_Transportation_Statistics.csv")
raw_data$Date <- as_datetime(raw_data$Date)

# 137, 138, 2, 41, 42, 47, 9, 10, 11, 92, 97, 98

key_vars <- raw_data |> select(
  "Date",
  "State and Local Government Construction Spending - Mass Transit",
  "State and Local Government Construction Spending - Land Passenger Terminal",
  "State and Local Government Construction Spending - Transportation",
  "Transit Ridership - Other Transit Modes - Adjusted",
  "Transit Ridership - Fixed Route Bus - Adjusted",
  "Transit Ridership - Urban Rail - Adjusted",
  "Transportation Employment - Transit and ground passenger transportation",
  "Unemployment Rate - Seasonally Adjusted"
) |> filter(Date > "2004-12-01") |> slice_head(n = -3)

covid_start <- as.Date("2020-03-01")
covid_end <- as.Date("2023-05-01")

key_vars$covid <- ifelse(key_vars$Date >= covid_start &
                           key_vars$Date <= covid_end, 1, 0)

key_vars$`Unemployment Rate - Seasonally Adjusted` <-
  as.numeric(sub("%", "", key_vars$`Unemployment Rate - Seasonally Adjusted`)) / 100

write_csv(key_vars,
          "data/intermediate/transport_data_intermediate.csv")
