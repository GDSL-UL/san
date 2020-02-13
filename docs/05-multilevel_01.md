# Multilevel Modelling - Part 1

This session^[This note is part of [Spatial Analysis Notes](index.html) <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Multilevel Modelling -- Random Intercept Multilevel Model</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://franciscorowe.com" property="cc:attributionName" rel="cc:attributionURL">Francisco Rowe</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.] introduces multi-level data structures, .


The content of this session is based on the following references:

* @Snijders_Bosker_2012_book

* @bristol

## Dependencies

This tutorial uses the libraries below. Ensure they are installed on your machine^[You can install package `mypackage` by running the command `install.packages("mypackage")` on the R prompt or through the `Tools --> Install Packages...` menu in RStudio.] before loading them executing the following code chunk:


```r
# Data manipulation, transformation and visualisation
library(tidyverse)
# Nice tables
library(kableExtra)
# Simple features (a standardised way to encode vector data ie. points, lines, polygons)
library(sf) 
# Spatial objects conversion
library(sp) 
# Thematic maps
library(tmap) 
# Colour palettes
library(RColorBrewer) 
# More colour palettes
library(viridis) # nice colour schemes
```

> Flow of the argument: explanation of key components of linear regressions which matter to introduce multilevel models

Relevant assumptions of the linear regression model to recall
* independence of residuals
* constant variability
* mean of residuals = 0 
Not sure if all of this is relevant - not to be written down.


# Multilevel Data Structures

Geographically hierarchical data structure: 
* Stric hierarchy eg. People nested within households, and households nested within neighbourhoods; states nested within countries
* Cross-classified hierarchy eg. People within neighbouhoods and workplaces

Temporally hierarchical data structures eg.
* Repeated measures design or longitudinal data: Individuals followed over time at a particular location


**Why should we care?**

Conceptually, individual observations within a particular grouping can be expected to be more alike than observations from a random set.

* Spatial hetorogeneity

* Spatial dependency

* Contextual dependencies: micro and macro level relationships

Technically, we have incorrect estimates of precision, standard errors, confidence intervals and tests, increased risk of finding relationships and differences where none exists.

## Data

## Long vs wide format

# Single-level Regression Models

**Example: estimate regression model**

## Limitations

* Captures averages

* Does not account for spatial and temporal dependencies

* Only captures on macro *vs* micro processes
  +  A macro approach: enables understanding of higher level unit analysis, not individuals within these units > Ecological fallacy
  + A micro approach: enables understanding of individuals without acknoledgement of dependencies between individuals within the same group or spatial unit > Underestimation of standard errors

* May lead to drawn erroneous conclusions frome the identification of misleading relationships

## Adding Group Fixed Effects

Introduce this as adding dummy variables

**Example: estimate regression model**

* The number of groups could be very large, eg households?
* No single parameter assesses between group differences
* Cannot include group-level predictors

# Multilevel Modelling

> Too technical
* Partition residual variance into between- and within-group (level 2 and level 1) components.
* Allows for un-observables at each level, corrects standard errors: measures of uncertainty
* Micro and macro factors
* richer set of research questions


Various labels:
* Random-effects Models
* Hierarchical Models
* Variance-components Models
* Random-coefficient Models
* Linear / Generalised Linear Mixed Models

## Theory

## Practice
