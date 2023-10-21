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
#'
#' See \link[mice]{mids-class} help file for details.
#'
#' @docType data
#' @keywords datasets
#' @name mids_chains
#' @usage data(mids_chains)
#' @format data.frame
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