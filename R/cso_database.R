#' Database of all CSO data tables.
#'
#' A database containing all of the data tables included
#' on the CSO Statbank website.
#'
#' @format A data frame with many rows and 2 variables:
#' \describe{
#'   \item{Theme}{One of 5 main CSO themes plus the Public Sector Statistics Network}
#'   \item{Section}{Sections within the themes}
#'   \item{Subsection}{Subsections}
#'   \item{Title}{Title of the dataset}
#'   \item{Page.Code}{Full name of data table}
#'   \item{Short.Code}{Code for this dataset. Use this with the get_cso function.}
#' }
#' @source \url{https://www.cso.ie/webserviceclient/DatasetListing.aspx}
"cso_database"
