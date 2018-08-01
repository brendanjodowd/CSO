\name{get_cso}
\alias{get_cso}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Retrieves CSO Statbank Tables
}
\description{
This function retrieves named data tables from the CSO website
}
\usage{
get_cso(table_name)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{table_name}{
A code for a CSO Statbank table. A string of length 5 (3 letters and two digits).
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
A dataframe
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Brendan O'Dowd
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
mydata <- get_cso("AIA30")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
