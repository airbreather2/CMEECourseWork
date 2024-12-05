#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

library(terra)     # core raster GIS package
library(sf)        # core vector GIS package
library(units)     # used for precise unit conversion

library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files

sf_use_s2(FALSE)

#####Making vectors for coordinates:

#lets make a population density map for the british isles, will look approcimately like the isles with cartesian coordinates 

pop_dens <- data.frame(
  n_km2 = c(260, 67,151, 4500, 133), 
  country = c('England','Scotland', 'Wales', 'London', 'Northern Ireland')
)
print(pop_dens)

# For different kinds of vector geometries (POINT, LINESTRING, POLYGON), the coordinates are provided in different ways.
# we are just using very simple polygons to show the countries.
# Create coordinates  for each country 
# - this creates a matrix of pairs of coordinates forming the edge of the polygon. 
# - note that they have to _close_: the first and last coordinate must be the same.
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

# Convert these coordinates into feature geometries
# - these are simple coordinate sets with no projection information
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# A simple feature column (sfc) is created to store geometries. 
# It allows vector data to be integrated into a regular R data.frame.
# The 'crs' (coordinate reference system) is set to 4326

# When plotting geographic data (latitude and longitude), 
# the 'sf' package automatically scales the aspect ratio based on latitude 
# to avoid distortion and make the map appear proportional.
# Here, we suppress this behavior by setting a fixed aspect ratio of 1 (asp = 1), 
# ensuring the plot is not adjusted for latitude-based scaling.


# sf automatically tries to scale aspect ratio of plots of geographic data based on their latitude making them less squashed. asp=1 stops this
uk_eire_sfc <- st_sfc(wales, england, scotland, ireland, crs=4326)
plot(uk_eire_sfc, asp=1)


#### making vector points from a dataframe 
#create a dataframe with point coordinates for captital cities 

uk_eire_capitals <- data.frame(
  long= c(-0.1, -3.2, -3.2, -6.0, -6.25),
  lat=c(51.5, 51.5, 55.8, 54.6, 53.30),
  name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin')
)

# Indicate which fields in the data frame contain the coordinates
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long','lat'), crs=4326)
print(uk_eire_capitals)

#london is defined by a buffer of a quarter of a degree around st paul cathedral
st_pauls <- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25)

#remove london from england so we can save different population densities
england_no_london <- st_difference(england, london)

#see the amount of components in scotland
lengths(scotland)

#seperate eire from northern ireland

# A rough polygon that includes Northern Ireland and surrounding sea.
# - not the alternative way of providing the coordinates
ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))

northern_ireland <- st_intersection(ireland, ni_area)
eire <- st_difference(ireland, ni_area)


# The uk_eire_sfc object contains 6 features, where a feature is a spatial unit
# represented by one or more vector GIS geometries. Each feature in uk_eire_sfc
# currently consists of a single polygon. The England feature is unique as it
# includes a hole within its geometry.
# To combine all these features into a single MULTIPOLYGON geometry, 
# we can use the union operation.


# Combine the final geometries
uk_eire_sfc <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)


# compare six Polygon features with one Multipolygon feature
print(uk_eire_sfc)


# make the UK into a single feature
uk_country <- st_union(uk_eire_sfc[-6])
#MULTIPOLYGON (((-3 53.4, -3 55, -5 55, -6 56, -...
print(uk_country)

############ Plot everything !!
par(mfrow=c(1, 2), mar=c(3,3,1,1))
plot(uk_eire_sfc, asp=1, col=rainbow(6))
plot(st_geometry(uk_eire_capitals), add=TRUE)
plot(uk_country, asp=1, col='lightblue')


######Vector data and attributes

#currently we just have vector geometries . but GIS is about pairing spacial features with data about those features, often called attributes and properties 

# GIS data combines vector geometries with attributes (or properties) about those features.
# This structure is essentially a data frame, with fields (columns) containing data for each location.
# One of these fields is a geometry column (the sfc object) that holds the spatial data.
# The sf package introduces the sf object type, which is a regular data frame with an additional
# field for simple feature geometry. Printing an sf object displays extra information compared to a standard data.frame.

uk_eire_sf <- st_sf(name=c('Wales', 'England','Scotland', 'London', 
                           'Northern Ireland', 'Eire'),
                    geometry=uk_eire_sfc)

print(uk_eire_sf)

