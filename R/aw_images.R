
#' aw_images
#'
#' Download ant images based on time elapsed and/or type.
#' @param since number of days in the past to query
#' @param  type h for head, d for dorsal, p for profile, and l for label. If a type is not specified, all images are retrieved.
#' @export
#' @return data.frame
#' @examples \dontrun{
#' z <- aw_images(since = 5)
#' z1 <- aw_images(since = 5, type = "d")
#'}
aw_images <- function(since = NULL, type = NULL) {
	img <- "true"
	base_url <- "http://www.antweb.org/api/"
	args <- z_compact(as.list(c(since = since, img = img, type = type)))
	results <- GET(base_url, query = args)
	stop_for_status(results)
	data <- fromJSON(content(results, "text"))


	data_list <- lapply(data, function(z) {
			collection_date <- z[[1]][[1]]
			photo_list <- z[[1]][2][1]
			photo_data <- lapply(photo_list, function(il) {
				imgg <- list()
				for(i in 1:length(il)) {
					imgg[[i]] <-  data.frame(t(unlist(il[[i]]$img)))
					imgg[[i]]$type <- unlist(names(il[i]))
				}

				img_data <- do.call(rbind, imgg)
				img_data$collection_date <- collection_date
				names(img_data) <- c("high", "med", "low", "thumbnail", "type", "collection_date")
				img_data
			})
			photo_data_df <- do.call(rbind, photo_data)

	})

  final_df <- do.call(rbind, data_list)
rownames(final_df) <- NULL
final_df

}


