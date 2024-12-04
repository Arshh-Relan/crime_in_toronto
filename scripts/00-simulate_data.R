#### Preamble ####
# Purpose: Simulates hate crimes data for testing and development purposes.
# Author: Arshh Relan
# Date: December 3, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

# Set a seed for reproducibility
set.seed(123)

# Simulate data
simulated_data <- tibble(
  OCCURRENCE_YEAR = sample(2015:2023, 1000, replace = TRUE),         # Random years
  OCCURRENCE_DATE = sample(seq.Date(from = as.Date("2015-01-01"),   # Random dates
                                    to = as.Date("2023-12-31"), 
                                    by = "day"), 
                           1000, replace = TRUE),
  BIAS_TYPE = sample(c("Race", "Religion", "Gender",                # Random bias types
                       "Sexual Orientation", "None"), 
                     1000, replace = TRUE, prob = c(0.4, 0.3, 0.1, 0.1, 0.1)),
  LOCATION_TYPE = sample(c("Public", "Residential", "Commercial",   # Random location types
                           "Other"), 
                         1000, replace = TRUE, prob = c(0.5, 0.3, 0.15, 0.05)),
  ARREST_MADE = sample(c("YES", "NO"), 1000, replace = TRUE, prob = c(0.3, 0.7))  # Arrest probabilities
)

# Ensure the simulated_data folder exists
dir.create("~/Desktop/starter_folder-main-2/data/00-simulated_data", recursive = TRUE, showWarnings = FALSE)

# Save simulated data to the specified path
write_csv(simulated_data, "~/Desktop/starter_folder-main-2/data/00-simulated_data/simulated_data.csv")

# Print success message
message("Simulated data created and saved successfully in simulated_data folder.")
