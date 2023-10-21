# Project:   plotmigspcr
# Objective: container for data documentation
# Author:    Edoardo Costantini
# Created:   2023-09-12
# Modified:  2023-10-21

#' estimates
#'
#' A data.frame containing the parameter estimates for the analysis models of interest.
#'
#' The data.frame columns are:
#'
#' \itemize{
#'   \item \code{term} - the analysis model parameter identifier
#'   \item \code{method} - the missing data treatment used
#'   \item \code{variable} - the outcome measures to consider
#'   \item \code{value} - the values to plot
#' }
#'
#' @docType data
#' @keywords datasets
#' @name estimates
#' @usage data(estimates)
#' @format data.frame, long
NULL

#' mids_chains
#'
#' A data.frame containing chain means and standard deviations for plotting trace plots with ggplot
#' @details
#' These data can be used to plot the progression of imputation means and standard deviations over the iterations.
#' It was obtained by extracting the information needed for this type of plot from the mids objects produced by mice after imputation.
#'
#' @docType data
#' @keywords datasets
#' @name mids_chains
#' @usage data(mids_chains)
#' @format data.frame
NULL

#' mids_imputations
#'
#' A data.frame containing observed values and imputations in long form.
#' 
#' @details
#' These data can be used to plot the density distributions of observed and imputed variables.
#' It was obtained by extracting the information needed for this type of plot from the mids objects produced by mice after imputation.
#'
#' @docType data
#' @keywords datasets
#' @name mids_imputations
#' @usage data(mids_imputations)
#' @format vector
NULL

#' imp_methods
#'
#' A vector containing the names of the imputation methods used for every variable
#'
#' @docType data
#' @keywords datasets
#' @name imp_methods
#' @usage data(imp_methods)
#' @format vector
NULL