#' @noRd
z_compact <- function(l) Filter(Negate(is.null), l)


#' @noRd
#' keyword Internal
pretty_lists <- function(x)
{
   for(key in names(x)){
      value <- format(x[[key]])
      if(value == "") next
      cat(key, "=", value, "\n")
   }
   invisible(x)
}


#' Print a summary for an antweb object
#' @method print antweb
#' @S3method print antweb
#' @param x An object of class \code{antweb}
#'   
#' @param ... additional arguments
print.antweb <- function(x, ...) {
cat(sprintf("[Total results on the server]: %s \n", x$count))
cat("[Args]: \n")
suppressWarnings(pretty_lists(x$call))
cat(sprintf("[Limit]: %s \n", x$limit))
cat(sprintf("[Offset]: %s \n", x$offset))
cat(sprintf("[Dataset]: [%s x %s] \n[Data preview] :\n", nrow(x$data), ncol(x$data)))
print(x$data[1:2, ])
}


