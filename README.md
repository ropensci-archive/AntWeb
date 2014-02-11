# AntWeb
![](https://travis-ci.org/ropensci/AntWeb.png?branch=master)

[__AntWeb__](http://www.antweb.org/) is a repository of ant specimen records maintained by the [California Academy of Sciences](http://www.calacademy.org/). From the website's description:
> AntWeb is the world's largest online database of images, specimen records, and natural history information on ants. It is community driven and open to contribution from anyone with specimen records, natural history comments, or images.

__Resources__  
* [AntWeb](http://www.antweb.org/)   
* [AntWeb API](http://www.antweb.org/api/)

## Installing the package

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
| `aw_data`  | Search for data by taxonomic level or full species name     |    `aw_data(scientific_name = "acanthognathus brevicornis")` |
| `aw_unique` | Obtain a list of unique levels by various taxonomic ranks    | `aw_unique(rank = "subfamily")` <br>`genus_list <- aw_unique(rank = "genus")`<br>`aw_unique(rank = "species")` |
| `aw_images` | Search photos by type or time since added.     |    ` aw_images(since = 5)`<br> `aw_images(since = 5, type = "h")` |
| `aw_coords` | Search for specimens by location and radius     |    `aw_coords(coord = "37.76,-122.45", r = 5)` |
| `aw_code` | Search for a specimen by record number   |  `aw_code(code = "casent0104669")` |
| `aw_map` | Map georeferenced data | `adf <- aw_data(genus = "acanthognathus", georeferenced = TRUE)`<br>`aw_map(adf)` |


## Citation

```coffee
To cite package ‘AntWeb’ in publications use:

  'Karthik Ram' (2014). AntWeb: programmatic interface
  to the AntWeb. R package version 0.1.
  https://github.com/ropensci/AntWeb

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {AntWeb: programmatic interface to the AntWeb},
    author = {'Karthik Ram'},
    year = {2014},
    note = {R package version 0.4},
    url = {https://github.com/ropensci/AntWeb},
  }

```
## Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/ropensci/AntWeb/issues/new) or send in a pull request.

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

 