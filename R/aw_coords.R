

#' aw_coords
#'
#' Retrieve AntWeb data by location. A radius argument can be supplied as a search radius around a point on th emap.
#' @param  coord Latitude and Longitude. Should be supplied as \code{lat,long}. Example: 37.76,-122.45
#' @param  r A radius in kilometers. For 2 km add \code{r = 2.}
#' @export
#' @return \code{\link{aw_data}}
#' @examples \dontrun{
#' data_by_loc <- aw_coords(coord = "37.76,-122.45", r = 2)
#'}
aw_coords <- function( coord = NULL, r = NULL) {
	assert_that(!is.null(coord) & is.character(coord))

	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(coord = coord, r = r)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	data_list <- lapply(data, function(z) {
		specimen_by_loc <- data.frame(t(z$meta))
	})
	data_df <- do.call(rbind, data_list)
	# Trying to use dplyr's rbind_all fails here.
	# data_df <- rbind_all(data_list)
# 	*** caught segfault ***
# address 0x0, cause 'memory not mapped'

# Traceback:
#  1: .Call("dplyr_rbind_all", PACKAGE = "dplyr", dots)
	data_df$other <- NULL
	data_df
}

