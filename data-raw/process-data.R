# Project:   plotmigspcr
# Objective: Prepare and deploy data for app
# Author:    Edoardo Costantini
# Created:   2023-09-12
# Modified:  2023-10-21
# Notes:

# Load packages that are needed only for processing of data --------------------

library(mice)

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

# Fix order of methods
mids_chains$method <- factor(
    mids_chains$method,
    levels = unique(mids_chains$method),
    labels = c("MI-GSPCR", "MI-Expert")
)

# Prepare density data ---------------------------------------------------------

# Create a list of the mids objects
mids_list <- list(
    gspcr = mids_migspcr,
    expert = mids_miexpert
)

# Apply to each mids object the same processing steps
imps_list <- lapply(1:length(mids_list), function(i) {
    # Extract imputations in long format
    imps <- data.frame(mice::complete(mids_list[[i]], "long", include = TRUE))

    # Create a matrix of response indicators
    RI <- is.na(mids_list[[i]]$data)

    # Create an empty list to store intermediate objects
    shelf <- list()

    # Loop over the variables
    for (j in 1:ncol(RI)) {
        if (any(RI[, j])) {
            # What variable are we considering
            J <- colnames(RI)[j]

            # Keep only the .imp identifier and the variable value
            active_data <- imps[, c(".imp", J)]

            # Make active variable numeric
            active_data[, J] <- as.numeric(active_data[, J])

            # attach the response indicator
            active_data <- cbind(
                active_data,
                miss = RI[, J]
            )

            # Melt values
            ad_melt <- reshape2::melt(active_data, id.vars = c(".imp", "miss"))

            # Make variable numeric
            ad_melt$value

            # Filter by dropping all of the cases that are observed from the non 0 groups
            ad_melt_imps <- ad_melt %>%
                filter(
                    .imp != 0,
                    miss == TRUE
                )

            # Filter by dropping all cases that are missing in the observed data
            ad_melt_obs <- ad_melt %>%
                filter(
                    .imp == 0,
                    miss == FALSE
                )

            # Store the result
            shelf[[j]] <- rbind(ad_melt_obs, ad_melt_imps)
        }
    }

    # Combine the results from the many variables
    imps_ggplot <- do.call(rbind, shelf)

    # Attach a variable with the method name
    cbind(imps_ggplot, method = names(mids_list)[i])

})

# Collapse the data from the different methods in a single data.frame
imps_ggplot <- do.call(rbind, imps_list)

# Make the method variable a factor with meaningful names
imps_ggplot$method <- factor(
    imps_ggplot$method,
    levels = unique(imps_ggplot$method),
    labels = c("MI-GSPCR", "MI-Expert")
)

# Create a grouping variable for the densities
imps_ggplot$group <- paste0(imps_ggplot$.imp, imps_ggplot$miss)

# Make the grouping variable a factor with meaningful labels
imps_ggplot$group <- factor(
    imps_ggplot$group,
    levels = unique(imps_ggplot$group),
    labels = c(
        "Observed data",
        paste0("Imputation chain ", seq(1:(length(unique(imps_ggplot$group)) - 1)))
    )
)

# Method vector ----------------------------------------------------------------

imp_methods <- plotmigspcr::mids_migspcr$method

# Specify use in app -----------------------------------------------------------

usethis::use_data(estimates, overwrite = TRUE, compress = "bzip2")
usethis::use_data(mids_chains, overwrite = TRUE, compress = "bzip2")
usethis::use_data(imps_ggplot, overwrite = TRUE, compress = "bzip2")
usethis::use_data(imp_methods, overwrite = TRUE, compress = "bzip2")