#an sf object also has a simple plot which we can use to draw a basic map

plot(uk_eire_sf['name'], asp=1)

#since sf object is an extended dataframe, we can add attributes by adding fields directly

uk_eire_sf$capital <- c('Cardiff', 'London', 'Edinburgh', 
                        NA, 'Belfast','Dublin')
print(uk_eire_sf)

# Use by.x and by.y to specify matching columns. If column names are identical, use 'by'.
# Default behavior of merge drops rows with no matches. Use all.x=TRUE to keep all rows,
# e.g., to prevent dropping Eire from spatial data without a population density estimate.
# The result includes spatial header info and a data frame-like printout with a geometry column.

uk_eire_sf <- merge(uk_eire_sf, pop_dens, by.x='name', by.y='country', all.x=TRUE)
print(uk_eire_sf)

####Spacial attributes 

#we can find the centroids of features (the "average" coordinate so to speak)
uk_eire_centroids <- st_centroid(uk_eire_sf)
st_coordinates(uk_eire_centroids)

#we can also find length of a feature and its are, transformations are automatically applied according to coordinate system

uk_eire_sf$area <- st_area(uk_eire_sf)

# To calculate a 'length' of a polygon, you have to convert it to a LINESTRING or a 
# MULTILINESTRING. Using MULTILINESTRING will automatically include all perimeter of a 
# polygon (including holes).
uk_eire_sf$length <- st_length(st_cast(uk_eire_sf, 'MULTILINESTRING'))

# Look at the result
print(uk_eire_sf)

#note the units, these can be transformed with some commands 
# You can change units in a neat way
uk_eire_sf$area <- set_units(uk_eire_sf$area, 'km^2')
uk_eire_sf$length <- set_units(uk_eire_sf$length, 'km')
print(uk_eire_sf)

#sf won't let you change into a unit that wouldnt make sense like kg
# And it won't let you make silly error like turning a length into weight
uk_eire_sf$area <- set_units(uk_eire_sf$area, 'kg')

#units can be converted to simple numbers though 
# Or you can simply convert the `units` version to simple numbers
uk_eire_sf$length <- as.numeric(uk_eire_sf$length)

#it can also give us distance between geometries, which may be 0 if they overlap (our neighbouring countries)
st_distance(uk_eire_sf)

st_distance(uk_eire_centroids)

###Plotting sf objects 

#when plotting an sf object, the default is to plot a map for every attribute. you can pick a single field to plot by using square brackets
plot(uk_eire_sf['n_km2.x'], asp=1)

#you can log the data to improve scale as it is currently not super helpful 
# You could simply log the data:
uk_eire_sf$log_n_km2 <- log10(uk_eire_sf$n_km2.x)
plot(uk_eire_sf['log_n_km2'], asp=1, key.pos=4)
# Or you can have logarithimic labelling using logz
plot(uk_eire_sf['n_km2'], asp=1, logz=TRUE, key.pos=4)

####Reprojecting Vector data

#currently the coordinate system we are using (4326) represents the WGS84 geographic coordinate system
#reprojection involves tranforming data form one set of coordnates to another, for vector data this is straight forward as it is ran through an equation
#different coordinate systems can affect shape etc. need to find the one most appropriate to your data 

#to show this we will use the british national grid system or the UTM 50N, which is used for borneo

# British National Grid (EPSG:27700)
uk_eire_BNG <- st_transform(uk_eire_sf, 27700)
# UTM50N (EPSG:32650)
uk_eire_UTM50N <- st_transform(uk_eire_sf, 32650)
# The bounding boxes of the data shows the change in units
st_bbox(uk_eire_sf)
st_bbox(uk_eire_BNG)

#plot them side by side to see this in action 
# Plot the results
par(mfrow=c(1, 3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire_sf), asp=1, axes=TRUE, main='WGS 84')
plot(st_geometry(uk_eire_BNG), axes=TRUE, main='OSGB 1936 / BNG')
plot(st_geometry(uk_eire_UTM50N), axes=TRUE, main='UTM 50N')

###DEGREES ARE NOT CONSTANT

