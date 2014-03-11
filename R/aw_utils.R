#' @noRd
z_compact <- function(l) Filter(Negate(is.null), l)


print.antweb <- function(x, ...) {
cat(sprintf("[Total results on the server]: %s \n", x$count))
cat("[Args]: \n")
suppressWarnings(pretty_lists(x$call))
cat(sprintf("[Limit]: %s \n", x$limit))
cat(sprintf("[Offset]: %s \n", x$offset))
cat(sprintf("[Dataset]: [%s x %s] \n[Data preview] :\n", nrow(x$data), ncol(x$data)))
print(x$data[1:2, ])
}