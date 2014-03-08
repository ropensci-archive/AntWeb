#' aw_code
#'
#' Retrieve data by specimen id
#' @param occurrenceid A unique id in the AntWeb database identifying a particular specimen
#' @export
#' @seealso \occurrenceid{\link{aw_data}}
#' @return list
#' @examples 
#' data_by_code <- aw_code(occurrenceid = "antweb:inb0003695883") 
aw_code <- function(occurrenceid = NULL) {

	assert_that(!is.null(occurrenceid) & is.character(occurrenceid))

	occurrenceid <- tolower(occurrenceid)
	base_url <- "http://www.antweb.org/api/v2"
	args <- z_compact(as.list(c(occurrenceId = occurrenceid)))
	results <- GET(base_url, query = args)

	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	data.frame(t(unlist(data[2])))
}
# [BUG]
# Need to coerce dates correctly.
# Print counts, also add to object. Create a S3 class.