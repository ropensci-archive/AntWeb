# An example for making R calls to the AntWeb API

```coffee
# We'll use the httr library to make web calls
library(httr) 
library(rjson) # to parse the json
library(plyr) # to convert lists to data.frames
library(assertthat) # To make assertions for right inputs
# If you don't have these packages run:
# install.packages(c("httr", "plyr", "rjson", "assertthat"))
```



```coffee
example_url <- "http://www.antweb.org/api/?genus=acanthognathus&species=brevicornis"
# Make a web call
call <- GET(example_url)
# Retrive the data as text since it's already in JSON
data <- fromJSON(content(call, "text"))
# Now coerce the list to a data.frame
data_df <- ldply(data, function(x) { 
	df <- data.frame(t(unlist(x)))
	# There is one field which is a big dump of field names. So I just remove it here
	df$other <- NULL
	df
})

data_df # This is the final outcome from the call that a  user can use downstream.
```

```
#>            code                           taxon_name subgenus      tribe
#> 1 casent0280684 myrmicinaeacanthognathus brevicornis            dacetini
#> 2 casent0637708 myrmicinaeacanthognathus brevicornis          dacetonini
#>   speciesgroup  subfamily          genus     species type subspecies
#> 1              myrmicinae acanthognathus brevicornis                
#> 2              myrmicinae acanthognathus brevicornis                
#>    country adm2          adm1                 localityname localitycode
#> 1 Colombia                    Las Naranjas near Josc Maria   Josc Maria
#> 2     Peru      Madre de Dios    Tambopata Research Center    JTL060117
#>   collectioncode biogeographicregion       last_modified
#> 1      ANTC19540           Neotropic 2014-01-30 13:48:18
#> 2  TRC-S06-R1C04           Neotropic 2014-01-22 09:42:56
#>                    habitat  method             ownedby collectedby  caste
#> 1                                  BMNH, London, U. K.  D. Jackson     1w
#> 2 Mixed terra firme forest winkler                       D. Feener worker
#>   access_group locatedat determinedby    medium access_login
#> 1            1      BMNH                    pin           23
#> 2            2      JTLC   J. Longino dry mount            2
#>   latlonmaxerror          microhabitat elevationmaxerror localitynotes
#> 1                                                                     
#> 2           100m ex sifted leaf litter                                
#>   dnaextractionnotes  specimennotes             created     family
#> 1                    BMNH(E)1017559 2014-01-30 13:48:18 formicidae
#> 2                                   2014-01-22 09:42:56 formicidae
#>   collectionnotes datecollectedstart datecollectedstartstr
#> 1                         1977-08-08            8 Aug 1977
#> 2                         2001-11-01            1 Nov 2001
#>   datecollectedendstr datedeterminedstr kingdom_name phylum_name
#> 1                                           animalia  arthropoda
#> 2                           12 Sep 2013     animalia  arthropoda
#>   class_name  order_name image_count decimal_latitude decimal_longitude
#> 1    insecta hymenoptera           5             <NA>              <NA>
#> 2    insecta hymenoptera           0        -13.14142           -69.623
#>   elevation datedetermined
#> 1      <NA>           <NA>
#> 2       252     2013-09-12
```




We can turn this into a full on function that will work for any species name or genus. Here we input both the genus and/or species as arguments, make sure they are characters. Then make a call, check that we got a valid response, and format the results back to a data.frame that R can understand.



```coffee
aw_specimen <- function(genus = NULL, species = NULL) {
	# These assertions make sure we are not passing NULLs for the genus
	# Species name remains optional
	assert_that(is.character(genus))
	base_url <- "http://www.antweb.org/api/"
	# Format the input arguments as a list
	args <- compact(as.list(c(genus = genus, species = species)))
	# Pass that to the API
	results <- GET(base_url, query = args)
	# This checks to make sure we didn't hit a 404 or other unwanted http response codes
	stop_for_status(results)
	# Now get the JSON data
	data <- fromJSON(content(results, "text"))
	# Format to a clean data.frame
	data_df <- ldply(data, function(x){ 
	df <- data.frame(t(unlist(x)))
	df$other <- NULL
	df
})
	data_df # Return that out of the functionu
}
```


Now we can call the function.


```coffee
data <- aw_specimen(genus = "acanthognathus", species = "brevicornis")
# By skipping species, we can get all the data from the genus.
acanthognathus_data <- aw_specimen(genus = "acanthognathus")
str(data)
```

