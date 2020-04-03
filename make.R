# make.R

# Master script for running the whole analysis.

# Setup ----

# Set working directory
here::here()

# Load packages
source("code/utils.R")

# Load functions and plans  ----
source("code/load_data.R")
source("code/model.R")
source("code/plan.R")

# Run analyses ----
make(plan)