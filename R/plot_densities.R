#' Plot densities of the imputed values
#'
#' Generate density plots with ggplot.
#'
#' @return Returns the ggplot
#' @author Edoardo Costantini, 2023
#' @param data data.frame in long form (same as \link[plotmigspcr]{mids_imputations})
#' @param var Character vector indicating which variable should be plotted.
#' @examples
#' plot_densities(
#'     data = mids_imputations,
#'     var = "v1"
#' )
#' @export

plot_densities <- function(data, var) {
    # Active data for plot
    mids_imputations_active <- data %>%
        filter(.data$variable == var)

    # Make the plot
    mids_imputations_active %>%
        ggplot2::ggplot(
            ggplot2::aes(
                x = .data$value,
                color = .data$group
            )
        ) +
        ggplot2::geom_density(
            adjust = 1
        ) +
        ggplot2::facet_grid(
            cols = vars(.data$method),
            # rows = vars(group),
            switch = "y"
        ) +
        ggplot2::scale_color_manual(
            values = c(
                "#3780C6",
                rep("#00000054", length(unique(data$.imp)) - 1)
            )
        ) +
        ggplot2::scale_y_continuous(position = "right") +
        ggplot2::scale_x_continuous(
            breaks = seq(
                from = min(mids_imputations_active$value),
                to = max(mids_imputations_active$value),
                by = 1
            ),
            limits = c(
                min(mids_imputations_active$value) - .5,
                max(mids_imputations_active$value) + .5
            )
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
                color = "#00000045"
            ),
            # Legend
            legend.position = "none",
            # Background
            panel.background = ggplot2::element_rect(fill = NA, color = "gray")
        )
}
