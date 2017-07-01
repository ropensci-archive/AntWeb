# AntWeb
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
![CRAN/GitHub 0.7_/_0.7.4.99](https://img.shields.io/badge/CRAN/GitHub-0.7_/_0.7.4.99-blue.svg) 

[__AntWeb__](http://www.antweb.org/) is a repository of ant specimen records maintained by the [California Academy of Sciences](http://www.calacademy.org/). From the website's description:  

> AntWeb is the world's largest online database of images, specimen records, and natural history information on ants. It is community driven and open to contribution from anyone with specimen records, natural history comments, or images.

__Resources__  
* [AntWeb](http://www.antweb.org/)   
* [AntWeb API](http://www.antweb.org/api/)
* [API version 2](http://www.antweb.org/api/v2/)

## Package Status and Installation

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/antweb?branch=master&svg=true)](https://ci.appveyor.com/project/ropensci/antweb)
[![Travis-CI Build Status](https://travis-ci.org/ropensci/antweb.svg?branch=master)](https://travis-ci.org/)
 [![codecov](https://codecov.io/gh/RMHogervorst/antweb/branch/master/graph/badge.svg)](https://codecov.io/gh/RMHogervorst/antweb)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/antweb?color=blue)](https://github.com/metacran/cranlogs.app)

__Installation Instructions__

__Stable version__  

```coffee
install.packages("AntWeb", dependencies = TRUE)
# version 0.6
```

__Development version__  

```coffee
# If you don't already have the devtools package installed, run
# install.packages("devtools")
# unlike most packages, devtools requires additional non-R dependencies depending on your OS. 
# See → https://github.com/ropensci/rOpenSci/wiki/Installing-devtools
library(devtools)
install_github("ropensci/AntWeb", ref = "dev")
```

## Usage

| Function name | Description | Example | 
| ------------- | ----------- | ------- |
| `aw_data`  | Search for data by taxonomic level, full species name, a bounding box, habitat, elevation or type.     |    __Search by a species name__ <br> `aw_data(scientific_name = "acanthognathus brevicornis")` <br> __or by a genus__ <br> `crem <- aw_data(genus = "crematogaster")`  <br> __Search by a bounding box__ <br> `aw_data(bbox = '37.77,-122.46,37.76,-122.47')` <br> __Search by an elevation band__ <br> `aw_data(min_elevation = 1500, max_elevation = 2000)` |
| `aw_unique` | Obtain a list of unique levels by various taxonomic ranks    | `aw_unique(rank = "subfamily")` <br>`genus_list <- aw_unique(rank = "genus")`<br>`aw_unique(rank = "species")` |
| `aw_images` | Search photos by type or time since added.     |    ` aw_images(since = 5)`<br> `aw_images(since = 5, type = "h")` |
| `aw_coords` | Search for specimens by location and radius     |    `aw_coords(coord = "37.76,-122.45", r = 5)` |
| `aw_code` | Search for a specimen by record number   |  `aw_code(occurrenceid = "CAS:ANTWEB:alas188691")` |
| `aw_map` | Map georeferenced data | `adf <- aw_data(genus = "acanthognathus", georeferenced = TRUE)`<br>`aw_map(adf)` |

## Citation

```r
To cite package ‘AntWeb’ in publications use:

  'Karthik Ram' (2014). AntWeb: programmatic interface
  to the AntWeb. R package version 0.7.2.99.
  https://github.com/ropensci/AntWeb

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {AntWeb: programmatic interface to the AntWeb},
    author = {'Karthik Ram'},
    year = {2014},
    note = {R package version 0.7.2.99},
    url = {https://github.com/ropensci/AntWeb},
  }
```

---
  
This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to AntWeb unless your needs are limited to this single source.    

---

### Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/ropensci/AntWeb/issues/new) or send in a pull request.

---

## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.


[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

 
