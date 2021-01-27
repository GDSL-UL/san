# Overview {#overview}

Access to all materials, including lecture notes, computational notebooks and datasets, is centralised through the use of the course website available in the following url:

> [https://gdsl-ul.github.io/san/](https://gdsl-ul.github.io/san/)

The module handbook, including the assessment description, criteria and module programme, and videos for each teaching week can be accessed via the module Canvas site:

> [ENS453 Spatial Modelling for Data Scientists](https://liverpool.instructure.com)

## Aims

This module aims to provides students with a range of techniques for analysing and modelling spatial data:

* build upon the more general research training delivered via companion modules on *Data Collection and Data Analysis*, both of which have an aspatial focus;
* highlight a number of key social issues that have a spatial dimension;
* explain the specific challenges faced when attempting to analyse spatial data;
* introduce a range of analytical techniques and approaches suitable for the analysis of spatial data; and,
* enhance practical skills in using *R* software packages to implement a wide range of spatial analytical tools.

## Learning Outcomes

By the end of the module, students should be able to:

* identify some key sources of spatial data and resources of spatial analysis and modelling tools;
* explain the advantages of taking spatial structure into account when analysing spatial data;
* apply a range of computer-based techniques for the analysis of spatial data, including mapping, correlation, kernel density estimation, regression, multi-level models, geographically-weighted regression, spatial interaction models and spatial econometrics;
* apply appropriate analytical strategies to tackle the key methodological challenges facing spatial analysis – spatial autocorrelation, heterogeneity, and ecological fallacy; and, 
* select appropriate analytical tools for analysing specific spatial data sets to address emerging social issues facing the society.

## Feedback

* *Formal assessment of two computational essays*. Written assignment-specific feedback will be provided within three working weeks of the submission deadline. Comments will offer an understanding of the mark awarded and identify areas which can be considered for improvement in future assignments.

* *Verbal face-to-face feedback*. Immediate face-to-face feedback will be provided during lecture, discussion and clinic sessions in interaction with staff. This will take place in all live sessions during the semester.

* *Online forum*. Asynchronous written feedback will be provided via an online forum maintained by the module lead. Students are encouraged to contribute by asking and answering questions relating to the module content. Staff will monitor the forum Monday to Friday 9am-5pm, but it will be open to students to make contributions at all times.

## Computational Environment

Dependencies + Landing page for guides

### Dependency list

List of libraries used in this book:


```r
deps <- list(
    "arm",
    "car",
    "corrplot",
    "FRK",
    "gghighlight",
    "ggplot2",
    "ggmap",
    "GISTools",
    "gstat",
    "jtools",
    "kableExtra",
    "knitr",
    "lme4",
    "lmtest",
    "lubridate",
    "MASS",
    "merTools",
    "plyr",
    "RColorBrewer",
    "rgdal",
    "sf",
    "sjPlot",
    "sp",
    "spgwr",
    "spatialreg",
    "spacetime",
    "stargazer",
    "tidyverse",
    "tmap",
    "viridis"
)
```

And we can load them all to make sure they are installed:


```r
for(lib in deps){library(lib, character.only = TRUE)}
```

## Assessment

The final module mark is composed of the **two computational essays**. Together they are designed to cover the materials introduced in the entirety of content covered during the semester.

* Assignment 1 (50%) - see relevant Chapters for details i.e. Chapters \@ref(points)
* Assignment 2 (50%)

Maximum word count: 2,000 words, excluding figures and references. Both assignments will be similar in format. Each teaching week, you will be required to address a set of questions relating to the module content covered in that week. You should use roughly the same number of words to document your answers each week. For assignment 1, for example, you will be required to address questions in Weeks 2, 3 and 4 so we should roughly document your answers in 666 words (= 2,000 / 3) each week; that is max. as noted below.

Assignments need to be prepared in *R Notebook* format and then converted into
a self-contained HTML file that will then be submitted via Turnitin.
A R Notebook template is available via the [*module Canvas site*](https://liverpool.instructure.com).

*Submission* is electronic only via Turnitin on *Canvas*.

### Marking criteria

The Standard Environmental Sciences School marking criteria apply, with a stronger emphasis on evidencing the use of regression models, critical analysis of results and presentation standards. In addition to these general criteria, the code and outputs (i.e. tables, maps and plots) contained within the notebook submitted for assessment will be assessed according to the extent of documentation and evidence of expertise in changing and extending the code options illustrated in each chapter. Soecifically, the following criteria will be applied:

* 0-15: no documentation and use of default options.
* 16-39: some documentation explaining its logic.
* 40-49: the code runs and produces the expected output. There is some documentation explaining its logic.
* 50-59: the code runs and produces the expected output. There is extensive documentation explaining its logic.
* 60-69: the code runs and produces the expected output. There is extensive documentation, properly formatted, explaining its logic.
* 70-79: all as above, plus the code design includes clear evidence of skills presented in advanced sections of the course (e.g. custom methods, list comprehensions, etc.).
* 80-100: all as above, plus the code contains novel contributions that extend/improve the functionality the student was provided with (e.g. algorithm optimizations, novel methods to perform the task, etc.).







