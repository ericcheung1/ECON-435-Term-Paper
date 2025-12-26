library(tidyverse)
library(zoo)

monthly_data <-
  read_csv("data/intermediate/transport_data_intermediate.csv") |>
  select(-c("covid"))
qtrly_data <-
  read_csv("data/intermediate/transport_data_inter_qtr.csv") |>
  select(-c("covid"))
log_diff_monthly_data <-
  read_csv("data/processed/ld_transport_monthly.csv") |>
  select(-c("covid"))
log_diff_qtrly_data <-
  read_csv("data/processed/ld_transport_quarterly.csv") |>
  select(-c("covid"))

qtrly_data$qtr <- as.yearqtr(qtrly_data$qtr)
log_diff_qtrly_data$Qtr <-  as.yearqtr(log_diff_qtrly_data$Qtr)

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

save_graphs <- function(list_of_graphs, file_path) {
  
  for (graph in names(list_of_graphs)) {
    ggsave(
      filename = paste0(file_path, graph, ".png"),
      plot = list_of_graphs[[graph]],
      width = 7,
      height = 5,
      dpi = 300
    )
  }
  
}

monthly_data_graphs <- graph_time_series(monthly_data)
qtrly_data_graphs <- graph_time_series(qtrly_data)
log_diff_monthly_data_graphs <- graph_time_series(log_diff_monthly_data)
log_diff_qtrly_data_graphs <- graph_time_series(log_diff_qtrly_data)

# save_graphs(monthly_data_graphs, "graphs/monthly/")
# save_graphs(qtrly_data_graphs, "graphs/qtrly/")
# save_graphs(log_diff_monthly_data_graphs, "graphs/log_diff_monthly/")
# save_graphs(log_diff_qtrly_data_graphs, "graphs/log_diff_qtrly/")
