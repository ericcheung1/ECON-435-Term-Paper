library(tidyverse)

pre_ld_monthly <-
  read_csv("data/intermediate/transport_data_intermediate.csv") |>
  select(-c("covid"))
pre_ld_qtrly <-
  read_csv("data/intermediate/transport_data_inter_qtr.csv") |>
  select(-c("covid"))
ld_monthly <-
  read_csv("data/processed/ld_transport_monthly.csv") |>
  select(-c("covid"))
ld_qtrly <-
  read_csv("data/processed/ld_transport_quarterly.csv") |>
  select(-c("covid"))

graph_time_series <- function(df) {
  graph_list <- list()
  last_col <- ncol(df)
  time_var <- df[[1]]
  
  for (column in names(df)[2:last_col]) {
    p <- ggplot(df, aes(x = time_var, y = !!sym(column))) +
      geom_line() +
      labs(title = column, x = "Time")
    graph_list[[column]] <- p
    # print(p)
  }
  
  return(graph_list)
}

pld_monthly_graphs <- graph_time_series(pre_ld_monthly)
pld_qtrly_graphs <- graph_time_series(pre_ld_qtrly)
ld_monthly_graphs <- graph_time_series(ld_qtrly)
ld_qtrly_graphs <- graph_time_series(ld_qtrly)


