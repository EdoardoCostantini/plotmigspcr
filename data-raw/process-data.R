# Project:   plotmigspcr
# Objective: Prepare and deploy data for app
# Author:    Edoardo Costantini
# Created:   2023-09-12
# Modified:  2023-09-12
# Notes:

# Load data --------------------------------------------------------------------

# Load estimates results
estimates <- readRDS("./data-raw/estimates-gg-shape.rds")

# Specify use in app -----------------------------------------------------------

usethis::use_data(estimates, overwrite = TRUE)
