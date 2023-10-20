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

    # Update inputs ------------------------------------------------------------

    # Next variable
    shiny::observeEvent(input$next_vairable, {
        shiny::updateSelectInput(
            session, 
            inputId = "variable",
            label = "Variable",
            choices = names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0)),
            selected = names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0))[which(names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0)) %in% input$variable)+1]
        )
    })

    # Previous variable
    shiny::observeEvent(input$previous_vairable, {
        shiny::updateSelectInput(
            session,
            inputId = "variable",
            label = "Variable",
            choices = names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0)),
            selected = names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0))[which(names(which(rowSums(is.nan(plotmigspcr::mids_migspcr$chainMean)) == 0)) %in% input$variable) - 1]
        )
    })
    
    # Parameter estimates plots ------------------------------------------------

    output$estimates <- shiny::renderPlot(
        res = 96,
        height = 725,
        {
            plot_estimates(
                gg_shape = plotmigspcr::estimates,
                terms = levels(plotmigspcr::estimates$term)[unlist(lapply(input$term, grep, levels(plotmigspcr::estimates$term)))],
                approach = input$method,
                outcome = input$outcome
            )
        }
    )

    # Convergence plots --------------------------------------------------------

    output$ggplot_trace <- shiny::renderPlot(
        res = 96,
        height = 500,
        {
            plot_trace(
                data = plotmigspcr::mids_chains,
                var = input$variable
            )
        }
    )

    output$univariate_method_migspcr <- shiny::renderPrint({
        cat(plotmigspcr::mids_migspcr$method[input$variable])
    })

    output$univariate_method_miexpert <- shiny::renderPrint({
        cat(plotmigspcr::mids_miexpert$method[input$variable])
    })

    # Density plots ------------------------------------------------------------

    output$density_ggplot <- shiny::renderPlot(
        res = 96,
        height = 500,
        {
            # Density plots
            plot_densities(
                data = plotmigspcr::imps_ggplot,
                var = input$variable
            )
        }
    )
    
}
