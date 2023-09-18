context("Plotting")

# Run the function
plot_output <- plot_estimates(
     gg_shape = estimates,
     terms = levels(estimates$term)[-1],
     approach = levels(estimates$method),
     outcome = c("estimate", "t")
)

# Test it reports the right outcome
testthat::expect_equal(
    class(plot_output),
    c("gg", "ggplot")
)