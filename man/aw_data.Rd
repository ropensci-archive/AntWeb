\name{aw_data}
\alias{aw_data}
\title{Retrieve data from the AntWeb}
\usage{
aw_data(genus = NULL, species = NULL, scientific_name = NULL,
  georeferenced = NULL, min_elevation = NULL, max_elevation = NULL,
  type = NULL, habitat = NULL, min_date = NULL, max_date = NULL,
  bbox = NULL, limit = NULL, offset = NULL, quiet = FALSE)
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

  \item{type}{A holotype}

  \item{habitat}{A fuzzy search by any habitat}

  \item{min_date}{A lower date bound in the format
  \code{yyyy-mm-dd}}

  \item{max_date}{An upper date bound in the format
  \code{yyyy-mm-dd}}

  \item{min_elevation}{A lower elevation bound}

  \item{max_elevation}{An upper elevation bound}

  \item{limit}{A numeric value to limit number of records}

  \item{offset}{An offset best used with limit as a way to
  paginate records}

  \item{quiet}{If true, any informative messages will be
  suppressed}
}
\value{
data.frame
}
\description{
This function allows a user to query the AntWeb database by
any taxonomic rank or full species name.
}
\examples{
# data <- aw_data(genus = "acanthognathus", species = "brevicornis")
# data3 <- aw_data(genus = "acanthognathus", species = "brevicornis", georeferenced = TRUE)
# data2 <- aw_data(scientific_name = "acanthognathus brevicornis")
# sandstone <- aw_data(genus = "Aphaenogaster", habitat = "sandstone")
# data_genus_only <- aw_data(genus = "acanthognathus", limit = 25)
# leaf_cutter_ants  <- aw_data(genus = "acromyrmex")
# data  <- aw_data(genus = "Technomyrmex", bbox = '37.77,-122.46,37.76,-122.47')
# Search just using a bounding box
# data  <- aw_data(bbox = '37.77,-122.46,37.76,-122.47')
# Search by a elevation band
# aw_data(min_elevation = 1500, max_elevation = 2000)
# When you throw a really specimen rich band like below, you'll get a huge number of requests.
# Only the first 1000 records will download first.
# aw_data(min_elevation = 200, max_elevation = 400)
# aw_data(min_date = '1980-01-01', max_date = '1981-01-01')
# fail <- aw_data(scientific_name = "auberti levithorax") # This should fail gracefully
}
\keyword{data}
\keyword{download}

