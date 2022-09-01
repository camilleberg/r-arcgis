# this will be a starter script / test tutorial for arcgis

###### SET UP ##########

# regular libraries
library(tidyverse)
library(sf)
library(plotly)
# library(ggplotly)

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

selected_fields <- c("FID", "OCCURRED_O", lat, long, categorical)
  # make sure to select the filed you want to filter by  

# filtering based on time 
c(min(dat$OCCURRED_O), max(dat$OCCURRED_O))

filter <- "OCCURRED_O >= timestamp '2019-01-01 00:00:00'"
  # note the single quotes around the actual timestamp numbers 

# new clause for the data
dat_filter <- arc.select(gis_data, fields = selected_fields, where_clause = filter)
head(dat_filter)

####### VISUALIZING THE DATA ###### 
dat_sf <- arc.data2sf(dat_filter)
  # converts the data to a simple feature (sf) object 

ggplot(dat_sf) +
  geom_sf(color = "blue")

# spatial thin the data (which means?)
# this part is unnec for this eg, because spatial thinning is for ecology

ggplot(dat_filter) +
  geom_bar(aes(x = DAY_OF_WEE))
# looking at the days fo the week for the data 

# look at possibility of making interactive mapping thing using GIS to integrate?


####### REFERENCES ###### 
# https://www.youtube.com/watch?v=oFu4e6-9_Sc