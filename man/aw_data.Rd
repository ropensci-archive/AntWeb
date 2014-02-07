\name{aw_data}
\alias{aw_data}
\title{Retrieve data from the AntWeb}
\usage{
aw_data(genus = NULL, species = NULL)
}
\arguments{
  \item{genus}{An ant genus name}

  \item{species}{a species name}
}
\value{
data.frame
}
\description{
This function allows data to be queried by any taxonomic
rank or full species name.
}
\examples{
\dontrun{
data <- aw_specimen(genus = "acanthognathus", species = "brevicornis")
}
}
\keyword{data}
\keyword{download}

