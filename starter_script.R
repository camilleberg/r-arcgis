# this will be a starter script / test tutorial for arcgis

###### SET UP ##########

# regular libraries
library(tidyverse)

# WEBSITE: https://github.com/R-ArcGIS/r-bridge
# install.packages("arcgisbinding", repos="https://r.esri.com", type="win.binary")
library(arcgisbinding)
arc.check_product()

###### Getting the Data ##########

####### Reading ArcGIS vector data

# the format
# gis_data <- arc.open(path = "C:/Users/camilleb/Documents/ArcGIS/Projects/arcgis_and_r_integration/arcgis_and_r_integration.gdb/poverty_boston_tracts20.STANAWAYBRANDON.21536.54240.sr")
# r_data <- arc.select(gis_data, fields, SQL, spatial ref )

gis_data <- arc.open("F:/Deptment/Research/Data/Research Dept GIS Repository/shapefiles/Crime Rate Zip Code.shp")
dat <- arc.select(gis_data)
  # this takes a long time to load (this reads the data to an R dataframe)

gis_data@fields
head(dat)

# to filter the dataa, write arguments into "seelcted fields"

# grabbing clauses 
lat <- "Lat"
long <- "Long"
categorical <- "DAY_OF_WEE"

selected_fields <- c(lat, long, categorical)

# filtering based on time 
c(min(dat$OCCURRED_O), max(dat$OCCURRED_O))

filter <- "OCCURRED_O >= 'timestamp 2019-01-01 00:00:00'"

# new clasue for the data
dat_filter <- arc.select(gis_data, fields = selected_fields, where_clause = filter)


####### REFERENCES ###### 
# https://www.youtube.com/watch?v=oFu4e6-9_Sc