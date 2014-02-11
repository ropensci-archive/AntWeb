

#' aw_coords
#'
#' Retrieve AntWeb data by location. A radius argument can be supplied as a search radius around a point on th emap.
#' @param coord Latitude and Longitude. Should be supplied as \code{lat,long}. Example: \code{37.76,-122.45}
#' @param r A radius in kilometers. For 2 km add \code{r = 2}
#' @export
#' @importFrom plyr rbind.fill
#' @return \code{\link{aw_data}}
#' @examples  
#' data_by_loc <- aw_coords(coord = "37.76,-122.45", r = 2)
aw_coords <- function( coord = NULL, r = NULL) {
	assert_that(!is.null(coord) & is.character(coord))

	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(coord = coord, r = r)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	data_list <- lapply(data, function(z) {
		specimen_by_loc <- data.frame(t(unlist(z$meta)))
	})
	data_df <- do.call(rbind.fill, data_list)
	data_df$other <- NULL
	data_df
}

