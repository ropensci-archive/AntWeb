\name{aw_code}
\alias{aw_code}
\title{aw_code}
\usage{
aw_code(code = NULL)
}
\arguments{
  \item{code}{A unique id in the AntWeb database
  identifying a particular specimen}
}
\value{
list
}
\description{
Retrieve data by specimen id
}
\examples{
data_by_code <- aw_code(code = "casent0104669")
}
\seealso{
\code{\link{aw_data}}
}

