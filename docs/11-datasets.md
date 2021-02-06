# Data Sets {#datasets}



```r
library(sf)
```

```
## Linking to GEOS 3.8.1, GDAL 3.1.1, PROJ 6.3.1
```

## Madrid AirBnb

This dataset contains a pre-processed set of properties advertised on the AirBnb website within the region of Madrid (Spain), together with house characteristics.

### Availability

The dataset is stored on a Geopackage that can be found, within the structure of this project, under:


```r
path <- "data/assignment_1_madrid/madrid_abb.gpkg"
```


```r
db <- st_read(path)
```

```
## Reading layer `madrid_abb' from data source `/Users/Franciscorowe 1/Dropbox/Francisco/uol/teaching/envs453/202021/san/data/assignment_1_madrid/madrid_abb.gpkg' using driver `GPKG'
## Simple feature collection with 18399 features and 15 fields
## geometry type:  POINT
## dimension:      XY
## bbox:           xmin: -3.86391 ymin: 40.33243 xmax: -3.556 ymax: 40.56274
## geographic CRS: WGS 84
```

### Variables

For each of the 16 properties, the following characteristics are available:

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


### Projection

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

### Source & Pre-processing

The data are sourced from [Inside Airbnb](http://insideairbnb.com/). A Jupyter notebook in Python (available at `data/assignment_1_madrid/clean_data.ipynb`) details the process from the original file available from source to the data in `madrid_abb.gpkg`. 
