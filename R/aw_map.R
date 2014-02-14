
#' LeafletJS Map
#'
#' Builds an interactive map of locations for any list of species
#' @param aw_obj Result from a search on AntWeb
#' @param  dest Location where the html file and geojson file should be stored. Default is the temp directory
#' @param  title Title of the map.
#' @param  incl.data Default is \code{TRUE}. Writes geoJSON data into the html file to get around security restrictions in browsers like Google Chrome. Set to \code{FALSE} to read from a separate local geoJSON file.
#' @export
#' @keywords map
#' @import leafletR
#' @examples \dontrun{
#'  acanthognathus_df <- aw_data(genus = "acanthognathus", georeferenced = TRUE)
#'  aw_map(acanthognathus_df)
#'}
aw_map <- function(aw_obj, dest = tempdir(), title = "AntWeb species map", incl.data = TRUE) {
	assert_that(identical(class(aw_obj), "data.frame"))
	# aw_obj <- dplyr::filter(aw_obj, !is.na(meta.decimal_latitude), !is.na(meta.decimal_longitude))
	aw_obj <- subset(aw_obj, !is.na(meta.decimal_latitude) & !is.na(meta.decimal_longitude))
	# THERE IS A PROBLEM HERE
	assert_that(nrow(aw_obj) > 1)
	meta.decimal_latitude <- NULL
	meta.decimal_longitude <- NULL

	dest <- ifelse(is.null(dest), tempdir(), dest)
	aw_obj$scientific_name <- paste0(aw_obj$meta.genus, " ", aw_obj$meta.species)
	species_data <- aw_obj
	ee_geo <- toGeoJSON(data = species_data, name = "temp", dest = dest, lat.lon=c(18, 19))	
	num_species <- length(unique(species_data$scientific_name))
	cols <- c("#8D5C00", "#2F5CD7","#E91974", "#3CB619","#7EAFCC",
"#4F2755","#F5450E","#264C44","#3EA262","#FA43C9","#6E8604","#631D0E","#EE8099","#E5B25A",
"#0C3D8A","#9E4CD3","#195C7B","#9F8450","#7A0666","#BBA3C5","#F064B4","#108223","#553502",
"#17ADE7","#83C445","#C52817","#626302","#9F9215","#6CCD78","#BF3704")

	pal <- cols[1:num_species]
	sty <- styleCat(prop = "scientific_name", val = unique(species_data$scientific_name), style.val = pal, fill.alpha = 1, alpha = 1, rad = 4, leg = "Scientific Name")
	map <- leaflet(ee_geo, base.map="tls", style = sty, popup = "scientific_name", dest = dest, title = title, incl.data = incl.data)
	browseURL(map)
}

