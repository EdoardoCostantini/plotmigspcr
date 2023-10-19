#' Plot imputation chain summaries over iterations
#'
#' Generate trace plots with ggplot.
#'
#' @return Returns the ggplot
#' @author Edoardo Costantini, 2023
#' @param data data.frame in long form (same as \link[plotmigspcr]{mids_chains})
#' @param var Character vector indicating which variable should be plotted.
#' @examples
#' plot_trace(
#'     data = mids_chains,
#'     var = "v1"
#' )
#' @export

plot_trace <- function(data, var) {
    data %>%
        filter(
            .data$variable == var
        ) %>%
        ggplot2::ggplot(
            ggplot2::aes(
                x = .data$iteration,
                y = .data$value,
                group = .data$chain
            )
        ) +
        ggplot2::geom_line(
            ggplot2::aes(color = .data$chain)
        ) +
        ggplot2::facet_grid(
            rows = vars(.data$measure),
            cols = vars(.data$method),
            scales = "free"
        ) +
        ggplot2::theme(
            axis.title.y = ggplot2::element_blank(),
            # Grid
            panel.border = ggplot2::element_rect(
                color = "#D4D4D4",
                fill = NA,
                linewidth = .5
            ),
            # remove the vertical grid lines
            panel.grid.major.x = ggplot2::element_blank(),
            # explicitly set the horizontal lines (or they will disappear too)
            panel.grid.major.y = ggplot2::element_line(
                linewidth = .1,
                color = "black"
            ),
            # Legend
            legend.position = "none",
            # Background
            panel.background = ggplot2::element_rect(fill = NA, color = "gray")
        )
}