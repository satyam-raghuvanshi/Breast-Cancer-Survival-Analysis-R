library(survival)
train <- read.csv(
  "data/GBSG2_train.csv"
)
test <- read.csv(
  "data/GBSG2_test.csv"
)

# Convert categorical variables
train$horTh <- factor(train$horTh)
train$menostat <- factor(train$menostat)
train$tgrade <- factor(
  train$tgrade,
  ordered = TRUE
)
test$horTh <- factor(test$horTh)
test$menostat <- factor(test$menostat)
test$tgrade <- factor(
  test$tgrade,
  ordered = TRUE
)

# Cox proportional hazards model
cox_model <- coxph(
  Surv(time, event) ~
    horTh +
    age +
    menostat +
    tsize +
    tgrade +
    pnodes +
    progrec +
    estrec,
  data = train
)

# Model summary
summary(cox_model)

# Hazard ratios
exp(
  coef(cox_model)
)

# Confidence intervals for hazard ratios
exp(
  confint(cox_model)
)

# Proportional hazards assumption
ph_test <- cox.zph(
  cox_model
)
print(ph_test)

# Schoenfeld residual plots
plot(ph_test)

# Save Cox model
saveRDS(
  cox_model,
  "result/cox_model.rds"
)

# Predict risk on test data
cox_risk <- predict(
  cox_model,
  newdata = test,
  type = "lp"
)

# Cox C-index
cox_cindex <- concordance(
  Surv(test$time, test$event) ~ cox_risk,
  reverse = TRUE
)
print(
  cox_cindex$concordance
)

# Save Cox predictions
cox_results <- data.frame(
  time = test$time,
  event = test$event,
  cox_risk = cox_risk
)
write.csv(
  cox_results,
  "result/cox_predictions.csv",
  row.names = FALSE
)