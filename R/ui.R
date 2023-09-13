#' User interface call
#'
#' Calls the definition of the user interface and returns it as an output
#'
#' @return UI object that can be passed directly to shiny::shinyApp()
#' @author Edoardo Costantini, 2023
#' @export
ui_call <- function() {
    # Define ui object
    ui <- shiny::fluidPage(

        # App title
        shiny::titlePanel(
            shiny::h1(
                "Multiple Imputation with GSPCR: a case study",
                align = "center"
            )
        ),
        shiny::column(
            width = 10,
            offset = 1,
            # Create tabs for different plotting aspects
            shiny::tabsetPanel(
                type = "tabs",
                selected = "About this Shiny app",
                shiny::tabPanel(
                    title = "About this Shiny app",
                    shiny::column(
                        width = 8,
                        offset = 2,
                        shiny::HTML(
                            "<br>
                            This Shiny app accompanies the paper:
                            <br>
                            <br>
                            <a href='https://arxiv.org/abs/2206.15107'>Costantini, E., Lang, K. M., Sijtsma, K., & Reeskens, T. (----). Multiple Imputation with Generalised Supervised Principal Components: a Case Study</i>.</a>
                            <br>
                            <br>
                            With this app, the user can:
                            <ul>
                                <li>Interact with the imputation diagnostic plots in <b>Module 1</b>.</li>
                                <li>Interact with the analysis model parameter estaimates plots in <b>Module 2</b>.</li>
                            </ul>
                            For questions and feedback, feel free to <a href = 'mailto:e.costantini@tilburguniversity.edu'>send me an email</a>.
                            "
                        )
                    )
                ),
                shiny::tabPanel(
                    title = "Module 1: Diagnostics",
                    shiny::fluidRow(
                        shiny::column(
                            width = 3,
                            shiny::HTML(
                                "<br>
                                    This tab allows you to plot the results of the simulation study reported in the article.
                                    You change the values of the experimental factors to plot the results you are most interested in.
                                    <br>
                                    <br>"
                            ),
                            shiny::selectInput(
                                inputId = "variable",
                                label = "Variable",
                                choices = names(which(rowSums(is.nan(mids_migspcr$chainMean)) == 0))
                            ),
                            shinyWidgets::sliderTextInput(
                                inputId = "iters",
                                label = "Iteration range",
                                hide_min_max = TRUE,
                                choices = 0:20,
                                selected = c(0, 20),
                                grid = FALSE
                            )
                        ),
                        shiny::column(
                            width = 9,
                            shiny::HTML(
                                "<br>"
                            ),
                            shiny::tabsetPanel(
                                type = "tabs",
                                shiny::tabPanel(
                                    title = "Convergence checks",
                                    shiny::HTML("<br>Trace plot for MI-GSPCR"),
                                    shiny::plotOutput("trace_migspcr"),
                                    shiny::HTML("Trace plot for MI-Expert"),
                                    shiny::plotOutput("trace_expert")
                                ),
                                shiny::tabPanel(
                                    title = "Density plots",
                                    shiny::HTML("<br>Imputation density for MI-GSPCR"),
                                    shiny::plotOutput("density_migspcr"),
                                    shiny::HTML("Imputation density plot for MI-Expert"),
                                    shiny::plotOutput("density_expert")
                                )
                            ),
                            style = "border-left: 1px solid; border-left-color: #DDDDDD"
                        )
                    )
                ),
                shiny::tabPanel(
                    title = "Module 2: Estimation of an analysis model",
                    shiny::fluidRow(
                        shiny::column(
                            width = 3,
                            shiny::HTML(
                                "<br>
                                This tab allows you to plot the results of the case study reported in the article.
                                <br>
                                <br>
                                "
                            ),
                            shiny::checkboxGroupInput(
                                "method",
                                "Missing data treatment",
                                choices = levels(estimates$method),
                                selected = levels(estimates$method)
                            ),
                            shiny::checkboxGroupInput(
                                "outcome",
                                "Outcome measure",
                                choices = levels(estimates$variable)[-1],
                                selected = c("estimate", "t", "fmi")
                            ),
                            shiny::checkboxGroupInput(
                                "term",
                                "Parameters",
                                choices = levels(estimates$term)[-1],
                                selected = levels(estimates$term)[-1]
                            )
                        ),
                        shiny::column(
                            width = 9,
                            shiny::HTML(
                                "<br>"
                            ),
                            shiny::plotOutput("estimates"),
                            style = "border-left: 1px solid; border-left-color: #DDDDDD"
                        )
                    )
                )
            )
        )
    )

    # Return ui object
    return(ui)
}