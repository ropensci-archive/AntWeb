\name{aw_data}
\alias{aw_data}
\title{Retrieve data from the AntWeb}
\usage{
aw_data(genus = NULL, species = NULL, scientific_name = NULL,
  georeferenced = FALSE, min_date = NULL, max_date = NULL, bbox = NULL,
  limit = NULL, offset = NULL)
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

  \item{bbox}{A lat long bounding box. Format is
  \code{lat,long,lat,long}}

  \item{min_date}{A lower date bound in the format
  \code{yyyy-mm-dd}}

  \item{max_date}{An upper date bound in the format
  \code{yyyy-mm-dd}}

  \item{limit}{A numeric value to limit number of records}

  \item{offset}{An offset best used with limit as a way to
  paginate records}
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
# data_genus_only <- aw_data(genus = "acanthognathus", limit = 5)
# leaf_cutter_ants  <- aw_data(genus = "acromyrmex")
# data  <- aw_data(genus = "Technomyrmex", bbox = '37.77,-122.46,37.76,-122.47')
# fail <- aw_data(scientific_name = "auberti levithorax") # This should fail gracefully
}
\keyword{data}
\keyword{download}

