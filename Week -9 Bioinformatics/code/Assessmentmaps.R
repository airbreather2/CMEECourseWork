library(terra)
library(raster)
library(sf)
library(sp)
library(dismo)
library(sf)        # core vector GIS package
library(units)     # used for precise unit conversion
library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)

# Download a 1:100m scale world map
world_map <- ne_countries(scale = "small", returnclass = "sf")

#find the coordinate system (WGS84)
st_crs(world_map)

#Identify features of world map
st_geometry(world_map)

# Plot the world map with latitude and longitude lines
ggplot(data = world_map) +
  geom_sf(fill = "white", color = "black") +
  ggtitle("World Map with Latitude and Longitude") +
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Limits and no padding
  theme_minimal()

#load in data
mammals_iucn_data <- st_read("../data/MAMMALS/MAMMALS.shp")
