# Data Sets {#datasets}



```r
library(sf)
```

## Madrid AirBnb

This dataset contains a pre-processed set of properties advertised on the AirBnb website within the region of Madrid (Spain), together with house characteristics.

### Availability {.unnumbered}

The dataset is stored on a Geopackage that can be found, within the structure of this project, under:


```r
path <- "data/assignment_1_madrid/madrid_abb.gpkg"
```


```r
db <- st_read(path)
```

```
## Reading layer `madrid_abb' from data source `/home/jovyan/work/data/assignment_1_madrid/madrid_abb.gpkg' using driver `GPKG'
## Simple feature collection with 18399 features and 16 fields
## geometry type:  POINT
## dimension:      XY
## bbox:           xmin: -3.86391 ymin: 40.33243 xmax: -3.556 ymax: 40.56274
## geographic CRS: WGS 84
```

### Variables {.unnumbered}

For each of the 17 properties, the following characteristics are available:

- `price`: [string] Price with currency
- `price_usd`: [int] Price expressed in USD
- `log1pm_price_usd`: [float] Log of the price
- `accommodates`: [integer] Number of people the property accommodates
- `bathrooms`: [integer] Number of bathrooms
- `bedrooms`: [integer] Number of bedrooms
- `beds`: [integer] Number of beds
- `neighbourhood`: [string] Name of the neighbourhood the property is located in
- `room_type`: [string] Type of room offered (shared, private, entire home, hotel room)
- `property_type`: [string] Type of property advertised (apartment, house, hut, etc.)
- `WiFi`: [binary] Takes `1` if the property has WiFi, `0` otherwise
- `Coffee`: [binary] Takes `1` if the property has a coffee maker, `0` otherwise
- `Gym`: [binary] Takes `1` if the property has access to a gym, `0` otherwise
- `Parking`: [binary] Takes `1` if the property offers parking, `0` otherwise
- `km_to_retiro`: [float] Euclidean distance from the property to the El Retiro park
- `geom`: [geometry] Point geometry


### Projection {.unnumbered}

The location of each property is stored as point geometries and expressed in longitude and latitude coordinates:


```r
st_crs(db)
```

```
## Coordinate Reference System:
##   User input: WGS 84 
##   wkt:
## GEOGCRS["WGS 84",
##     DATUM["World Geodetic System 1984",
##         ELLIPSOID["WGS 84",6378137,298.257223563,
##             LENGTHUNIT["metre",1]]],
##     PRIMEM["Greenwich",0,
##         ANGLEUNIT["degree",0.0174532925199433]],
##     CS[ellipsoidal,2],
##         AXIS["geodetic latitude (Lat)",north,
##             ORDER[1],
##             ANGLEUNIT["degree",0.0174532925199433]],
##         AXIS["geodetic longitude (Lon)",east,
##             ORDER[2],
##             ANGLEUNIT["degree",0.0174532925199433]],
##     USAGE[
##         SCOPE["unknown"],
##         AREA["World"],
##         BBOX[-90,-180,90,180]],
##     ID["EPSG",4326]]
```

### Source & Pre-processing {.unnumbered}

