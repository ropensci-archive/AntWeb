# AntWeb
![](https://travis-ci.org/ropensci/AntWeb.png?branch=master)

[__AntWeb__](http://www.antweb.org/) is a repository of ant specimen records maintained by the [California Academy of Sciences](http://www.calacademy.org/). From the website's description:
> AntWeb is the world's largest online database of images, specimen records, and natural history information on ants. It is community driven and open to contribution from anyone with specimen records, natural history comments, or images.

__Resources__  
* [AntWeb](http://www.antweb.org/)   
* [AntWeb API](http://www.antweb.org/api/)
* [API version 2](http://www.antweb.org/api/v2/)

## Installing the package

__Stable version__  

```coffee
install.packages("AntWeb", dependencies = TRUE)
# due to a small bug, maps does not work in this version. 
# Use the development version until version 0.6 becomes available on CRAN
```

__Development version__  

```coffee
# If you don't already have the devtools package installed, run
# install.packages("devtools")
# unlike most packages, devtools requires additional non-R dependencies depending on your OS. 
# See → https://github.com/ropensci/rOpenSci/wiki/Installing-devtools
library(devtools)
install_github("ropensci/AntWeb")
```

## Quick usage guide

| Function name | Description | Example | 
| ------------- | ----------- | ------- |
| `aw_data`  | Search for data by taxonomic level, full species name, a bounding box, habitat, elevation or type.     |    __Search by a species name__ <br> `aw_data(scientific_name = "acanthognathus brevicornis")` <br> __or by a genus__ <br> `crem <- aw_data(genus = "crematogaster")`  <br> __Search by a bounding box__ <br> `aw_data(bbox = '37.77,-122.46,37.76,-122.47')` <br> __Search by an elevation band__ <br> `aw_data(min_elevation = 1500, max_elevation = 2000)` |
| `aw_unique` | Obtain a list of unique levels by various taxonomic ranks    | `aw_unique(rank = "subfamily")` <br>`genus_list <- aw_unique(rank = "genus")`<br>`aw_unique(rank = "species")` |
| `aw_images` | Search photos by type or time since added.     |    ` aw_images(since = 5)`<br> `aw_images(since = 5, type = "h")` |
| `aw_coords` | Search for specimens by location and radius     |    `aw_coords(coord = "37.76,-122.45", r = 5)` |
| `aw_code` | Search for a specimen by record number   |  `aw_code(occurrenceid = "antweb:inb0003695883") ` |
| `aw_map` | Map georeferenced data | `adf <- aw_data(genus = "acanthognathus", georeferenced = TRUE)`<br>`aw_map(adf)` |

## Citation

```coffee
To cite package ‘AntWeb’ in publications use:

  'Karthik Ram' (2014). AntWeb: programmatic interface
  to the AntWeb. R package version 0.6.
  https://github.com/ropensci/AntWeb

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {AntWeb: programmatic interface to the AntWeb},
    author = {'Karthik Ram'},
    year = {2014},
    note = {R package version 0.6},
    url = {https://github.com/ropensci/AntWeb},
  }

```
## Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/ropensci/AntWeb/issues/new) or send in a pull request.

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

 
