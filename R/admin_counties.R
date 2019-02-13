#' Shapes of 31 administrative counties in the Republic of Ireland.
#'
#' A database containing shapes of 31 administrative counties and
#' cities in the Republic of Ireland. To be used for producing maps
#' of Census data.
#'
#' This data is dervied from shapefiles created by Ordnance
#' Survey Ireland (OSi), and taken from their Open Data
#' Portal. The OSi has released this data under a
#' standard Creative Commons Licence. For more information
#' see the README file associated with this package.
#'
#' @format A data frame with 57,961 rows and 7 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Vertex order.}
#'   \item{hole}{Vertices assoicated with holes in county shapes.}
#'   \item{piece}{Numbers for different pieces of individual counties.}
#'   \item{County.and.City}{Name of Counties and Cities. Can be matched to Census Data and certain other datasets.}
#'   \item{group}{A combination of County or City name with piece number. To be used as the group option when making maps with ggplot.}
#' }
#' @source \url{https://data-osi.opendata.arcgis.com/}
"admin_counties"
