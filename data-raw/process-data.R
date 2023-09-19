# Project:   plotmigspcr
# Objective: Prepare and deploy data for app
# Author:    Edoardo Costantini
# Created:   2023-09-12
# Modified:  2023-09-12
# Notes:

# Load data --------------------------------------------------------------------

# Load estimates results
estimates <- readRDS("./data-raw/estimates-gg-shape.rds")

# Load mids objects for diagnostics
mids_migspcr <- readRDS("./data-raw/20230817-155605-mids-mi-gspcr.rds")
mids_miexpert <- readRDS("./data-raw/20230829-100551-mids-mi-expert.rds")

# Specify use in app -----------------------------------------------------------

usethis::use_data(estimates, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_migspcr, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_miexpert, overwrite = TRUE, compress = "bzip2")