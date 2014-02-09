
context("Ant Data")

test_that("We are able to retreive all ant data correctly", {
	ad <- aw_data(genus = "acanthognathus", species = "brevicornis")
	expect_is(ad, "data.frame")
	expect_error(aw_data())
})

context("Data by specimen id works correctly")

test_that("Specimen collections work correctly", {
	data_by_code <- aw_code(code = "casent0104669")
	expect_is(data_by_code, "list")
	genus_list <- aw_unique(rank = "genus")
	expect_is(genus_list, "data.frame")
	expect_equal(ncol(genus_list), 1)
	fail <- aw_data(scientific_name = "auberti levithorax")
	expect_is(fail, "NULL")
	fake_code <- aw_code(code = "casent0104669asdsa")
	expect_is(fake_code, "NULL")
}) 


test_that("We can correctly retrieve data by coordinates", {
data_by_loc <- aw_coords(coord = "37.76,-122.45", r = 2)
expect_is(data_by_loc, "data.frame")
expect_error(aw_coords())
})

context("Photos")

test_that("Photos work correctly", {
	z <- aw_images(since = 5)
	z1 <- aw_images(since = 5, type = "d")
	expect_is(z, "data.frame")
	expect_is(z1, "data.frame")
	expect_equal(unique(z1$type), "d")
})