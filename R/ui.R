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
                "Multiple Imputation with GSPCR: A Case Study",
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
                                    This tab allows you to investigate the <b>diagnostic plots</b> for MI-GSPCR and MI-expert.
                                    Plots are displayed per variable.
                                    You change which variable is considered by typing or selecting a variable of interest in dropdown menu.
                                    The unviariate imputation method used for the variable considered is reported below.
                                    Check out the <code>mice</code> help file to for more information.
                                    <br>
                                    <br>"
                            ),
                            shiny::selectInput(
                                inputId = "variable",
                                label = "Variable",
                                choices = levels(imps_ggplot$variable)
                            ),
                            shiny::actionButton(
                                inputId = "previous_vairable",
                                label = "Previous"
                            ),
                            shiny::actionButton(
                                inputId = "next_vairable",
                                label = "Next"
                            ),
                            shiny::HTML(
                                "<br><br><b>Univariate imputation methods:</b><br>"
                            ),
                            shiny::HTML(
                                paste0("- <code>", shiny::textOutput("univariate_method_migspcr", inline = TRUE), "</code> in MI-GSPCR<br>")
                            ),
                            shiny::HTML(
                                paste0("- <code>", shiny::textOutput("univariate_method_miexpert", inline = TRUE), "</code> in MI-expert")
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
                                    shiny::plotOutput("ggplot_trace")
                                ),
                                shiny::tabPanel(
                                    title = "Density plots",
                                    shiny::plotOutput("density_ggplot")
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
                            shiny::selectInput(
                                "method",
                                "Missing data treatment",
                                multiple = TRUE,
                                choices = levels(plotmigspcr::estimates$method),
                                selected = levels(plotmigspcr::estimates$method)[1:2]
                            ),
                            shiny::selectInput(
                                "outcome",
                                "Outcome measures",
                                multiple = TRUE,
                                choices = levels(plotmigspcr::estimates$variable)[-1],
                                selected = levels(plotmigspcr::estimates$variable)[c(2:5, 10)]
                            ),
                            shiny::checkboxGroupInput(
                                "term",
                                "Parameters",
                                choices = unique(gsub("\\.(.*)", "", levels(plotmigspcr::estimates$term)[-1])),
                                selected = unique(gsub("\\.(.*)", "", levels(plotmigspcr::estimates$term)[-1]))
                            ),
                            style = "border-right: 1px solid; border-right-color: #DDDDDD"
                        ),
                        shiny::column(
                            width = 9,
                            shiny::HTML(
                                "<br>"
                            ),
                            shiny::plotOutput("estimates")
                        )
                    )
                )
            )
        )
    )

    # Return ui object
    return(ui)
}