#the units of geographic coordinate systems are angles of latitude and longitude. which is why out usage of it for the 0.25 degree buffered point for london was poor as it got distorted
# Set up some points separated by 1 degree latitude and longitude from St. Pauls
st_pauls <- st_sfc(st_pauls, crs=4326)
one_deg_west_pt <- st_sfc(st_pauls - c(1, 0), crs=4326) # near Goring
one_deg_north_pt <-  st_sfc(st_pauls + c(0, 1), crs=4326) # near Peterborough
# Calculate the distance between St Pauls and each point
st_distance(st_pauls, one_deg_west_pt)

st_distance(st_pauls, one_deg_north_pt)

# The great circle distance (WGS84 global model) between London and Goring differs 
# from the distance using the British National Grid (BNG) projection. 
# This discrepancy arises due to:
# 1. Local imprecision in the WGS84 global model.
# 2. Distance distortions inherent in the BNG projection.
# Likely, both factors contribute.

st_distance(st_transform(st_pauls, 27700), 
            st_transform(one_deg_west_pt, 27700))

# transform St Pauls to BNG and buffer using 25 km
london_bng <- st_buffer(st_transform(st_pauls, 27700), 25000)
# In one line, transform england to BNG and cut out London
england_not_london_bng <- st_difference(st_transform(st_sfc(england, crs=4326), 27700), london_bng)
# project the other features and combine everything together
others_bng <- st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs=4326), 27700)
corrected <- c(others_bng, london_bng, england_not_london_bng)
# Plot that and marvel at the nice circular feature around London
par(mar=c(3,3,1,1))
plot(corrected, main='25km radius London', axes=TRUE)


##########Rasters 

# Rasters are a key spatial data type, representing a regular grid in space. 
# Defined by a coordinate system, origin, resolution, and dimensions (rows/columns), 
# they store data as a matrix. 
# Use the terra package (replacing the older raster package) for raster handling.
# Excellent documentation: https://rspatial.org/terra.

# Create a simple raster dataset from scratch by defining projection, bounds, and resolution.
# The raster object (SpatRaster class) starts without data, which can be added later.
# Note: terra requires EPSG codes as formatted text strings (e.g., "EPSG:4326"), not as numbers.

# Create an empty raster object covering UK and Eire
uk_raster_WGS84 <- rast(xmin=-11,  xmax=2,  ymin=49.5, ymax=59, 
                        res=0.5, crs="EPSG:4326")
hasValues(uk_raster_WGS84)

# Add data to the raster - just use the cell numbers
values(uk_raster_WGS84) <- cells(uk_raster_WGS84)
print(uk_raster_WGS84)

#then plot 
plot(uk_raster_WGS84)
plot(st_geometry(uk_eire_sf), add=TRUE, border='black', lwd=2, col='#FFFFFF44')

#you can change the raster resolution to be coarser or finer, think about your data in context and what it means when you aggregate and dissagregate your values

# Define a simple 4 x 4 square raster
m <- matrix(c(1, 1, 3, 3,
              1, 2, 4, 3,
              5, 5, 7, 8,
              6, 6, 7, 7), ncol=4, byrow=TRUE)
square <- rast(m)

plot(square, legend=NULL)
text(square, digits=2)


#### Aggregating Rasters 

# Average values
square_agg_mean <- aggregate(square, fact=2, fun=mean)
plot(square_agg_mean, legend=NULL)
text(square_agg_mean, digits=2)

# Aggregation groups raster cells based on a chosen factor (e.g., factor=2 for 2x2 blocks).
# For continuous data (e.g., height), use functions like mean or max to assign values.
# For categorical data (e.g., land cover), using mean is meaningless (e.g., the average of 
# Forest (2) and Moorland (3) codes has no interpretation). Use mode or another suitable function instead.


# Maximum values
square_agg_max <- aggregate(square, fact=2, fun=max)
plot(square_agg_max, legend=NULL)
text(square_agg_max, digits=2)

# Modal values for categories
square_agg_modal <- aggregate(square, fact=2, fun='modal')
plot(square_agg_modal, legend=NULL)
text(square_agg_modal, digits=2)

###Disaggregating rasters

# The disaggregate function splits each raster cell into smaller cells using a factor. 
# The factor represents the square root of the number of new cells created from each original cell.
# Values for new cells can simply copy the nearest parent cell's value, 
# which works well for both continuous and categorical data.

# Simply duplicate the nearest parent value
square_disagg <- disagg(square, fact=2, method='near')
plot(square_disagg, legend=NULL)
text(square_disagg, digits=2)


#Another option is to interpolate between the values to provide a smoother gradient between cells. This does not make sense for a categorical variable.

