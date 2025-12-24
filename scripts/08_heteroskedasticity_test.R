library(tidyverse)
library(lmtest)

monthly_mod1 <- readRDS("models/monthly_mod1.rds")
monthly_mod2 <- readRDS("models/monthly_mod2.rds")
monthly_mod3 <- readRDS("models/monthly_mod3.rds")

qtrly_mod1 <- readRDS("models/qtrly_mod1.rds")
qtrly_mod2 <- readRDS("models/qtrly_mod2.rds")
qtrly_mod3 <- readRDS("models/qtrly_mod3.rds")

models <-
  list(
    "monthly_mod1" = monthly_mod1,
    "monthly_mod2" = monthly_mod2,
    "monthly_mod3" = monthly_mod3,
    "qtrly_mod1" = qtrly_mod1,
    "qtrly_mod2" = qtrly_mod2,
    "qtrly_mod3" = qtrly_mod3
  )

bp_test <- function(mod_lst) {
  results <- list()
  
  for (mod in seq_along(mod_lst)) {
    name <- names(mod_lst)[mod]
    
    test_result <- bptest(mod_lst[[mod]])
    
    results[[name]] <- test_result
  }
  
  return(results)
}

bp_results <- bp_test(models)

# saveRDS(bp_results, "stat_tests/bp_tests.rds")
