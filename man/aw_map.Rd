\name{aw_map}
\alias{aw_map}
\title{LeafletJS Map}
\usage{
aw_map(aw_obj, dest = tempdir(), title = "AntWeb species map",
  incl.data = TRUE)
}
\arguments{
  \item{aw_obj}{Result from a search on AntWeb}

  \item{dest}{Location where the html file and geojson file
  should be stored. Default is the temp directory}

  \item{title}{Title of the map.}

  \item{incl.data}{Default is \code{TRUE}. Writes geoJSON
  data into the html file to get around security
  restrictions in browsers like Google Chrome. Set to
  \code{FALSE} to read from a separate local geoJSON file.}
}
\description{
Builds an interactive map of locations for any list of
species
}
\examples{
\dontrun{
 acanthognathus_df <- aw_data(genus = "acanthognathus", georeferenced = TRUE)
 aw_map(acanthognathus_df)
# Or just plot data by habitat. So for e.g. using sandstone as a substrate
sandstone <- aw_data(habitat = "sandstone")
aw_map(sandstone)
}
}
\keyword{map}

