
#'Retrieve data from the AntWeb
#'
#' This function allows a user to query the AntWeb database by any taxonomic rank or full species name.
#' @param genus An ant genus name
#' @param  species a species name
#' @param  scientific_name An easier way to pass the Genus and species name together, especially when the data are derived from other packages.
#' @param  georeferenced Default is \code{FALSE}. Set to \code{TRUE} to return only data with lat/long information. Note that this filtering takes place on the client-side, not server side.
#' @export
#' @keywords data download
#' @importFrom rjson fromJSON
#' @importFrom assertthat assert_that
#' @import httr
#' @return data.frame
#' @examples   
#' data <- aw_data(genus = "acanthognathus", species = "brevicornis")
#' # data2 <- aw_data(scientific_name = "acanthognathus brevicornis")
#' # data_genus_only <- aw_data(genus = "acanthognathus")
#' # leaf_cutter_ants  <- aw_data(genus = "acromyrmex")
#' # fail <- aw_data(scientific_name = "auberti levithorax") # This should fail gracefully
aw_data <- function(genus = NULL, species = NULL, scientific_name = NULL, georeferenced = FALSE) {


	assert_that(!is.null(scientific_name) | !is.null(genus))
	meta.decimal_latitude <- NA
	meta.decimal_longitude <- NA
	if(!is.null(scientific_name)) {
		genus <- strsplit(scientific_name, " ")[[1]][1]
		species <- strsplit(scientific_name, " ")[[1]][2]
	}
	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(genus = genus, species = species)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	if(identical(data, "No records were found.")) {
		NULL 
	} else {
	data_df <- lapply(data, function(x){ 
	df <- data.frame(t(unlist(x)))
	df$other <- NULL
	df
})
	final_df <- data.frame(do.call(rbind.fill, data_df))
	final_df$meta.other <- NULL
	if(!georeferenced) {
		final_df
	} else {
		# dplyr::filter(final_df, !is.na(meta.decimal_latitude), !is.na(meta.decimal_longitude))
		subset(final_df, !is.na(meta.decimal_latitude) & !is.na(meta.decimal_longitude))
	}

}
}	



#' aw_unique
#'
#' Get a list of unique names within any taxonomic rank
#' @param rank  A taxonomic rank. Allowed values are  \code{subfamily}, \code{genus} or \code{species}
#' @param  name Optional. If left blank, the query will return a list of all unique names inside the supplied rank.
#' @export
#' @seealso \code{\link{aw_data}}
#' @return data.frame
#' @examples  \dontrun{
#' subfamily_list <- aw_unique(rank = "subfamily")
#' genus_list <- aw_unique(rank = "genus")
#' species_list <- aw_unique(rank = "species")
#'}
aw_unique <- function(rank = NULL, name = NULL) {

	assert_that(!is.null(z_compact(c(rank, name))))
	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(rank = rank, name = name)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))
	data.frame(do.call(rbind, data))
}

