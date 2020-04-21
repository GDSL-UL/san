# Points

This chapter^[This chapter is part of [Spatial Analysis Notes](index.html) <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Points -- Kernel Density Estimation and Spatial interpolation</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://darribas.org" property="cc:attributionName" rel="cc:attributionURL">Dani Arribas-Bel</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.] is based on the following references, which are great follow-up's on the topic:

* @lovelace2014introduction is a great introduction.
* Chapter 6 of @comber2015, in particular subsections 6.3 and 6.7.
* @bivand2013applied provides an in-depth treatment of spatial data in R.

This chapter is part of [Spatial Analysis Notes](index.html), a compilation hosted as a GitHub repository that you can access it in a few ways:

* As a [download](https://github.com/GDSL-UL/san/archive/master.zip) of a `.zip` file that contains all the materials.
* As an [html
  website](https://gdsl-ul.github.io/san/points.html).
* As a [pdf
  document](https://gdsl-ul.github.io/san/spatial_analysis_notes.pdf)
* As a [GitHub repository](https://github.com/GDSL-UL/san).

## Dependencies

This tutorial relies on the following libraries that you will need to have installed on your machine to be able to interactively follow along^[You can install package `mypackage` by running the command `install.packages("mypackage")` on the R prompt or through the `Tools --> Install Packages...` menu in RStudio.]. Once installed, load them up with the following commands:


```r
# Layout
library(tufte)
# For pretty table
library(knitr)
# Spatial Data management
library(rgdal)
```

```
## Loading required package: sp
```

```
## rgdal: version: 1.4-8, (SVN revision 845)
##  Geospatial Data Abstraction Library extensions to R successfully loaded
##  Loaded GDAL runtime: GDAL 2.4.2, released 2019/06/28
##  Path to GDAL shared files: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rgdal/gdal
##  GDAL binary built with GEOS: FALSE 
##  Loaded PROJ.4 runtime: Rel. 5.2.0, September 15th, 2018, [PJ_VERSION: 520]
##  Path to PROJ.4 shared files: /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rgdal/proj
##  Linking to sp version: 1.3-2
```

```r
# Pretty graphics
library(ggplot2)
# Thematic maps
library(tmap)
# Pretty maps
library(ggmap)
```

```
## Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
```

```
## Please cite ggmap if you use it! See citation("ggmap") for details.
```

```r
# Various GIS utilities
library(GISTools)
```

```
## Loading required package: maptools
```

```
## Checking rgeos availability: TRUE
```

```
## Loading required package: RColorBrewer
```

```
## Loading required package: MASS
```

```
## Loading required package: rgeos
```

```
## rgeos version: 0.5-2, (SVN revision 621)
##  GEOS runtime version: 3.7.2-CAPI-1.11.2 
##  Linking to sp version: 1.3-1 
##  Polygon checking: TRUE
```

```r
# For all your interpolation needs
library(gstat)
# For data manipulation
library(plyr)
```

Before we start any analysis, let us set the path to the directory where we are working. We can easily do that with `setwd()`. Please replace in the following line the path to the folder where you have placed this file -and where the `house_transactions` folder with the data lives.


```r
#setwd('/media/dani/baul/AAA/Documents/teaching/u-lvl/2016/envs453/code')
setwd('.')
```

## Data

For this session, we will use a subset of residential property transaction data for the city of Liverpool. These are provided by the Land Registry (as part of their [Price Paid Data](https://www.gov.uk/government/collections/price-paid-data)) but have been cleaned and re-packaged by Dani Arribas-Bel.

Let us start by reading the data, which comes in a shapefile:


```r
db <- readOGR(dsn = 'data/house_transactions', layer = 'liv_house_trans')
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "/Users/Franciscorowe/Dropbox/Francisco/uol/teaching/envs453/201920/lectures/san/data/house_transactions", layer: "liv_house_trans"
## with 6324 features
## It has 18 fields
## Integer64 fields read as strings:  price
```

Before we forget, let us make sure `price` is considered a number, not a factor:


```r
db@data$price <- as.numeric(as.character((db@data$price)))
```

The dataset spans the year 2014:


```r
# Format dates
dts <- as.Date(db@data$trans_date)
# Set up summary table
tab <- summary(dts)
tab
```

```
##         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
## "2014-01-02" "2014-04-11" "2014-07-09" "2014-07-08" "2014-10-03" "2014-12-30"
```

We can then examine the elements of the object with the `summary` method:


```r
summary(db)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##              min    max
## coords.x1 333536 345449
## coords.x2 382684 397833
## Is projected: TRUE 
## proj4string :
## [+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000
## +y_0=-100000 +ellps=airy
## +towgs84=446.448,-125.157,542.06,0.15,0.247,0.842,-20.489 +units=m
## +no_defs]
## Number of points: 6324
## Data attributes:
##       pcds                                           id      
##  L1 6LS : 126   {00029226-80EF-4280-9809-109B8509656A}:   1  
##  L8 5TE :  63   {00041BD2-4A07-4D41-A5AE-6459CD5FD37C}:   1  
##  L1 5AQ :  34   {0005AE67-9150-41D4-8D56-6BFC868EECA3}:   1  
##  L24 1WA:  31   {00183CD7-EE48-434B-8A1A-C94B30A93691}:   1  
##  L17 6BT:  26   {003EA3A5-F804-458D-A66F-447E27569456}:   1  
##  L3 1EE :  24   {00411304-DD5B-4F11-9748-93789D6A000E}:   1  
##  (Other):6020   (Other)                               :6318  
##      price                     trans_date   type     new      duration
##  Min.   :    1000   2014-06-27 00:00: 109   D: 505   N:5495   F:3927  
##  1st Qu.:   70000   2014-12-19 00:00: 109   F:1371   Y: 829   L:2397  
##  Median :  110000   2014-02-28 00:00: 105   O: 119                    
##  Mean   :  144310   2014-10-31 00:00:  95   S:1478                    
##  3rd Qu.:  160000   2014-03-28 00:00:  94   T:2851                    
##  Max.   :26615720   2014-11-28 00:00:  94                             
##                     (Other)         :5718                             
##       paon               saon                   street             locality   
##  3      : 203   FLAT 2     :  25   CROSSHALL STREET: 133   WAVERTREE   : 126  
##  11     : 151   FLAT 3     :  25   STANHOPE STREET :  63   MOSSLEY HILL: 102  
##  14     : 148   FLAT 1     :  24   PALL MALL       :  47   WALTON      :  88  
##  5      : 146   APARTMENT 4:  23   DUKE STREET     :  41   WEST DERBY  :  71  
##  4      : 140   APARTMENT 2:  21   MANN ISLAND     :  41   WOOLTON     :  66  
##  8      : 128   (Other)    : 893   OLD HALL STREET :  39   (Other)     : 548  
##  (Other):5408   NA's       :5313   (Other)         :5960   NA's        :5323  
##         town           district           county     ppd_cat  status  
##  LIVERPOOL:6324   KNOWSLEY :  12   MERSEYSIDE:6324   A:5393   A:6324  
##                   LIVERPOOL:6311                     B: 931           
##                   WIRRAL   :   1                                      
##                                                                       
##                                                                       
##                                                                       
##                                                                       
##        lsoa11          LSOA11CD   
##  E01033762: 144   E01033762: 144  
##  E01033756:  98   E01033756:  98  
##  E01033752:  93   E01033752:  93  
##  E01033750:  71   E01033750:  71  
##  E01006518:  68   E01006518:  68  
##  E01033755:  65   E01033755:  65  
##  (Other)  :5785   (Other)  :5785
```

See how it contains several pieces, some relating to the spatial information, some relating to the tabular data attached to it. We can access each of the separately if we need it. For example, to pull out the names of the columns in the `data.frame`, we can use the `@data` appendix:


```r
colnames(db@data)
```

```
##  [1] "pcds"       "id"         "price"      "trans_date" "type"      
##  [6] "new"        "duration"   "paon"       "saon"       "street"    
## [11] "locality"   "town"       "district"   "county"     "ppd_cat"   
## [16] "status"     "lsoa11"     "LSOA11CD"
```

The rest of this session will focus on two main elements of the shapefile: the spatial dimension (as stored in the point coordinates), and the house price values contained in the `price` column. To get a sense of what they look like first, let us plot both. We can get a quick look at the non-spatial distribution of house values with the following commands:


```r
# Create the histogram
hist <- qplot(data=db@data,x=price)
hist
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![(\#fig:unnamed-chunk-8)Raw house prices in Liverpool](02-points_files/figure-latex/unnamed-chunk-8-1.pdf) 

This basically shows there is a lot of values concentrated around the lower end of the distribution but a few very large ones. A usual transformation to *shrink* these differences is to take logarithms:


```r
# Create log and add it to the table
logpr <- log(as.numeric(db@data$price))
db@data['logpr'] <- logpr
# Create the histogram
hist <- qplot(x=logpr)
hist
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![(\#fig:unnamed-chunk-9)Log of house price in Liverpool](02-points_files/figure-latex/unnamed-chunk-9-1.pdf) 

To obtain the spatial distribution of these houses, we need to turn away from the `@data` component of `db`. The easiest, quickest (and also dirtiest) way to get a sense of what the data look like over space is using `plot`:


```r
plot(db)
```

![(\#fig:unnamed-chunk-10)Spatial distribution of house transactions in Liverpool](02-points_files/figure-latex/unnamed-chunk-10-1.pdf) 

## KDE

Kernel Density Estimation (KDE) is a technique that creates a *continuous* representation of the distribution of a given variable, such as house prices. Although theoretically it can be applied to any dimension, usually, KDE is applied to either one or two dimensions.

### One-dimensional KDE

KDE over a single dimension is essentially a contiguous version of a histogram. We can see that by overlaying a KDE on top of the histogram of logs that we have created before:


```r
# Create the base
base <- ggplot(db@data, aes(x=logpr))
# Histogram
hist <- base + 
  geom_histogram(bins=50, aes(y=..density..))
# Overlay density plot
kde <- hist + 
  geom_density(fill="#FF6666", alpha=0.5, colour="#FF6666")
kde
```

![(\#fig:unnamed-chunk-11)Histogram and KDE of the log of house prices in Liverpool](02-points_files/figure-latex/unnamed-chunk-11-1.pdf) 

The key idea is that we are smoothing out the discrete binning that the histogram involves. Note how the histogram is exactly the same as above shape-wise, but it has been rescalend on the Y axis to reflect probabilities rather than counts.

### Two-dimensional (spatial) KDE

Geography, at the end of the day, is usually represented as a two-dimensional space where we locate objects using a system of dual coordinates, `X` and `Y` (or latitude and longitude). Thanks to that, we can use the same technique as above to obtain a smooth representation of the distribution of a two-dimensional variable. The crucial difference is that, instead of obtaining a curve as the output, we will create a *surface*, where intensity will be represented with a color gradient, rather than with the second dimension, as it is the case in the figure above.

To create a spatial KDE in R, there are several ways. If you do not want to necessarily acknowledge the spatial nature of your data, or you they are not stored in a spatial format, you can plot them using `ggplot2`. Note we first need to convert the coordinates (stored in the spatial part of `db`) into columns of X and Y coordinates, then we can plot them:


```r
# Attach XY coordinates
db@data['X'] <- db@coords[, 1]
db@data['Y'] <- db@coords[, 2]
# Set up base layer
base <- ggplot(data=db@data, aes(x=X, y=Y))
# Create the KDE surface
kde <- base + stat_density2d(aes(x = X, y = Y, alpha = ..level..), 
               size = 0.01, bins = 16, geom = 'polygon') +
            scale_fill_gradient()
kde
```

![(\#fig:unnamed-chunk-12)KDE of house transactions in Liverpool](02-points_files/figure-latex/unnamed-chunk-12-1.pdf) 

Or, we can use a package such as the `GISTools`, which allows to pass a spatial object directly:


```r
# Compute the KDE
kde <- kde.points(db)
# Plot the KDE
level.plot(kde)
```

![(\#fig:unnamed-chunk-13)KDE of house transactions in Liverpool](02-points_files/figure-latex/unnamed-chunk-13-1.pdf) 

Either of these approaches generate a surface that represents the density of dots, that is an estimation of the probability of finding a house transaction at a given coordinate. However, without any further information, they are hard to interpret and link with previous knowledge of the area. To bring such context to the figure, we can plot an underlying basemap, using a cloud provider such as Google Maps or, as in this case, OpenStreetMap. To do it, we will leverage the library `ggmap`, which is designed to play nicely with the `ggplot2` family (hence the seemingly counterintuitive example above). Before we can plot them with the online map, we need to reproject them though.


```r
# Reproject coordinates
wgs84 <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
db_wgs84 <- spTransform(db, wgs84)
db_wgs84@data['lon'] <- db_wgs84@coords[, 1]
db_wgs84@data['lat'] <- db_wgs84@coords[, 2]
xys <- db_wgs84@data[c('lon', 'lat')]
# Bounding box
liv <- c(left = min(xys$lon), bottom = min(xys$lat), 
         right = max(xys$lon), top = max(xys$lat))
# Download map tiles
basemap <- get_stamenmap(liv, zoom = 12, 
                         maptype = "toner-lite")
```

```
## Source : http://tile.stamen.com/toner-lite/12/2013/1325.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2014/1325.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2015/1325.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2013/1326.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2014/1326.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2015/1326.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2013/1327.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2014/1327.png
```

```
## Source : http://tile.stamen.com/toner-lite/12/2015/1327.png
```

```r
# Overlay KDE
final <- ggmap(basemap, extent = "device", 
               maprange=FALSE) +
  stat_density2d(data = db_wgs84@data, 
                aes(x = lon, y = lat, 
                    alpha=..level.., 
                    fill = ..level..), 
                size = 0.01, bins = 16, 
                geom = 'polygon', 
                show.legend = FALSE) +
  scale_fill_gradient2("Transaction\nDensity", 
                       low = "#fffff8", 
                       high = "#8da0cb")
final
```

![(\#fig:unnamed-chunk-14)KDE of house transactions in Liverpool](02-points_files/figure-latex/unnamed-chunk-14-1.pdf) 

The plot above^[**EXERCISE** The map above uses the Stamen map `toner-lite`. Explore additional tile styles on their [website](http://maps.stamen.com/#watercolor/12/37.7706/-122.3782) and try to recreate the plot above.] allows us to not only see the distribution of house transactions, but to relate it to what we know about Liverpool, allowing us to establish many more connections than we were previously able. Mainly, we can easily see that the area with a highest volume of houses being sold is the city centre, with a "hole" around it that displays very few to no transactions and then several pockets further away.

## Spatial Interpolation

The previous section demonstrates how to visualize the distribution of a set of spatial objects represented as points. In particular, given a bunch of house transactions, it shows how one can effectively visualize their distribution over space and get a sense of the density of occurrences. Such visualization, because it is based on KDE, is based on a smooth continuum, rather than on a discrete approach (as a choropleth would do, for example).

Many times however, we are not particularly interested in learning about the density of occurrences, but about the distribution of a given value attached to each location. Think for example of weather stations and temperature: the location of the stations is no secret and rarely changes, so it is not of particular interest to visualize the density of stations; what we are usually interested instead is to know how temperature is distributed over space, given we only measure it in a few places. One could argue the example we have been working with so far, house price transactions, fits into this category as well: although where house are sold may be of relevance, more often we are interested in finding out what the "surface of price" looks like. Rather than *where are most houses being sold?* we usually want to know *where the most expensive or most affordable* houses are located.

In cases where we are interested in creating a surface of a given value, rather than a simple density surface of occurrences, KDE cannot help us. In these cases, what we are interested in is *spatial interpolation*, a family of techniques that aim at exactly that: creating continuous surfaces for a particular phenomenon (e.g. temperature, house prices) given only a finite sample of observations. Spatial interpolation is a large field of research that is still being actively developed and that can involve a substantial amount of mathematical complexity in order to obtain the most accurate estimates possible^[There is also an important economic incentive to do this: some of the most popular applications are in the oil and gas or mining industries. In fact, the very creator of this technique, [Danie G. Krige](https://en.wikipedia.org/wiki/Danie_G._Krige), was a mining engineer. His name is usually used to nickname spatial interpolation as *kriging*.]. In this session, we will introduce the simplest possible way of interpolating values, hoping this will give you a general understanding of the methodology and, if you are interested, you can check out further literature. For example, @banerjee2014hierarchical or @cressie2015statistics are hard but good overviews.

### Inverse Distance Weight (IDW) interpolation

The technique we will cover here is called *Inverse Distance Weighting*, or IDW for convenience. @comber2015 offer a good description:

> In the *inverse distance weighting* (IDW) approach to interpolation, to estimate the value of $z$ at location $x$ a weighted mean of nearby observations is taken [...]. To accommodate the idea that observations of $z$ at points closer to $x$ should be given more importance in the interpolation, greater weight is given to these points [...]
>
> --- Page 204

The math^[Essentially, for any point $x$ in space, the IDW estimate for value $z$ is equivalent to $\hat{z} (x) = \dfrac{\sum_i w_i z_i}{\sum_i w_i}$ where $i$ are the observations for which we do have a value, and $w_i$ is a weight given to location $i$ based on its distance to $x$.] is not particularly complicated and may be found in detail elsewhere (the reference above is a good starting point), so we will not spend too much time on it. More relevant in this context is the intuition behind. Essentially, the idea is that we will create a surface of house price by smoothing many values arranged along a regular grid and obtained by interpolating from the known locations to the regular grid locations. This will give us full and equal coverage to soundly perform the smoothing.

Enough chat, let's code.

From what we have just mentioned, there are a few steps to perform an IDW spatial interpolation:

1. Create a regular grid over the area where we have house transactions.
1. Obtain IDW estimates for each point in the grid, based on the values of $k$ nearest neighbors.
1. Plot a smoothed version of the grid, effectively representing the surface of house prices.

Let us go in detail into each of them^[For the relevant calculations, we will be using the `gstat` library.]. First, let us set up a grid:


```r
liv.grid <- spsample(db, type='regular', n=25000)
```

That's it, we're done! The function `spsample` hugely simplifies the task by taking a spatial object and returning the grid we need. Not a couple of additional arguments we pass: `type` allows us to get a set of points that are *uniformly* distributed over space, which is handy for the later smoothing; `n` controls how many points we want to create in that grid.

On to the IDW. Again, this is hugely simplified by `gstat`:


```r
idw.hp <- idw(price ~ 1, locations=db, newdata=liv.grid)
```

```
## [inverse distance weighted interpolation]
```

Boom! We've got it. Let us pause for a second to see how we just did it. First, we pass `price ~ 1`. This specifies the formula we are using to model house prices. The name on the left of `~` represents the variable we want to explain, while everything to its right captures the *explanatory* variables. Since we are considering the simplest possible case, we do not have further variables to add, so we simply write `1`. Then we specify the original locations for which we do have house prices (our original `db` object), and the points where we want to interpolate the house prices (the `liv.grid` object we just created above). One more note: by default, `idw.hp` uses all the available observations, weighted by distance, to provide an estimate for a given point. If you want to modify that and restrict the maximum number of neighbors to consider, you need to tweak the argument `nmax`, as we do above by using the 150 neares observations to each point^[Have a play with this because the results do change significantly. Can you reason why?].

The object we get from `idw` is another spatial table, just as `db`, containing the interpolated values. As such, we can inspect it just as with any other of its kind. For example, to check out the top of the estimated table:


```r
head(idw.hp@data)
```

```
##   var1.pred var1.var
## 1  158068.3       NA
## 2  158178.4       NA
## 3  158291.3       NA
## 4  158407.2       NA
## 5  158526.1       NA
## 6  158648.2       NA
```

The column we will pay attention to is `var1.pred`. And to see the locations for which those correspond:


```r
head(idw.hp@coords)
```

```
##            x1       x2
## [1,] 333566.0 382755.9
## [2,] 333651.0 382755.9
## [3,] 333736.0 382755.9
## [4,] 333820.9 382755.9
## [5,] 333905.9 382755.9
## [6,] 333990.8 382755.9
```

So, for a hypothetical house sold at the location in the first row of `idw.hp@coords` (expressed in the OSGB coordinate system), the price we would guess it would cost, based on the price of houses sold nearby, is the first element of column `var1.pred` in `idw.hp@data`.

### A surface of housing prices

Once we have the IDW object computed, we can plot it to explore the distribution, not of house transactions in this case, but of house price over the geography of Liverpool. The easiest way to do this is by quickly calling the command `spplot`:


```r
spplot(idw.hp['var1.pred'])
```

![](02-points_files/figure-latex/unnamed-chunk-19-1.pdf)<!-- --> 

However, this is not entirely satisfactory for a number of reasons. Let us get an equivalen plot with the package `tmap`, which streamlines some of this and makes more aesthetically pleasant maps easier to build as it follows a "ggplot-y" approach.


```r
# Load up the layer
liv.otl <- readOGR('data/house_transactions', 'liv_outline')
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "/Users/Franciscorowe/Dropbox/Francisco/uol/teaching/envs453/201920/lectures/san/data/house_transactions", layer: "liv_outline"
## with 1 features
## It has 1 fields
```

The shape we will overlay looks like this:


```r
qtm(liv.otl)
```

![](02-points_files/figure-latex/unnamed-chunk-21-1.pdf)<!-- --> 

Now let's give it a first go!


```r
# 
p = tm_shape(liv.otl) + tm_fill(col='black', alpha=1) +
  tm_shape(idw.hp) + 
  tm_symbols(col='var1.pred', size=0.1, alpha=0.25, 
             border.lwd=0., palette='YlGn')
p
```

![](02-points_files/figure-latex/unnamed-chunk-22-1.pdf)<!-- --> 


The last two plots, however, are not really a surface, but a representation of the points we have just estimated. To create a surface, we need to do an interim transformation to convert the spatial object `idw.hp` into a table that a "surface plotter" can understand.


```r
xyz <- data.frame(x=coordinates(idw.hp)[, 1], 
                  y=coordinates(idw.hp)[, 2], 
                  z=idw.hp$var1.pred)
```

Now we are ready to plot the surface as a contour:


```r
base <- ggplot(data=xyz, aes(x=x, y=y))
surface <- base + geom_contour(aes(z=z))
surface
```

![(\#fig:unnamed-chunk-24)Contour of prices in Liverpool](02-points_files/figure-latex/unnamed-chunk-24-1.pdf) 

Which can also be shown as a filled contour:


```r
base <- ggplot(data=xyz, aes(x=x, y=y))
surface <- base + geom_raster(aes(fill=z))
surface
```

![](02-points_files/figure-latex/unnamed-chunk-25-1.pdf)<!-- --> 

The problem here, when compared to the KDE above for example, is that a few values are extremely large:


```r
qplot(data=xyz, x=z, geom='density')
```

![(\#fig:unnamed-chunk-26)Skewness of prices in Liverpool](02-points_files/figure-latex/unnamed-chunk-26-1.pdf) 

Let us then take the logarithm before we plot the surface:


```r
xyz['lz'] <- log(xyz$z)
base <- ggplot(data=xyz, aes(x=x, y=y))
surface <- base +
           geom_raster(aes(fill=lz),
                       show.legend = F)
surface
```

![(\#fig:unnamed-chunk-27)Surface of log-prices in Liverpool](02-points_files/figure-latex/unnamed-chunk-27-1.pdf) 

Now this looks better. We can start to tell some patterns. To bring in context, it would be great to be able to add a basemap layer, as we did for the KDE. This is conceptually very similar to what we did above, starting by reprojecting the points and continuing by overlaying them on top of the basemap. However, technically speaking it is not possible because `ggmap` --the library we have been using to display tiles from cloud providers-- does not play well with our own rasters (i.e. the price surface). At the moment, it is surprisingly tricky to get this to work, so we will park it for now. However, developments such as the [`sf`](https://github.com/edzer/sfr) project promise to make this easier in the future^[**BONUS** if you can figure out a way to do it yourself!]. 

### _"What should the next house's price be?"_

The last bit we will explore in this session relates to prediction for new values. Imagine you are a real state data scientist and your boss asks you to give an estimate of how much a new house going into the market should cost. The only information you have to make such a guess is the location of the house. In this case, the IDW model we have just fitted can help you. The trick is realizing that, instead of creating an entire grid, all we need is to obtain an estimate of a single location.

Let us say, the house is located on the coordinates `x=340000, y=390000` as expressed in the GB National Grid coordinate system. In that case, we can do as follows:


```r
pt <- SpatialPoints(cbind(x=340000, y=390000),
                    proj4string = db@proj4string)
idw.one <- idw(price ~ 1, locations=db, newdata=pt)
```

```
## [inverse distance weighted interpolation]
```

```r
idw.one
```

```
## class       : SpatialPointsDataFrame 
## features    : 1 
## extent      : 340000, 340000, 390000, 390000  (xmin, xmax, ymin, ymax)
## crs         : +proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +towgs84=446.448,-125.157,542.06,0.15,0.247,0.842,-20.489 +units=m +no_defs 
## variables   : 2
## names       :        var1.pred, var1.var 
## value       : 157099.029513871,       NA
```

And, as show above, the estimated value is GBP157,099^[**PRO QUESTION** Is that house expensive or cheap, as compared to the other houses sold in this dataset? Can you figure out where the house is?].

Using this predictive logic, and taking advantage of Google Maps and its geocoding capabilities, it is possible to devise a function that takes an arbitrary address in Liverpool and, based on the transactions occurred throughout 2014, provides an estimate of what the price for a property in that location could be.


```r
how.much.is <- function(address, print.message=TRUE){
  # Convert the address into Lon/Lat coordinates
  # NOTE: this now requires an API key
  # https://github.com/dkahle/ggmap#google-maps-and-credentials
  ll.pt <- geocode(address)
  # Process as spatial table
  wgs84 <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
  ll.pt <- SpatialPoints(cbind(x=ll.pt$lon, y=ll.pt$lat),
                      proj4string = wgs84)
  # Transform Lon/Lat into OSGB
  pt <- spTransform(ll.pt, db@proj4string)
  # Obtain prediction
  idw.one <- idw(price ~ 1, locations=db, newdata=pt)
  price <- idw.one@data$var1.pred
  # Return predicted price
  if(print.message==T){
    writeLines(paste("\n\nBased on what surrounding properties were sold",
                    "for in 2014 a house located at", address, "would", 
                    "cost",  paste("GBP", round(price), ".", sep=''), "\n\n"))
  }
  return(price)
}
```

Ready to test!


```r
address <- "74 Bedford St S, Liverpool, L69 7ZT, UK"
#p <- how.much.is(address)
```


