library(survival)
library(survminer)
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

# Overall Kaplan-Meier model
km_fit <- survfit(
  Surv(time, event) ~ 1,
  data = data
)

# Survival summary
summary(km_fit)

# Overall Kaplan-Meier plot
km_plot <- ggsurvplot(
  km_fit,
  data = data,
  conf.int = TRUE,
  risk.table = TRUE,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  title = "Overall Kaplan-Meier Survival Curve"
)
print(km_plot)

# Save plot
ggsave(
  "plots/overall_kaplan_meier.png",
  km_plot$plot,
  width = 8,
  height = 6
)

# Kaplan-Meier by hormone therapy
km_hormone <- survfit(
  Surv(time, event) ~ horTh,
  data = data
)

# Survival summary
summary(km_hormone)

# Kaplan-Meier plot by hormone therapy
hormone_plot <- ggsurvplot(
  km_hormone,
  data = data,
  pval = TRUE,
  conf.int = TRUE,
  risk.table = TRUE,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  title = "Kaplan-Meier Survival by Hormone Therapy",
  legend.title = "Hormone Therapy"
)
print(hormone_plot)

# Save plot
ggsave(
  "plots/km_hormone_therapy.png",
  hormone_plot$plot,
  width = 8,
  height = 6
)

# Log-rank test
logrank_test <- survdiff(
  Surv(time, event) ~ horTh,
  data = data
)
print(logrank_test)