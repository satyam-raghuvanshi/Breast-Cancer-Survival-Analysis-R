library(ggplot2)
data <- read.csv("data/GBSG2.csv")

# Convert categorical variables
data$horTh <- factor(data$horTh)
data$menostat <- factor(data$menostat)
data$tgrade <- factor(
  data$tgrade,
  ordered = TRUE
)

# Create event indicator
data$event <- ifelse(
  data$cens == 0,
  1,
  0
)

# Basic summary
summary(data)

# Missing values
colSums(is.na(data))

# Age distribution
hist(
  data$age,
  main = "Distribution of Age",
  xlab = "Age"
)

# Tumour size distribution
hist(
  data$tsize,
  main = "Distribution of Tumour Size",
  xlab = "Tumour Size"
)

# Positive lymph nodes distribution
hist(
  data$pnodes,
  main = "Distribution of Positive Lymph Nodes",
  xlab = "Positive Lymph Nodes"
)

# Hormone therapy
table(data$horTh)

# Menopausal status
table(data$menostat)

# Tumour grade
table(data$tgrade)

# Event status
table(data$event)

# Censoring status
table(data$cens)