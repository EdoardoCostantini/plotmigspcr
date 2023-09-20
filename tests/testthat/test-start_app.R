library(shinytest)
test_that("start_app() works", {
    # Don't run these tests on the CRAN build servers
    testthat::skip_on_cran()

    # Use compareImages=FALSE because the expected image screenshots were created
    # on a Mac, and they will differ from screenshots taken on the CI platform,
    # which runs on Linux.
    shinytest::expect_pass(
        shinytest::testApp(
            "./apps/start_app",
            compareImages = FALSE
        )
    )
})
