#' aw_code
#'
#' Retrieve data by specimen id
#' @param code A unique id in the AntWeb database identifying a particular specimen
#' @export
#' @seealso \code{\link{aw_data}}
#' @return list
#' @examples 
#' data_by_code <- aw_code(code = "casent0104669") 
aw_code <- function(code = NULL) {

	assert_that(!is.null(code) & is.character(code))

	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(code = code)))
	results <- GET(base_url, query = args)

	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	if(identical(data, "No records found.")) {
		NULL 
	} else {
	metadata_df <- data.frame(t(unlist(data[[1]])))
	images <- data[[2]]
	image_data <- lapply(images[[1]][[2]], function(x) { data.frame(t(unlist(x)))})
	image_data_df <- do.call(rbind, image_data)
	image_data_df$location <- names(image_data)
	names(image_data_df)[1:4] <- c("high", "med", "low", "thumbnail")
	# Combine the metadata and photo data into a list
	list(metadata = metadata_df, image_data = image_data_df)
	}
}