library(survival)
library(survminer)

test <- read.csv(
  "data/GBSG2_test.csv"
)

# Load Cox model
cox_model <- readRDS(
  "result/cox_model.rds"
)

# Convert categorical variables
test$horTh <- factor(test$horTh)
test$menostat <- factor(test$menostat)
test$tgrade <- factor(
  test$tgrade,
  ordered = TRUE
)

# Predict Cox risk score
cox_risk <- predict(
  cox_model,
  newdata = test,
  type = "lp"
)

# Median risk cutoff
risk_cutoff <- median(
  cox_risk
)
print(risk_cutoff)

# Create risk groups
test$risk_group <- ifelse(
  cox_risk >= risk_cutoff,
  "High Risk",
  "Low Risk"
)

# Convert to factor
test$risk_group <- factor(
  test$risk_group,
  levels = c(
    "Low Risk",
    "High Risk"
  )
)

# Number of patients in each group
table(
  test$risk_group
)

# Kaplan-Meier model by risk group
risk_km <- survfit(
  Surv(time, event) ~ risk_group,
  data = test
)

# Survival summary
summary(risk_km)

# Kaplan-Meier plot
risk_plot <- ggsurvplot(
  risk_km,
  data = test,
  pval = TRUE,
  conf.int = TRUE,
  risk.table = TRUE,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  title = "Survival by Predicted Risk Group",
  legend.title = "Risk Group"
)
print(risk_plot)

# Save plot
ggsave(
  "plots/risk_stratification.png",
  risk_plot$plot,
  width = 8,
  height = 6
)

# Log-rank test
risk_logrank <- survdiff(
  Surv(time, event) ~ risk_group,
  data = test
)
print(risk_logrank)

# Save risk-group data
write.csv(
  test,
  "result/risk_groups.csv",
  row.names = FALSE
)