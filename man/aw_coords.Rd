\name{aw_coords}
\alias{aw_coords}
\title{aw_coords}
\usage{
aw_coords(coord = NULL, r = NULL)
}
\arguments{
  \item{coord}{Latitude and Longitude. Should be supplied
  as \code{lat,long}. Example: \code{37.76,-122.45}}

  \item{r}{A radius in kilometers. For 2 km add \code{r =
  2}}
}
\value{
\code{\link{aw_data}}
}
\description{
Retrieve AntWeb data by location. A radius argument can be
supplied as a search radius around a point on th emap.
}
\examples{
# data_by_loc <- aw_coords(coord = "37.76,-122.45", r = 2)
}

