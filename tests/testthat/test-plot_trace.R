# Project:   plotmigspcr
# Objective: Test the ggplot trace plot function used in this app
# Author:    Edoardo Costantini
# Created:   2023-10-19
# Modified:  2023-10-19
# Notes: 

# Run the function
plot_output <- plot_trace(
    data = mids_chains,
    var = "v1"
)

# Test it reports the right outcome
testthat::expect_equal(
    class(plot_output),
    c("gg", "ggplot")
)