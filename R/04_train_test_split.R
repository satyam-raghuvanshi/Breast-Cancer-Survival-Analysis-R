data <- read.csv("data/GBSG2.csv")

# Convert categorical variables
data$horTh <- factor(data$horTh)
data$menostat <- factor(data$menostat)
data$tgrade <- factor(
  data$tgrade,
  ordered = TRUE
)

# Create event indicator
data$event <- as.integer(data$cens == 1)

# Train-test split
set.seed(123)
n <- nrow(data)
train_index <- sample(
  1:n,
  size = floor(0.70 * n)
)
train <- data[train_index, ]
test <- data[-train_index, ]

# Check dimensions
dim(train)
dim(test)

# Check event distribution
table(train$event)
table(test$event)

# Save datasets
write.csv(
  train,
  "data/GBSG2_train.csv",
  row.names = FALSE
)
write.csv(
  test,
  "data/GBSG2_test.csv",
  row.names = FALSE
)