\name{aw_data}
\alias{aw_data}
\title{Retrieve data from the AntWeb}
\usage{
aw_data(genus = NULL, species = NULL, scientific_name = NULL)
}
\arguments{
  \item{genus}{An ant genus name}

  \item{species}{a species name}

  \item{scientific_name}{An easier way to pass the Genus
  and species name together, especially when the data are
  derived from other packages.}
}
\value{
data.frame
}
\description{
This function allows a user to query the AntWeb database by
any taxonomic rank or full species name.
}
\examples{
\dontrun{
data <- aw_data(genus = "acanthognathus", species = "brevicornis")
data2 <- aw_data(scientific_name = "acanthognathus brevicornis")
data_genus_only <- aw_data(genus = "acanthognathus")
}
}
\keyword{data}
\keyword{download}

