cox_results <- read.csv(
  "result/cox_predictions.csv"
)

lasso_results <- read.csv(
  "result/lasso_predictions.csv"
)

rsf_results <- read.csv(
  "result/rsf_predictions.csv"
)

# Cox C-index
cox_cindex <- concordance(
  Surv(
    cox_results$time,
    cox_results$event
  ) ~ cox_results$cox_risk,
  reverse = TRUE
)

# LASSO C-index
lasso_cindex <- concordance(
  Surv(
    lasso_results$time,
    lasso_results$event
  ) ~ lasso_results$lasso_risk,
  reverse = TRUE
)

# RSF C-index
rsf_cindex <- concordance(
  Surv(
    rsf_results$time,
    rsf_results$event
  ) ~ rsf_results$rsf_risk,
  reverse = TRUE
)

# Model comparison
model_comparison <- data.frame(
  Model = c(
    "Cox PH",
    "LASSO-Cox",
    "Random Survival Forest"
  ),
  C_index = c(
    cox_cindex$concordance,
    lasso_cindex$concordance,
    rsf_cindex$concordance
  )
)

print(model_comparison)

# Save comparison table
write.csv(
  model_comparison,
  "result/model_comparison.csv",
  row.names = FALSE
)