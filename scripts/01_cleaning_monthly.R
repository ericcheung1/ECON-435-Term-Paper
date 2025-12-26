library(tidyverse)

raw_data <-
  read_csv("data/raw/Monthly_Transportation_Statistics.csv")
raw_data$Date <- as_datetime(raw_data$Date)

# 137, 138, 2, 41, 42, 47, 9, 10, 11, 92, 97, 98

main_variables <- raw_data |> select(
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

main_variables$covid <- ifelse(main_variables$Date >= covid_start &
                           main_variables$Date <= covid_end, 1, 0)

main_variables$`Unemployment Rate - Seasonally Adjusted` <-
  as.numeric(sub("%", "", main_variables$`Unemployment Rate - Seasonally Adjusted`)) / 100

write_csv(main_variables,
          "data/intermediate/transport_data_intermediate.csv")