```
#> 'data.frame':	2 obs. of  50 variables:
#>  $ code                 : chr  "casent0280684" "casent0637708"
#>  $ taxon_name           : chr  "myrmicinaeacanthognathus brevicornis" "myrmicinaeacanthognathus brevicornis"
#>  $ subgenus             : chr  "" ""
#>  $ tribe                : chr  "dacetini" "dacetonini"
#>  $ speciesgroup         : chr  "" ""
#>  $ subfamily            : chr  "myrmicinae" "myrmicinae"
#>  $ genus                : chr  "acanthognathus" "acanthognathus"
#>  $ species              : chr  "brevicornis" "brevicornis"
#>  $ type                 : chr  "" ""
#>  $ subspecies           : chr  "" ""
#>  $ country              : chr  "Colombia" "Peru"
#>  $ adm2                 : chr  "" ""
#>  $ adm1                 : chr  "" "Madre de Dios"
#>  $ localityname         : chr  "Las Naranjas near Josc Maria" "Tambopata Research Center"
#>  $ localitycode         : chr  "Josc Maria" "JTL060117"
#>  $ collectioncode       : chr  "ANTC19540" "TRC-S06-R1C04"
#>  $ biogeographicregion  : chr  "Neotropic" "Neotropic"
#>  $ last_modified        : chr  "2014-01-30 13:48:18" "2014-01-22 09:42:56"
#>  $ habitat              : chr  "" "Mixed terra firme forest"
#>  $ method               : chr  "" "winkler"
#>  $ ownedby              : chr  "BMNH, London, U. K." ""
#>  $ collectedby          : chr  "D. Jackson" "D. Feener"
#>  $ caste                : chr  "1w" "worker"
#>  $ access_group         : chr  "1" "2"
#>  $ locatedat            : chr  "BMNH" "JTLC"
#>  $ determinedby         : chr  "" "J. Longino"
#>  $ medium               : chr  "pin" "dry mount"
#>  $ access_login         : chr  "23" "2"
#>  $ latlonmaxerror       : chr  "" "100m"
#>  $ microhabitat         : chr  "" "ex sifted leaf litter"
#>  $ elevationmaxerror    : chr  "" ""
#>  $ localitynotes        : chr  "" ""
#>  $ dnaextractionnotes   : chr  "" ""
#>  $ specimennotes        : chr  "BMNH(E)1017559" ""
#>  $ created              : chr  "2014-01-30 13:48:18" "2014-01-22 09:42:56"
#>  $ family               : chr  "formicidae" "formicidae"
#>  $ collectionnotes      : chr  "" ""
#>  $ datecollectedstart   : chr  "1977-08-08" "2001-11-01"
#>  $ datecollectedstartstr: chr  "8 Aug 1977" "1 Nov 2001"
#>  $ datecollectedendstr  : chr  "" ""
#>  $ datedeterminedstr    : chr  "" "12 Sep 2013"
#>  $ kingdom_name         : chr  "animalia" "animalia"
#>  $ phylum_name          : chr  "arthropoda" "arthropoda"
#>  $ class_name           : chr  "insecta" "insecta"
#>  $ order_name           : chr  "hymenoptera" "hymenoptera"
#>  $ image_count          : chr  "5" "0"
#>  $ decimal_latitude     : chr  NA "-13.14142"
#>  $ decimal_longitude    : chr  NA "-69.623"
#>  $ elevation            : chr  NA "252"
#>  $ datedetermined       : chr  NA "2013-09-12"
```

```coffee
str(acanthognathus_data)
```

