\name{aw_data}
\alias{aw_data}
\title{Retrieve data from the AntWeb}
\usage{
aw_data(genus = NULL, species = NULL, scientific_name = NULL,
  georeferenced = FALSE)
}
\arguments{
  \item{genus}{An ant genus name}

  \item{species}{a species name}

  \item{scientific_name}{An easier way to pass the Genus
  and species name together, especially when the data are
  derived from other packages.}

  \item{georeferenced}{Default is \code{FALSE}. Set to
  \code{TRUE} to return only data with lat/long
  information. Note that this filtering takes place on the
  client-side, not server side.}
}
\value{
data.frame
}
\description{
This function allows a user to query the AntWeb database by
any taxonomic rank or full species name.
}
\examples{
data <- aw_data(genus = "acanthognathus", species = "brevicornis")
data3 <- aw_data(genus = "acanthognathus", species = "brevicornis", georeferenced = TRUE)
# data2 <- aw_data(scientific_name = "acanthognathus brevicornis")
# data_genus_only <- aw_data(genus = "acanthognathus")
# leaf_cutter_ants  <- aw_data(genus = "acromyrmex")
# fail <- aw_data(scientific_name = "auberti levithorax") # This should fail gracefully
}
\keyword{data}
\keyword{download}

