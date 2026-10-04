library(survival)
library(randomForestSRC)
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

# Random Survival Forest
set.seed(123)
rsf_model <- rfsrc(
  Surv(time, event) ~
    horTh +
    age +
    menostat +
    tsize +
    tgrade +
    pnodes +
    progrec +
    estrec,
  data = train,
  ntree = 500,
  importance = TRUE
)

# Model summary
print(rsf_model)

# Variable importance
print(rsf_model$importance)

# Variable importance plot
plot(rsf_model)

# Save model
saveRDS(
  rsf_model,
  "result/rsf_model.rds"
)

# Prediction
rsf_pred <- predict(
  rsf_model,
  newdata = test
)

# Predicted risk
rsf_risk <- rsf_pred$predicted

# RSF C-index
rsf_cindex <- concordance(
  Surv(test$time, test$event) ~ rsf_risk,
  reverse = TRUE
)
print(
  rsf_cindex$concordance
)

# Save predictions
rsf_results <- data.frame(
  time = test$time,
  event = test$event,
  rsf_risk = rsf_risk
)
write.csv(
  rsf_results,
  "result/rsf_predictions.csv",
  row.names = FALSE
)