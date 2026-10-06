# GBSG2 Breast Cancer Recurrence-Free Survival Analysis

This project analyzes right-censored recurrence-free survival in the German Breast Cancer Study Group 2 (GBSG2) dataset using Kaplan-Meier estimation, Cox regression, LASSO-Cox, and a Random Survival Forest.

## Dataset

The dataset is `data/GBSG2.csv` and contains 686 patients. `time` is recurrence-free survival time in days. The source variable `cens` equals 1 when an event was observed and 0 when the observation was censored. The analysis scripts create `event` with the same convention: `event = 1` for an observed event and `event = 0` for censoring.

Predictors used in the models:

| Variable | Description |
| --- | --- |
| `horTh` | Hormone therapy |
| `age` | Age in years |
| `menostat` | Menopausal status |
| `tsize` | Tumor size |
| `tgrade` | Ordered tumor grade |
| `pnodes` | Number of positive lymph nodes |
| `progrec` | Progesterone receptor measurement |
| `estrec` | Estrogen receptor measurement |

## Analysis workflow

Run scripts from the project root so the relative paths to `data/`, `plots/`, and `result/` work. Run them in numerical order:

1. `R/01_data_preparation.R` — inspect the data, missingness, censoring, and event coding.
2. `R/02_eda.R` — summarize predictors and outcomes.
3. `R/03_kaplan_meier.R` — estimate overall and hormone-therapy-stratified Kaplan-Meier curves and run a log-rank test.
4. `R/04_train_test_split.R` — create a reproducible 70/30 train/test split (seed 123) and save the event indicator.
5. `R/05_cox_model.R` — fit Cox PH on the training set, assess proportional-hazards assumptions with Schoenfeld residuals, and evaluate test-set concordance.
6. `R/06_lasso_cox.R` — cross-validate a LASSO-Cox model and evaluate test-set concordance.
7. `R/07_random_survival_forest.R` — fit a 500-tree random survival forest and evaluate test-set concordance.
8. `R/08_model_comparison.R` — compare held-out C-indices.
9. `R/09_risk_stratification.R` — split test patients at the median test-set Cox risk score and compare their Kaplan-Meier curves.

Required packages: `survival`, `survminer`, `ggplot2`, `glmnet`, and `randomForestSRC`.

```r
install.packages(c("survival", "survminer", "ggplot2", "glmnet", "randomForestSRC"))
```

## Current results

For the saved split, the test set contains 206 patients and 99 observed events. The held-out C-indices are:

| Model | Test-set C-index |
| --- | ---: |
| Cox PH | 0.658 |
| LASSO-Cox | 0.659 |
| Random Survival Forest | 0.696 |

The hormone-therapy Kaplan-Meier comparison has a log-rank p-value of 0.0034. The test-set risk-group comparison has a log-rank p-value of 0.00099. These results are specific to this dataset and split. The risk-group cutoff is calculated from test-set risk scores, so that comparison is exploratory rather than an independent validation.

## Generated files

- `data/GBSG2_train.csv` and `data/GBSG2_test.csv` — train/test split with the derived `event` column.
- `plots/` — overall, hormone-therapy, and risk-group Kaplan-Meier plots.
- `result/` — fitted models (`.rds`), test predictions, risk-group assignments, and model-comparison table.

## Limitations

C-indices come from one random split and may vary with another split. The risk-group comparison is exploratory. This analysis describes associations and predictive discrimination in this dataset; it does not establish causal treatment effects or clinical usefulness.

## Author

**Satyam Singh** — M.Sc. Statistics, Indian Institute of Technology Bombay

## Skills

R, survival analysis, Kaplan-Meier estimation, Cox regression, LASSO, random survival forests, model evaluation, and data visualization.