# Use bilinear interpolation
square_interp <- disagg(square, fact=2, method='bilinear')
plot(square_interp, legend=NULL)
text(square_interp, digits=1)


#Resampling

# The aggregate and disaggregate functions do not change cell origins or alignments;
# they only lump or split values within existing cell boundaries.

# However, rasters with the same projection can have different origins and resolutions,
# leading to mismatched cell boundaries. These datasets won’t align and need adjustment.

# To align datasets with different origins and alignments, use the resample function. 
# Resample handles such cases, but we won't explore it further here as it's a simpler case of more advanced techniques.

# Reprojecting raster data is conceptually more complex than vector data. 
# Here, we aim to transfer values between two rasters with different projections, 
# where cell borders may not align neatly.

# For instance, compare a 0.5° WGS84 raster of the UK and Eire with a 100km resolution 
# raster on the British National Grid. The irregular relationship between cell edges 
# makes transferring values challenging.

# Actual rasters must plot on a regular grid, so to visualize this, we can use vector grids. 
# The st_make_grid function (with other vector tools) can create vector grids to represent 
# cell edges from both raster grids for comparison. This highlights the complexity of 
# mapping values between the grids.

# make two simple `sfc` objects containing points in  the
# lower left and top right of the two grids
uk_pts_WGS84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2, 59)), crs=4326)
uk_pts_BNG <- st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs=27700)

#  Use st_make_grid to quickly create a polygon grid with the right cellsize
uk_grid_WGS84 <- st_make_grid(uk_pts_WGS84, cellsize=0.5)
uk_grid_BNG <- st_make_grid(uk_pts_BNG, cellsize=1e5)

# Reproject BNG grid into WGS84
uk_grid_BNG_as_WGS84 <- st_transform(uk_grid_BNG, 4326)

# Plot the features
par(mar=c(0,0,0,0))
plot(uk_grid_WGS84, asp=1, border='grey', xlim=c(-13,4))
plot(st_geometry(uk_eire_sf), add=TRUE, border='darkgreen', lwd=2)
plot(uk_grid_BNG_as_WGS84, border='red', add=TRUE)


# Use the project function for reprojection with two methods:
# - 'bilinear': interpolates a representative value from source data.
# - 'near': picks the nearest neighbour's value to the new cell centre.
# First, create the target raster (as a template, no data needed).
# Then, use it to store the reprojected data.

# Create the target raster
# Create a raster in the British National Grid (BNG) projection
uk_raster_BNG <- rast(
  xmin = -200000,     # Minimum x-coordinate of the raster extent
  xmax = 700000,      # Maximum x-coordinate of the raster extent
  ymin = 0,           # Minimum y-coordinate of the raster extent
  ymax = 1000000,     # Maximum y-coordinate of the raster extent
  res = 100000,       # Resolution: each cell is 100,000 x 100,000 units
  crs = '+init=EPSG:27700' # Coordinate Reference System: EPSG:27700 (BNG)
)

# Reproject a raster from WGS84 to BNG using bilinear interpolation
uk_raster_BNG_interp <- project(
  uk_raster_WGS84,    # Source raster in WGS84 (EPSG:4326)
  uk_raster_BNG,      # Target raster defining the extent and CRS
  method = 'bilinear' # Interpolation method: bilinear for smooth values
)

# Reproject a raster from WGS84 to BNG using nearest-neighbor interpolation
uk_raster_BNG_near <- project(
  uk_raster_WGS84,    # Source raster in WGS84 (EPSG:4326)
  uk_raster_BNG,      # Target raster defining the extent and CRS
  method = 'near'     # Interpolation method: nearest neighbor for categorical data
)


# Plotting the data reveals missing values in the top corners.
# Red cell centres don't align with the original grey grid, so project left them unassigned.
# Nearest neighbour reprojection shows more abrupt changes compared to bilinear.

# Missing values in the top-left and top-right corners occur because `project()` 
# leaves cells without data (NA) if they fall outside the extent of the source raster.

# The centers of the red cells (target raster) do not align with the original grey 
# grid (source raster) due to differences in their coordinate reference systems (CRS). 

# Interpolation methods:
# - Bilinear: Smooth transitions but leaves some NA values where no data is close.
# - Nearest Neighbor: More abrupt changes, suitable for categorical data.

