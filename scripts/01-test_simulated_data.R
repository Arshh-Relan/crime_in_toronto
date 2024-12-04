#### Preamble ####
# Purpose: Tests the structure and validity of the simulated hate crimes dataset.
# Author: Arshh Relan
# Date: December 3, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - The `tidyverse` package must be installed and loaded
#   - 00-simulate_data.R must have been run
# Any other information needed? Ensure you are in the correct project directory.

#### Workspace setup ####
library(tidyverse)

# Load the simulated dataset
simulated_data <- read_csv("~/Desktop/starter_folder-main-2/data/00-simulated_data/simulated_data.csv")

# Test if the dataset was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has at least 1000 rows
if (nrow(simulated_data) >= 1000) {
  message("Test Passed: The dataset has at least 1000 rows.")
} else {
  stop("Test Failed: The dataset does not have at least 1000 rows.")
}

# Check if the dataset has 5 columns
if (ncol(simulated_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if all columns are present
required_columns <- c("OCCURRENCE_YEAR", "OCCURRENCE_DATE", "BIAS_TYPE", "LOCATION_TYPE", "ARREST_MADE")
if (all(required_columns %in% colnames(simulated_data))) {
  message("Test Passed: All required columns are present.")
} else {
  stop("Test Failed: One or more required columns are missing.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if "BIAS_TYPE" contains valid categories
valid_bias_types <- c("Race", "Religion", "Gender", "Sexual Orientation", "None")
if (all(simulated_data$BIAS_TYPE %in% valid_bias_types)) {
  message("Test Passed: The 'BIAS_TYPE' column contains only valid categories.")
} else {
  stop("Test Failed: The 'BIAS_TYPE' column contains invalid categories.")
}

# Check if "ARREST_MADE" contains only "YES" or "NO"
if (all(simulated_data$ARREST_MADE %in% c("YES", "NO"))) {
  message("Test Passed: The 'ARREST_MADE' column contains only 'YES' or 'NO'.")
} else {
  stop("Test Failed: The 'ARREST_MADE' column contains invalid values.")
}
