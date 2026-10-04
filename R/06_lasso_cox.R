library(survival)
library(glmnet)

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


# Training design matrix

x_train <- model.matrix(
  ~ horTh +
    age +
    menostat +
    tsize +
    tgrade +
    pnodes +
    progrec +
    estrec,
  data = train
)[, -1]


# Training survival outcome

y_train <- Surv(
  train$time,
  train$event
)


# LASSO-Cox model

set.seed(123)

lasso_cv <- cv.glmnet(
  x_train,
  y_train,
  family = "cox",
  alpha = 1
)


# Cross-validation plot

plot(lasso_cv)


# Lambda values

lasso_cv$lambda.min

lasso_cv$lambda.1se


# Coefficients at lambda.min

lasso_coefficients <- coef(
  lasso_cv,
  s = "lambda.min"
)

print(lasso_coefficients)


# Test design matrix

x_test <- model.matrix(
  ~ horTh +
    age +
    menostat +
    tsize +
    tgrade +
    pnodes +
    progrec +
    estrec,
  data = test
)[, -1]


# LASSO risk prediction

lasso_risk <- predict(
  lasso_cv,
  newx = x_test,
  s = "lambda.min",
  type = "link"
)


# LASSO C-index

lasso_cindex <- concordance(
  Surv(test$time, test$event) ~
    as.numeric(lasso_risk),
  reverse = TRUE
)

print(
  lasso_cindex$concordance
)


# Save model

saveRDS(
  lasso_cv,
  "result/lasso_cox_model.rds"
)


# Save predictions

lasso_results <- data.frame(
  time = test$time,
  event = test$event,
  lasso_risk = as.numeric(lasso_risk)
)

write.csv(
  lasso_results,
  "result/lasso_predictions.csv",
  row.names = FALSE
)