# These issues are common in reprojection when grid alignments and extents differ.

par(mfrow=c(1,2), mar=c(0,0,0,0))
plot(uk_raster_BNG_interp, main='Interpolated', axes=FALSE, legend=FALSE)
text(uk_raster_BNG_interp, digit=1)
plot(uk_raster_BNG_near, main='Nearest Neighbour',axes=FALSE, legend=FALSE)
text(uk_raster_BNG_near)



###Vector to raster

# Create the target raster grid with 20 km resolution
uk_20km <- rast(
  xmin = -200000,       # Minimum x-coordinate of the raster extent
  xmax = 650000,        # Maximum x-coordinate of the raster extent
  ymin = 0,             # Minimum y-coordinate of the raster extent
  ymax = 1000000,       # Maximum y-coordinate of the raster extent
  res = 20000,          # Resolution: each cell is 20,000 x 20,000 units
  crs = '+init=EPSG:27700' # Coordinate Reference System: British National Grid (EPSG:27700)
)

# Rasterize the polygons from `uk_eire_BNG` into the 20 km raster grid
# Assign cell values based on the 'name' attribute of the polygons
uk_eire_poly_20km <- rasterize(
  uk_eire_BNG,          # Input polygon data (e.g., UK and Ireland boundaries)
  uk_20km,              # Target raster grid
  field = 'name'        # Attribute to assign to raster cells (e.g., region names)
)

# Plot the rasterized polygons
plot(uk_eire_poly_20km)

# - Rasterizing polygons is common, but you can also rasterize:
#   - Boundary lines (polygon outlines)
#   - Vertices (points defining polygon corners)

# - To rasterize boundaries or vertices:
#   - Recast polygons as linear features (for boundaries) or points (for vertices).
#   - This ensures the rasterization process treats the geometry appropriately.

# - The `sf` package provides warnings when altering geometries:
#   - This happens because the original attributes may not apply to the new geometries.
#   - Use `st_agr()` to declare that attributes are constant and suppress unnecessary warnings.

# - Convert the 'name' attribute to a factor for categorical rasterization
uk_eire_BNG$name <- as.factor(uk_eire_BNG$name)

# - Set attributes as constant to suppress sf warnings when altering geometries
st_agr(uk_eire_BNG) <- 'constant'

# - Rasterizing boundary lines:
#   - Convert polygons to LINESTRING geometry
uk_eire_BNG_line <- st_cast(uk_eire_BNG, 'LINESTRING')
#   - Rasterize the LINESTRING geometries
uk_eire_line_20km <- rasterize(uk_eire_BNG_line, uk_20km, field='name')

# - Rasterizing points:
#   - Two-step casting: Polygon -> Multipoint -> Point
uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, 'MULTIPOINT'), 'POINT')
#   - Rasterize the POINT geometries
uk_eire_point_20km <- rasterize(uk_eire_BNG_point, uk_20km, field='name')

# - Define a color palette for plotting
color_palette <- hcl.colors(6, palette = 'viridis', alpha = 0.5)

# - Plot the different rasterized outcomes side by side
par(mfrow = c(1, 3), mar = c(1, 1, 1, 1)) # Set up a 1x3 plotting layout

# - Plot rasterized polygons and overlay original polygon geometry in red
plot(uk_eire_poly_20km, col = color_palette, legend = FALSE, axes = FALSE)
plot(st_geometry(uk_eire_BNG), add = TRUE, border = 'red')

# - Plot rasterized boundary lines and overlay original polygon geometry in red
plot(uk_eire_line_20km, col = color_palette, legend = FALSE, axes = FALSE)
plot(st_geometry(uk_eire_BNG), add = TRUE, border = 'red')

# - Plot rasterized points and overlay original polygon geometry in red
plot(uk_eire_point_20km, col = color_palette, legend = FALSE, axes = FALSE)
plot(st_geometry(uk_eire_BNG), add = TRUE, border = 'red')

# Note the differences between polygon and line rasterization:
# - Polygons: A cell is included only if its center falls within the polygon.
# - Lines: A cell is included if the line touches it at any point.

# - This explains why coastal cells under the border may be missing in the 
#   polygon raster but are included in the line raster. Coastal cells' centers 
#   often fall outside the polygons, but the l


#tasks to do: 

#loading vector data 
#loading xy data
#Cropping data '
#reporjecting the pennine way 