The data are sourced from [Inside Airbnb](http://insideairbnb.com/). A Jupyter notebook in Python (available at `data/assignment_1_madrid/clean_data.ipynb`) details the process from the original file available from source to the data in `madrid_abb.gpkg`.

## England COVID-19

This dataset contains:

* daily COVID-19 confirmed cases from 1st January, 2020 to 2nd February, 2021 from the [GOV.UK dashboard](https://coronavirus.data.gov.uk);

* resident population characteristics from the 2011 census, available from the [Office of National Statistics](https://www.nomisweb.co.uk/home/census2001.asp); and,

* 2019 Index of Multiple Deprivation (IMD) data from [GOV.UK](https://www.gov.uk/government/statistics/english-indices-of-deprivation-2019) and published by the Ministry of Housing, Communities & Local Government. 

The data are at the Upper Tier Local Authority District (UTLAD) level - also known as [Counties and Unitary Authorities](https://geoportal.statistics.gov.uk/datasets/fe6bcee87d95476abc84e194fe088abb_0).


### Availability {.unnumbered}

The dataset is stored on a Geopackage:


```r
sdf <- st_read("data/assignment_2_covid/covid19_eng.gpkg")
```

```
## Reading layer `covid19_eng' from data source `/home/jovyan/work/data/assignment_2_covid/covid19_eng.gpkg' using driver `GPKG'
## Simple feature collection with 149 features and 507 fields
## geometry type:  MULTIPOLYGON
## dimension:      XY
## bbox:           xmin: 134112.4 ymin: 11429.67 xmax: 655653.8 ymax: 657536
## projected CRS:  OSGB 1936 / British National Grid
```

### Variables {.unnumbered}

The data set contains 508 variables:


* `objectid`: [integer] unit identifier
* `ctyua19cd`: [integer] Upper Tier Local Authority District (or Counties and Unitary Authorities) identifier
* `ctyua19nm`: [character] Upper Tier Local Authority District (or Counties and Unitary Authorities) name
* `Region`: [character] Region name
* `long`: [numeric] longitude
* `lat`: [numeric] latitude
* `st_areasha`: [numeric] area in hectare 
* `X2020.01.31` to `X2021.02.05`: [numeric] Daily COVID-19 cases from 31st January, 2020 to 5th February, 2021
* `IMD...Average.score` - `IMD.2019...Local.concentration`: [numeric] IMD indicators - for details see [File 11: upper-tier local authority summaries](https://www.gov.uk/government/statistics/english-indices-of-deprivation-2019).
* `Residents`:	[numeric] Total resident population
* `Households`:	[numeric]	Total households
* `Dwellings`:	[numeric]	Total dwellings
* `Household_Spaces`:	[numeric]	Total household spaces
* `Aged_16plus` to `Other_industry`: [numeric] comprise 114 variables relating to various population and household attributes of the resident population. A description of all these variables can be found [here](data/assignment_2_covid/census_vars.csv) 
* `geom`: [geometry] Point geometry

### Projection {.unnumbered}

Details of the coordinate reference system:


```r
st_crs(sdf)
```

```
## Coordinate Reference System:
##   User input: OSGB 1936 / British National Grid 
##   wkt:
## PROJCRS["OSGB 1936 / British National Grid",
##     BASEGEOGCRS["OSGB 1936",
##         DATUM["OSGB 1936",
##             ELLIPSOID["Airy 1830",6377563.396,299.3249646,
##                 LENGTHUNIT["metre",1]]],
##         PRIMEM["Greenwich",0,
##             ANGLEUNIT["degree",0.0174532925199433]],
##         ID["EPSG",4277]],
##     CONVERSION["British National Grid",
##         METHOD["Transverse Mercator",
##             ID["EPSG",9807]],
##         PARAMETER["Latitude of natural origin",49,
##             ANGLEUNIT["degree",0.0174532925199433],
##             ID["EPSG",8801]],
##         PARAMETER["Longitude of natural origin",-2,
##             ANGLEUNIT["degree",0.0174532925199433],
##             ID["EPSG",8802]],
##         PARAMETER["Scale factor at natural origin",0.9996012717,
##             SCALEUNIT["unity",1],
##             ID["EPSG",8805]],
##         PARAMETER["False easting",400000,
##             LENGTHUNIT["metre",1],
##             ID["EPSG",8806]],
##         PARAMETER["False northing",-100000,
##             LENGTHUNIT["metre",1],
##             ID["EPSG",8807]]],
##     CS[Cartesian,2],
##         AXIS["(E)",east,
##             ORDER[1],
##             LENGTHUNIT["metre",1]],
##         AXIS["(N)",north,
##             ORDER[2],
##             LENGTHUNIT["metre",1]],
##     USAGE[
##         SCOPE["unknown"],
##         AREA["UK - Britain and UKCS 49°46'N to 61°01'N, 7°33'W to 3°33'E"],
##         BBOX[49.75,-9.2,61.14,2.88]],
##     ID["EPSG",27700]]
```

