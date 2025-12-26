library(tidyverse)
library(zoo)

raw_data <-
  read_csv("data/raw/Monthly_Transportation_Statistics.csv")
raw_data$Date <- as_datetime(raw_data$Date)

# 2, 41, 42, 47, 9, 10, 11, 92, 100, 97

main_variables <- raw_data |> select(
  "Date",
  "State and Local Government Construction Spending - Mass Transit",
  "State and Local Government Construction Spending - Land Passenger Terminal",
  "State and Local Government Construction Spending - Transportation",
  "Transit Ridership - Other Transit Modes - Adjusted",
  "Transit Ridership - Fixed Route Bus - Adjusted",
  "Transit Ridership - Urban Rail - Adjusted",
  "Transportation Employment - Transit and ground passenger transportation",
  "Real Gross Domestic Product - Seasonally Adjusted",
  "Unemployment Rate - Seasonally Adjusted"
) |> filter(Date > "2004-12-01") |> slice_head(n = -3)

main_variables$`Unemployment Rate - Seasonally Adjusted` <-
  as.numeric(sub("%", "", main_variables$`Unemployment Rate - Seasonally Adjusted`)) / 100

main_variables$`Real Gross Domestic Product - Seasonally Adjusted` <-
  as.numeric(gsub(
    "[$,]",
    "",
    main_variables$`Real Gross Domestic Product - Seasonally Adjusted`
  ))

main_variables$qtr <- as.yearqtr(main_variables$Date)

real_GDP <- main_variables |> select("Date",
                               "Real Gross Domestic Product - Seasonally Adjusted")

real_GDP$qtr <- as.yearqtr(real_GDP$Date)

real_GDP <-
  real_GDP |> select(qtr, rgdp = `Real Gross Domestic Product - Seasonally Adjusted`) |>
  filter(!is.na(rgdp))

main_variables_qtr <- main_variables |> group_by(qtr) |> summarise(
  MassTransit_qtr = sum(
    `State and Local Government Construction Spending - Mass Transit`,
    na.rm = TRUE
  ),
  Transport_qtr = sum(
    `State and Local Government Construction Spending - Transportation`,
    na.rm = TRUE
  ),
  LandPassTerm_qtr = sum(
    `State and Local Government Construction Spending - Land Passenger Terminal`,
    na.rm = TRUE
  ),
  unemployment_qtr = mean(`Unemployment Rate - Seasonally Adjusted`,
                          na.rm = TRUE),
  bus_qtr = mean(`Transit Ridership - Fixed Route Bus - Adjusted`,
                 na.rm = TRUE),
  rail_qtr = mean(`Transit Ridership - Urban Rail - Adjusted`,
                  na.rm = TRUE),
  OtherTransMod_qtr = mean(`Transit Ridership - Other Transit Modes - Adjusted`,
                           na.rm = TRUE),
  TransEmply_qtr = mean(
    `Transportation Employment - Transit and ground passenger transportation`,
    na.rm = TRUE
  )
)

covid_start <- as.yearqtr("2020 Q1")
covid_end <- as.yearqtr("2023 Q2")

combined <- main_variables_qtr |> left_join(real_GDP, join_by(qtr == qtr))
combined$covid <-
  ifelse(combined$qtr >= covid_start &
           combined$qtr <= covid_end,
         1,
         0)

write_csv(combined,
          "data/intermediate/transport_data_inter_qtr.csv")
