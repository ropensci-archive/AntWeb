\name{aw_images}
\alias{aw_images}
\title{aw_images}
\usage{
aw_images(since = NULL, type = NULL)
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
Download ant images based on time elapsed and/or type.
}
\examples{
\dontrun{
z <- aw_images(since = 5)
z1 <- aw_images(since = 5, type = "d")
}
}