```
#> 'data.frame':	429 obs. of  74 variables:
#>  $ meta.code                 : chr  "jtl702874" "jtl702875" "jtl702876" "jtl702877" ...
#>  $ meta.taxon_name           : chr  "myrmicinaeacanthognathus (indet)" "myrmicinaeacanthognathus (indet)" "myrmicinaeacanthognathus (indet)" "myrmicinaeacanthognathus (indet)" ...
#>  $ meta.subgenus             : chr  "" "" "" "" ...
#>  $ meta.tribe                : chr  "dacetonini" "dacetonini" "dacetonini" "dacetonini" ...
#>  $ meta.speciesgroup         : chr  "" "" "" "" ...
#>  $ meta.subfamily            : chr  "myrmicinae" "myrmicinae" "myrmicinae" "myrmicinae" ...
#>  $ meta.genus                : chr  "acanthognathus" "acanthognathus" "acanthognathus" "acanthognathus" ...
#>  $ meta.species              : chr  "(indet)" "(indet)" "(indet)" "(indet)" ...
#>  $ meta.other                : chr  "<features><preparedby>B. Boudinot</preparedby><dateprepared>28 Aug 2013</dateprepared><abundance>0</abundance><spcmauxfields>0<"| __truncated__ "<features><preparedby>B. Boudinot</preparedby><dateprepared>28 Aug 2013</dateprepared><abundance>0</abundance><spcmauxfields>0<"| __truncated__ "<features><preparedby>B. Boudinot</preparedby><dateprepared>28 Aug 2013</dateprepared><abundance>0</abundance><spcmauxfields>0<"| __truncated__ "<features><preparedby>B. Boudinot</preparedby><dateprepared>28 Aug 2013</dateprepared><abundance>0</abundance><spcmauxfields>0<"| __truncated__ ...
#>  $ meta.type                 : chr  "" "" "" "" ...
#>  $ meta.subspecies           : chr  "" "" "" "" ...
#>  $ meta.country              : chr  "Costa Rica" "Costa Rica" "Costa Rica" "Costa Rica" ...
#>  $ meta.adm2                 : chr  "La Virgen" "La Virgen" "La Virgen" "La Virgen" ...
#>  $ meta.adm1                 : chr  "Heredia" "Heredia" "Heredia" "Heredia" ...
#>  $ meta.localityname         : chr  "11km ESE La Virgen" "11km ESE La Virgen" "11km ESE La Virgen" "11km SE La Virgen" ...
#>  $ meta.localitycode         : chr  "TB-0300" "TB-0300" "TB-0300" "TB-0500" ...
#>  $ meta.collectioncode       : chr  "03/M/all" "03/M/all" "03/TN/all" "05/M/all" ...
#>  $ meta.biogeographicregion  : chr  "Neotropic" "Neotropic" "Neotropic" "Neotropic" ...
#>  $ meta.decimal_latitude     : chr  "10.35" "10.35" "10.35" "10.33333" ...
#>  $ meta.decimal_longitude    : chr  "-84.05" "-84.05" "-84.05" "-84.06667" ...
#>  $ meta.last_modified        : chr  "2014-01-22 09:42:31" "2014-01-22 09:42:31" "2014-01-22 09:42:31" "2014-01-22 09:42:31" ...
#>  $ meta.habitat              : chr  "wet forest" "wet forest" "montane wet forest" "montane wet forest" ...
#>  $ meta.method               : chr  "Malaise" "Malaise" "flight intercept trap" "Malaise" ...
#>  $ meta.ownedby              : chr  "JTLC" "JTLC" "JTLC" "JTLC" ...
#>  $ meta.collectedby          : chr  "ALAS" "ALAS" "ALAS" "ALAS" ...
#>  $ meta.caste                : chr  "male" "male" "male" "male" ...
#>  $ meta.access_group         : chr  "2" "2" "2" "2" ...
#>  $ meta.locatedat            : chr  "BEBC" "BEBC" "BEBC" "BEBC" ...
#>  $ meta.determinedby         : chr  "B. Boudinot" "B. Boudinot" "B. Boudinot" "B. Boudinot" ...
#>  $ meta.medium               : chr  "95% ethanol" "95% ethanol" "95% ethanol" "95% ethanol" ...
#>  $ meta.access_login         : chr  "2" "2" "2" "2" ...
#>  $ meta.elevation            : chr  "300" "300" "300" "500" ...
#>  $ meta.latlonmaxerror       : chr  "" "" "" "minute" ...
#>  $ meta.microhabitat         : chr  "" "" "bajo de M/01" "" ...
#>  $ meta.datedetermined       : chr  "2013-08-28" "2013-08-28" "2013-08-28" "2013-08-28" ...
#>  $ meta.elevationmaxerror    : chr  "" "" "" "" ...
#>  $ meta.localitynotes        : chr  "" "" "" "" ...
#>  $ meta.dnaextractionnotes   : chr  "" "" "" "" ...
#>  $ meta.specimennotes        : chr  "" "" "" "" ...
#>  $ meta.created              : chr  "2014-01-22 09:42:31" "2014-01-22 09:42:31" "2014-01-22 09:42:31" "2014-01-22 09:42:31" ...
#>  $ meta.family               : chr  "formicidae" "formicidae" "formicidae" "formicidae" ...
#>  $ meta.collectionnotes      : chr  "NOTEBY J. Longino, NOTEDATE 7-May-07: I have a jar with all formicidae workers and alates pooled. All ant workers have been pro"| __truncated__ "NOTEBY J. Longino, NOTEDATE 7-May-07: I have a jar with all formicidae workers and alates pooled. All ant workers have been pro"| __truncated__ "" "" ...
#>  $ meta.datecollectedstart   : chr  "2004-02-12" "2004-02-12" "2004-02-13" "2003-02-12" ...
#>  $ meta.datecollectedend     : chr  "2004-04-18" "2004-04-18" "2004-04-18" "2003-04-20" ...
#>  $ meta.datecollectedstartstr: chr  "12 Feb 2004" "12 Feb 2004" "13 Feb 2004" "12 Feb 2003" ...
#>  $ meta.datecollectedendstr  : chr  "18 Apr 2004" "18 Apr 2004" "18 Apr 2004" "20 Apr 2003" ...
#>  $ meta.datedeterminedstr    : chr  "28 Aug 2013" "28 Aug 2013" "28 Aug 2013" "28 Aug 2013" ...
#>  $ meta.kingdom_name         : chr  "animalia" "animalia" "animalia" "animalia" ...
#>  $ meta.phylum_name          : chr  "arthropoda" "arthropoda" "arthropoda" "arthropoda" ...
#>  $ meta.class_name           : chr  "insecta" "insecta" "insecta" "insecta" ...
#>  $ meta.order_name           : chr  "hymenoptera" "hymenoptera" "hymenoptera" "hymenoptera" ...
#>  $ meta.image_count          : chr  "0" "0" "0" "0" ...
#>  $ images.1.upload_date      : chr  NA NA NA NA ...
#>  $ images.1.shot_types.h.img1: chr  NA NA NA NA ...
#>  $ images.1.shot_types.h.img2: chr  NA NA NA NA ...
#>  $ images.1.shot_types.h.img3: chr  NA NA NA NA ...
#>  $ images.1.shot_types.h.img4: chr  NA NA NA NA ...
#>  $ images.1.shot_types.p.img1: chr  NA NA NA NA ...
#>  $ images.1.shot_types.p.img2: chr  NA NA NA NA ...
#>  $ images.1.shot_types.p.img3: chr  NA NA NA NA ...
#>  $ images.1.shot_types.p.img4: chr  NA NA NA NA ...
#>  $ images.1.shot_types.d.img1: chr  NA NA NA NA ...
#>  $ images.1.shot_types.d.img2: chr  NA NA NA NA ...
#>  $ images.1.shot_types.d.img3: chr  NA NA NA NA ...
#>  $ images.1.shot_types.d.img4: chr  NA NA NA NA ...
#>  $ images.1.shot_types.l.img1: chr  NA NA NA NA ...
#>  $ images.1.shot_types.l.img2: chr  NA NA NA NA ...
#>  $ images.1.shot_types.l.img3: chr  NA NA NA NA ...
#>  $ images.1.shot_types.l.img4: chr  NA NA NA NA ...
#>  $ images.2.upload_date      : chr  NA NA NA NA ...
#>  $ images.2.shot_types.h.img1: chr  NA NA NA NA ...
#>  $ images.2.shot_types.h.img2: chr  NA NA NA NA ...
#>  $ images.2.shot_types.h.img3: chr  NA NA NA NA ...
#>  $ images.2.shot_types.h.img4: chr  NA NA NA NA ...
```


We can similarly do this for other types of calls to AntWeb.  

As a quick outline, we'll need three other functions to complete the package.
We can write routines to summarize the results with some metadata (what the call was, when it was made, how many results were retreived), and also a mapping function that can take the georeferenced data and plot it on an interactive map.

## Fleshing out this example into a full package

To convert this to a full package, we'll also need to write:  
* documentation for the functions  
* Create description file with a list of Imports/Dependencies in addtiion to some metadata  
* A set of unit tests  
* And a vignette on the data (not required but very useful)  

