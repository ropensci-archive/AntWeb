
#'Retrieve data from the AntWeb
#'
#' This function allows data to be queried by any taxonomic rank or full species name.
#' @param genus An ant genus name
#' @param  species a species name
#' @export
#' @keywords data download
#' @importFrom plyr ldply
#' @importFrom rjson fromJSON
#' @importFrom assertthat assert_that
#' @import httr
#' @return data.frame
#' @examples \dontrun{
#' data <- aw_specimen(genus = "acanthognathus", species = "brevicornis")
#' data_genus_only <- aw_specimen(genus = "acanthognathus")
#'}
aw_data <- function(genus = NULL, species = NULL) {
	assert_that(is.character(genus))
	base_url <- "http://www.antweb.org/api/"
	args <- compact(as.list(c(genus = genus, species = species)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	data_df <- ldply(data, function(x){ 
	df <- data.frame(t(unlist(x)))
	df$other <- NULL
	df
})
}	
