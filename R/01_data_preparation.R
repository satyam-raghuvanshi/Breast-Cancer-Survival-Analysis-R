library(survival)
data <- read.csv("C:\\Users\\Dell\\Documents\\Survival Analysis\\data\\GBSG2.csv")
head(data)
dim(data)
names(data)
str(data)
summary(data)
colSums(is.na(data))

# Convert categorical variables
data$horTh <- factor(data$horTh)
data$menostat <- factor(data$menostat)
data$tgrade <- factor(
  data$tgrade,
  ordered = TRUE
)

# Create event indicator
data$event <- as.integer(data$cens == 1)

# Check censoring and event variables
table(data$cens)
table(data$event)
table(
  data$cens,
  data$event
)

# Create survival object
surv_object <- Surv(
  time = data$time,
  event = data$event
)
surv_object