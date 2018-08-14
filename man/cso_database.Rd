\docType{data}
\name{cso_database}
\alias{cso_database}
\title{Database of all CSO Data Tables.}
\format{A data frame with many rows and 2 variables:
    \describe{
      \item{Item}{Full name of table}
      \item{Code}{Five character code for table}
    }}
\source{
  CSO Statbank API,
  \url{https://www.cso.ie/webserviceclient/DatasetListing.aspx}
}
\usage{
  cso_database
}
\description{
  Just a list of the data tables.
}
\examples{
if (require("dplyr")) {
cso_database

}
}
\keyword{datasets}
