\name{aw_photos}
\alias{aw_photos}
\title{aw_photos}
\usage{
aw_photos(since = NULL, type = NULL)
}
\arguments{
  \item{since}{number of days in the past to query}

  \item{type}{h for head, d for dorsal, p for profile, and
  l for label. If a type is not specified, all images are
  retrieved.}
}
\value{
data.frame
}
\description{
Download ant photos based on time elapsed and/or type.
}
\examples{
\dontrun{
z <- aw_photos(since = 5)
z1 <- aw_photos(since = 5, type = "d")
}
}

