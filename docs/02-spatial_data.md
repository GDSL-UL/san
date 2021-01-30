# Spatial Data {#spatial_data}

This Chapter seeks to present and describe distinctive attributes of spatial data, and discuss some of the main challenges in analysing and modelling these data. Spatial data is a term used to describe any data associating a given variable attribute to a specific location on the Earth's surface. 


## Spatial Data types

Different classifications of spatial data types exist. Knowing the structure of the data at hand is important as specific analytical methods would be more appropriate for particular data types. We will use a particular classification involving four data types: lattice/areal data, point data, flow data and trajectory data. This is not a exhaustive list but it is helpful to motivate the analytical and modelling methods that we cover in this book.

*Point Data*. These data refer to records of the geographic location of an discrete event, or the number of occurrences of geographical process at a given location. As displayed in Figure 1, examples include the geographic location of bus stops in a city, or the number of boarding passengers at each bus stop. 

[INSERT FIGURE 1: EXAMPLES OF DATA TYPES]

*Lattice/Areal Data*. These data correspond to records of attribute values (such as population counts) for a fixed geographical area. They may comprise regular shapes (such as grids or pixels) or irregular shapes (such as states, counties or travel-to-work areas). Raster data are a common source of regular lattice/areal area, while censuses are probably the most common form of irregular lattice/areal area. Point data within an area can be aggregated to produce lattice/areal data.

*Flow Data*. These data refer to records of measurements for a pair of geographic point locations. or pair of areas. These data capture the linkage or spatial interaction between two locations. Migration flows between a place of origin and a place of destination is an example of this type of data.

*Trajectory Data*. These data record geographic locations of moving objects at various points in time. A trajectory is composed of a single string of data recording the geographic location of an object at various points in time and each record in the string contains a time stamp. These data are complex and can be classified into explicit trajectory data and implicit trajectory data. The former refer to well-structured data and record positions of objects continuously and intensively at uniform time intervals, such as GPS data. The latter is less structured and record data in relatively time point intervals, including sensor-based, network-based and signal-based data (@kong2018big).

In this course, we cover analytical and modelling approaches for point, lattice/areal and flow data. While we do not explicitly analyse trajectory data, various of the analytical approaches described in this book can be extended to incorporate time, and can be applied to model these types of data. In Chapter \@ref(sta), we describe approaches to analyse and model spatio-temporal data. These same methods can be applied to trajectory data.

## Hierarchical Structure of Data

Spatial data 





## Key Challenges

### Modifible Area Unit Problem (MAUP)

*Scale*

*Zonation*

### Ecological Fallacy

### Spatial Autocorrelation

### Spatial Heterogeneity


