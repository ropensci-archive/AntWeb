\name{aw_cbind}
\alias{aw_cbind}
\title{aw_cbind}
\usage{
aw_cbind(results)
}
\arguments{
  \item{results}{A list of objects of class \code{antweb}}
}
\description{
Allows for combining split AntWeb calls (e.g. paginated
calls) back into one single result object
}
\examples{
\dontrun{
x1 <- aw_data(genus = "crematogaster", georeferenced = TRUE)
x2 <- aw_data(genus = "crematogaster", georeferenced = TRUE, offset = 1000)
x12 <- aw_cbind(list(x1, x2))
}
}

