#' Plot parameter estimation results
#'
#' Generate plots for parameter estimates.
#'
#' @return Returns the ggplot
#' @author Edoardo Costantini, 2023
#' @param gg_shape Data in a long form (same as \link[plotmigspcr]{estimates})
#' @param terms Character vector naming the predictors for which you want to plot the regression coefficient estimates. Possible values are `levels(estimates$term)`
#' @param approach Character vector naming the missing data handling techniques you want to plot. Possible values are `levels(estimates$method)`
#' @param outcome Character vector naming the outcome measures you want to plot. Possible values are `levels(estimates$variable)`
#' @examples
#' plot_estimates(
#'      gg_shape = estimates,
#'      terms = levels(estimates$term)[-1],
#'      approach = levels(estimates$method),
#'      outcome = c("estimate", "t")
#' )
#' @export

plot_estimates <- function(gg_shape, terms, approach, outcome) {
    gg_shape %>%
        dplyr::filter(
            term %in% terms,
            variable %in% outcome,
            method %in% approach
        ) %>%
        dplyr::mutate(value = abs(value)) %>%
        ggplot(
            aes(
                x = term,
                y = value,
                fill = method
            )
        ) +
        scale_fill_manual(values = c("#aaaaaa", "#D4D4D4", "#ffffff")) +
        geom_bar(
            stat = "identity",
            position = position_dodge(),
            colour = "black",
            alpha = 0.75
        ) +
        facet_grid(
            rows = "variable",
            scales = "free",
            switch = "y"
        ) + 
        theme(
            # X axis layout
            axis.text.x = element_text(
                angle = 315,
                vjust = 0.5,
                hjust = 0
            ),
            axis.ticks.x = element_blank(),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            # Grid
            panel.border = element_rect(
                color = "#D4D4D4",
                fill = NA,
                linewidth = .5
            ),
            # remove the vertical grid lines
            panel.grid.major.x = element_blank(),
            # explicitly set the horizontal lines (or they will disappear too)
            panel.grid.major.y = element_line(
                linewidth = .1,
                color = "black"
            ),
            # Legend
            legend.title = element_blank(),
            legend.key.size = unit(0.3, "cm"),
            # Background
            panel.background = element_rect(fill = NA, color = "gray")
        )
}
