# Breast Cancer Survival Analysis with GBSG2

This project analyzes survival outcomes using the German Breast Cancer Study Group 2 (GBSG2) dataset. It applies statistical survival analysis and machine learning to explore patient outcomes, assess prognostic factors, compare models, and group patients by predicted risk.

## Methods

- Kaplan–Meier survival analysis
- Log-rank test
- Cox proportional hazards regression
- LASSO-Cox regression
- Random Survival Forest
- Model comparison using the concordance index (C-index)
- Patient risk stratification

## Project structure

- `data/` — GBSG2 dataset and prepared training and test data
- `R/` — numbered scripts for preparation, analysis, modeling, comparison, and risk stratification
- `plots/` — generated survival and risk visualizations
- `result/` — saved models, predictions, and comparison results
- `Survival Analysis.Rproj` — RStudio project file

## Getting started

1. Install [R](https://www.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/).
2. Open `Survival Analysis.Rproj` in RStudio.
3. Install any R packages required by the scripts if they are not already installed.
4. Run the scripts in the `R/` folder in numerical order, from `01_data_preparation.R` through `09_risk_stratification.R`.

## Results

The project includes generated plots, model outputs, prediction tables, and risk groups in the `plots/` and `result/` folders.
