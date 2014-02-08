\name{aw_unique}
\alias{aw_unique}
\title{aw_unique}
\usage{
aw_unique(rank = NULL, name = NULL)
}
\arguments{
  \item{rank}{A taxonomic rank. Allowed values are
  \code{subfamily}, \code{genus} or \code{species}}

  \item{name}{Optional. If left blank, the query will
  return a list of all unique names inside the supplied
  rank.}
}
\value{
data.frame
}
\description{
Get a list of unique names within any taxonomic rank
}
\examples{
\dontrun{
subfamily_list <- aw_unique(rank = "subfamily")
genus_list <- aw_unique(rank = "genus")
species_list <- aw_unique(rank = "species")
}
}
\seealso{
\code{\link{aw_data}}
}

