# PBC Survival Analysis and Survival Machine Learning

## Project Overview

This project performs a complete survival analysis of patients with Primary Biliary Cholangitis (PBC).

The project combines traditional statistical survival-analysis methods with machine-learning approaches to study patient survival and identify important risk factors.

The main methods used are:

* Kaplan-Meier survival analysis
* Log-rank test
* Cox proportional hazards regression
* LASSO-Cox regression
* Random Survival Forest
* Survival-risk prediction
* Concordance index (C-index)

---

## Objectives

The main objectives of this project are:

1. Explore the clinical characteristics of the PBC patients.
2. Understand survival and censoring in the dataset.
3. Estimate survival probabilities using the Kaplan-Meier method.
4. Compare survival between different patient groups using the log-rank test.
5. Identify important predictors of survival using the Cox proportional hazards model.
6. Perform variable selection using LASSO-Cox regression.
7. Build a Random Survival Forest model for nonlinear survival prediction.
8. Evaluate and compare the survival models using the concordance index.
9. Develop a patient risk-stratification approach.

---

## Dataset

The project uses the PBC dataset.

The dataset contains clinical and laboratory measurements collected from patients with Primary Biliary Cholangitis.

Important variables include:

| Variable    | Description                |
| ----------- | -------------------------- |
| `time`      | Follow-up time             |
| `status`    | Patient outcome/status     |
| `age`       | Age of the patient         |
| `sex`       | Sex                        |
| `albumin`   | Serum albumin              |
| `bilirubin` | Serum bilirubin            |
| `alk.phos`  | Alkaline phosphatase       |
| `ast`       | Aspartate aminotransferase |
| `platelet`  | Platelet count             |
| `protime`   | Prothrombin time           |
| `edema`     | Presence/severity of edema |
| `stage`     | Disease stage              |

---

## Methods

### 1. Exploratory Data Analysis

The dataset is first explored using:

* Summary statistics
* Missing-value analysis
* Histograms
* Boxplots
* Bar plots
* Correlation analysis

### 2. Kaplan-Meier Analysis

Kaplan-Meier estimation is used to estimate the probability of surviving beyond a particular time.

### 3. Log-Rank Test

The log-rank test is used to compare survival curves between patient groups.

### 4. Cox Proportional Hazards Model

A Cox proportional hazards model is fitted to investigate the relationship between patient characteristics and the hazard of death.

Hazard ratios are used to interpret the effects of the predictors.

### 5. LASSO-Cox

LASSO regularization is applied to the Cox model for variable selection and to reduce model complexity.

### 6. Random Survival Forest

A Random Survival Forest model is developed as the machine-learning component of the project.

RSF can model nonlinear relationships and interactions between predictors without requiring them to be specified beforehand.

### 7. Model Evaluation

The models are evaluated using the concordance index.

The following models are compared:

* Cox proportional hazards model
* LASSO-Cox model
* Random Survival Forest

---

## Project Structure

```text
PBC-Survival-Analysis/
│
├── data/
│   └── pbc.csv
│
├── R/
│   ├── 01_data_cleaning.R
│   ├── 02_eda.R
│   ├── 03_kaplan_meier.R
│   ├── 04_cox_model.R
│   ├── 05_lasso_cox.R
│   ├── 06_random_survival_forest.R
│   └── 07_model_comparison.R
│
├── plots/
│
├── results/
│
├── README.md
├── .gitignore
└── PBC-Survival-Analysis.Rproj
```

---

## R Packages

The main R packages used in this project are:

```r
install.packages(c(
  "survival",
  "survminer",
  "ggplot2",
  "dplyr",
  "tidyr",
  "broom",
  "glmnet",
  "randomForestSRC"
))
```

Load them using:

```r
library(survival)
library(survminer)
library(ggplot2)
library(dplyr)
library(tidyr)
library(broom)
library(glmnet)
library(randomForestSRC)
```

---

## Survival Analysis Workflow

```text
Data
  ↓
Data Cleaning
  ↓
Exploratory Data Analysis
  ↓
Kaplan-Meier Analysis
  ↓
Log-Rank Test
  ↓
Cox Proportional Hazards
  ↓
Model Diagnostics
  ↓
LASSO-Cox
  ↓
Random Survival Forest
  ↓
Test Set Prediction
  ↓
C-index
  ↓
Model Comparison
  ↓
Risk Stratification
```

---

## Important Statistical Concepts

### Survival Function

The survival function is defined as:

S(t) = P(T > t)

where `T` represents the survival time.

### Hazard Function

The hazard function describes the instantaneous risk of experiencing the event at time `t`, given survival up to time `t`.

### Censoring

A patient is censored when the event of interest has not been observed during the available follow-up period.

### Hazard Ratio

In a Cox model, the hazard ratio compares the hazard between two individuals or groups while holding other variables constant.

---

## Model Comparison

The project compares statistical and machine-learning survival models.

| Model                  | Main Purpose                                        |
| ---------------------- | --------------------------------------------------- |
| Cox PH                 | Interpretable statistical survival model            |
| LASSO-Cox              | Variable selection and regularization               |
| Random Survival Forest | Nonlinear and interaction-based survival prediction |

The concordance index is used to assess discrimination.

---

## Results

The final results section will contain:

* Kaplan-Meier survival curves
* Log-rank test results
* Cox regression hazard ratios
* Cox model diagnostics
* LASSO-selected variables
* Random Survival Forest variable importance
* C-index values
* Model comparison
* Patient risk groups

The numerical results will be added after running the analysis.

---

## Limitations

Some important limitations of the analysis include:

* The dataset is observational.
* Association does not necessarily imply causation.
* Missing values may affect model estimates.
* Cox regression relies on the proportional-hazards assumption.
* Machine-learning models may be less interpretable than Cox regression.
* Model performance may depend on the train-test split.
* Transplantation can create a competing-risk issue in analyses where death is the event of interest.

---

## How to Run the Project

1. Open `PBC-Survival-Analysis.Rproj` in RStudio.
2. Place the dataset inside the `data` folder.
3. Install the required packages.
4. Run the scripts in numerical order.
5. Generated plots should be saved in the `plots` folder.
6. Model outputs and tables should be saved in the `results` folder.

---

## Author

**Satyam Singh**

M.Sc. Statistics
Indian Institute of Technology Bombay

---

## Skills Demonstrated

* R
* RStudio
* Survival Analysis
* Statistical Modelling
* Kaplan-Meier Estimation
* Cox Regression
* LASSO
* Machine Learning
* Random Survival Forest
* Model Evaluation
* Data Visualization
* Git
* GitHub
