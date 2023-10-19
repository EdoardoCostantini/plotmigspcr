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

# Prepare mids data ------------------------------------------------------------

# GSPCR chain means
mn_gspcr_long <- reshape2::melt(
    data = mids_migspcr$chainMean,
    value.name = "value",
    varnames = c("variable", "iteration", "chain")
)

# GSPCR chain standard deviations
sm_gspcr_long <- reshape2::melt(
    data = sqrt(mids_migspcr$chainVar),
    value.name = "value",
    varnames = c("variable", "iteration", "chain")
)

# Expert chain means
mn_expert_long <- reshape2::melt(
    data = mids_miexpert$chainMean,
    value.name = "value",
    varnames = c("variable", "iteration", "chain")
)

# Expert chain standard deviations
sm_expert_long <- reshape2::melt(
    data = sqrt(mids_miexpert$chainVar),
    value.name = "value",
    varnames = c("variable", "iteration", "chain")
)

# Attach grouping information
mn_gspcr_long <- cbind(mn_gspcr_long, method = "MI-GSPCR", measure = "mean")
sm_gspcr_long <- cbind(sm_gspcr_long, method = "MI-GSPCR", measure = "sd")
mn_expert_long <- cbind(mn_expert_long, method = "MI-Expert", measure = "mean")
sm_expert_long <- cbind(sm_expert_long, method = "MI-Expert", measure = "sd")

# Combine data
mids_chains <- rbind(
    mn_gspcr_long,
    sm_gspcr_long,
    mn_expert_long,
    sm_expert_long
)

# Specify use in app -----------------------------------------------------------

usethis::use_data(estimates, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_chains, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_migspcr, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_miexpert, overwrite = TRUE, compress = "bzip2")