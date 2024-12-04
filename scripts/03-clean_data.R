#### Preamble ####
# Purpose: Cleans the raw hate crimes data for analysis and saves it as a .parquet file.
# Author: Arshh Relan
# Date: December 3 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)  # For saving parquet files

#### Clean data ####

# Load the raw data
raw_data <- read_csv("~/Desktop/starter_folder-main-2/data/01-raw_data/hate_crimes_raw_data.csv")

# Clean and prepare the data
cleaned_data <- raw_data |>
  janitor::clean_names() |>
  mutate(
    bias_type = case_when(
      race_bias != "None" ~ "Race",
      religion_bias != "None" ~ "Religion",
      gender_bias != "None" ~ "Gender",
      sexual_orientation_bias != "None" ~ "Sexual Orientation",
      language_bias != "None" ~ "Language",
      ethnicity_bias != "None" ~ "Ethnicity",
      age_bias != "None" ~ "Age",
      mental_or_physical_disability != "None" ~ "Disability",
      TRUE ~ "Multiple"
    )
  ) |>
  select(occurrence_year, occurrence_date, bias_type, location_type, arrest_made) |>
  mutate(
    arrest_made = if_else(arrest_made == "YES", 1, 0),
    bias_type = str_to_title(bias_type),
    location_type = str_to_title(location_type),
    occurrence_year = as.integer(occurrence_year),
    occurrence_date = as.Date(occurrence_date)
  ) |>
  filter(!is.na(arrest_made), !is.na(bias_type), !is.na(location_type)) |>
  distinct()

#### Save data ####

# Ensure the analysis_data folder exists
dir.create("~/Desktop/starter_folder-main-2/data/02-analysis_data", recursive = TRUE, showWarnings = FALSE)

# Save the cleaned data as a .parquet file
write_parquet(cleaned_data, "~/Desktop/starter_folder-main-2/data/02-analysis_data/hate_crimes_data_for_analysis.parquet")

# Print success message
message("Cleaned data saved successfully in analysis_data folder as a .parquet file.")
