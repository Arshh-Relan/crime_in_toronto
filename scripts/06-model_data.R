#### Preamble ####
# Purpose: Fits a logistic regression model for the hate crimes data.
# Author: Arshh Relan
# Date: December 3, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("~/Desktop/starter_folder-main-2/data/02-analysis_data/hate_crimes_data_for_analysis.parquet")

#### Model data ####
first_model <- stan_glm(
  formula = arrest_made ~ bias_type + location_type + occurrence_year,
  data = analysis_data,
  family = binomial(link = "logit"),  # Logistic regression
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

#### Save model ####
saveRDS(
  first_model,
  file = "~/Desktop/starter_folder-main-2/models/final_model.rds"
)

# Print success message
message("Logistic regression model saved successfully in final_model.rds")
