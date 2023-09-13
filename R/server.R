#' server
#'
#' server function for the shiny app
#'
#' @param input set of inputs coming from ui
#' @param output set of outputs
#' @param session session info and status
#' @author Edoardo Costantini, 2023
#' @export
server <- function(input, output, session) {
    # Parameter estimates plots ------------------------------------------------

    output$estimates <- renderPlot(
        res = 96,
        height = 725,
        {
            plot_estimates(
                gg_shape = estimates,
                terms = levels(estimates$term)[unlist(lapply(input$term, grep, levels(estimates$term)))],
                approach = input$method,
                outcome = input$outcome
            )
        }
    )

    # Convergence plots --------------------------------------------------------

    output$trace_migspcr <- renderPlot(
        res = 96,
        height = 725 / 2,
        {
            plot(
                mids_migspcr,
                input$variable,
                layout = c(2, 1)
            )
        }
    )

    output$trace_expert <- renderPlot(
        res = 96,
        height = 725 / 2,
        {
            plot(
                mids_miexpert,
                input$variable,
                layout = c(2, 1)
            )
        }
    )

    output$univariate_method_migspcr <- renderPrint({
        cat(mids_migspcr$method[input$variable])
    })

    output$univariate_method_miexpert <- renderPrint({
        cat(mids_miexpert$method[input$variable])
    })

    # Convergence plots --------------------------------------------------------

    output$density_migspcr <- renderPlot(
        res = 96,
        height = 725 / 2,
        {
            # Density plots
            lattice::densityplot(
                mids_migspcr,
                data = as.formula(paste0("~ ", input$variable, " | .imp")),
                xlab = "",
                ylab = ""
            )
        }
    )

    output$density_expert <- renderPlot(
        res = 96,
        height = 725 / 2,
        {
            # Density plots
            lattice::densityplot(
                mids_miexpert,
                data = as.formula(paste0("~ ", input$variable, " | .imp")),
                xlab = "",
                ylab = ""
            )
        }
    )
}
