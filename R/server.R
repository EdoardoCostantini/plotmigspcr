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
                terms = input$term,
                approach = input$method,
                outcome = input$outcome
            )
        }
    )

}
