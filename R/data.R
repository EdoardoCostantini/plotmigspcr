# Project:   plotmigspcr
# Objective: container for data documentation
# Author:    Edoardo Costantini
# Created:   2023-09-12
# Modified:  2023-09-12

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

#' mids_migspcr
#'
#' A mids object containing the information about the imputation performed with MI-GSPCR
#'
#' See \link[mice]{mids-class} help file for details.
#'
#' @docType data
#' @keywords datasets
#' @name mids_migspcr
#' @usage data(mids_migspcr)
#' @format mids
NULL

#' mids_miexpert
#'
#' A mids object containing the information about the imputation performed with MI-expert
#'
#' See \link[mice]{mids-class} help file for details.
#'
#' @docType data
#' @keywords datasets
#' @name mids_miexpert
#' @usage data(mids_miexpert)
#' @format mids
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