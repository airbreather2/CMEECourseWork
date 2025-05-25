

###Modules#######

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

###################


# Download a 1:100m scale world map
world_map <- ne_countries(scale = "small", returnclass = "sf")

#find the coordinate system (WGS84)
st_crs(world_map)

#Identify features of world map
st_geometry(world_map)

#load in data
mammals_iucn_data <- st_read("../data/MAMMALS/MAMMALS.shp")
#inspect
head(mammals_iucn_data)


#load in data
mammals_iucn_data <- st_read("../data/MAMMALS/MAMMALS.shp")

head(mammals_iucn_data)

######################loading animal shape files
bharaltest <- mammals_iucn_data[mammals_iucn_data$sci_name == "Pseudois nayaur", ]
bharal <- mammals_iucn_data[mammals_iucn_data$sci_name == "Pseudois nayaur" & is.na(mammals_iucn_data$subspecies),]
bharalsub <-mammals_iucn_data[mammals_iucn_data$sci_name == "Pseudois nayaur" & mammals_iucn_data$subspecies == "schaeferi",]
takin <- mammals_iucn_data[mammals_iucn_data$sci_name == "Budorcas taxicolor", ]
red_serrow <- mammals_iucn_data[mammals_iucn_data$sci_name == "Capricornis rubidus", ]
red_goral <- mammals_iucn_data[mammals_iucn_data$sci_name == "Naemorhedus baileyi", ]
indian_hog_deer <- mammals_iucn_data[mammals_iucn_data$sci_name == "Axis porcinus", ]
yak <- mammals_iucn_data[mammals_iucn_data$sci_name == "Bos mutus", ]
snowleopard <- mammals_iucn_data[mammals_iucn_data$sci_name == "Panthera uncia", ]
wild_bactrian <- mammals_iucn_data[mammals_iucn_data$sci_name == "Camelus ferus", ]
guar <- mammals_iucn_data[mammals_iucn_data$sci_name == "Moschus anhuiensis", ]


##########################################################

rm(map1)
# Plot the world map and overlay the species data with manual legend
  map1 <- ggplot() +
  # Add the blue ocean layer
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90, 
           fill = "lightblue", alpha = 0.3) +
  
  # Base world map
  geom_sf(data = world_map, fill = "#D1FFBD", alpha = 0.6, color = "black") + 
  
  # Add species ranges manually with fill mapped to legend names
 geom_sf(data = bharal, aes(fill = "Bharal (Host)"), alpha = 0.65, color = NA ) +
 geom_sf(data = bharalsub, aes(fill = "Bharal"), alpha = 0.65, color = NA) +
 geom_sf(data = takin, aes(fill = "Takin"), alpha = 0.6, color = NA) +
 geom_sf(data = red_serrow, aes(fill = "Red Serrow"), alpha = 0.9, color = NA) +
 geom_sf(data = red_goral, aes(fill = "Red Goral"), alpha = 0.6, color = NA) +
 geom_sf(data = yak, aes(fill = "Yak"), alpha = 0.6, color = NA) +
 geom_sf(data = wild_bactrian, aes(fill = "Wild Bactrian Camel"), alpha = 0.6, color = NA) +
    
    # Adding a north arrow
    annotation_north_arrow(location = "br", which_north = "true",
                           pad_x = unit(1, "cm"), pad_y = unit(1, "cm"),
                           style = north_arrow_fancy_orienteering()) +
    

  # Add a manual legend and change range colour 
  scale_fill_manual(
    name = "Species",
    values = c(
      "Bharal (Host)" = "#FF6961",
      "Takin" = "#60C4F2",
      "Red Serrow" = "#F37E17",
      "Red Goral" = "green",
      "Yak" = "purple",
      "Wild Bactrian Camel" = "yellow"
    ),
    guide = guide_legend(override.aes = list(size = 2, alpha = 0.8, color = "black"))
  ) +
  #title and location specification 
  ggtitle("Overlap of species of concern with host species") +
  coord_sf(xlim = c(60, 125), ylim = c(10, 55), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),  # Remove gridlines
    legend.position = "right",      # Position legend on the right
    legend.key.size = unit(1, "cm")  # Adjust legend square size
  )

# Display the map
print(map1)


######################Tabulating overlap

#################calculate overlap with host species #####################

# List of all other species
species_list <- list(
  bharaltest = bharaltest, 
  takin = takin, 
  red_serrow = red_serrow,
  red_goral = red_goral,
  indian_hog_deer = indian_hog_deer, 
  yak = yak, 
  wild_bactrian = wild_bactrian
)
# Initialize results data frame
overlap_results <- data.frame(
  Species = names(species_list),
  Overlap_Proportion = NA
)
# Calculate proportion of overlap
for (i in seq_along(species_list)) {
  # Ensure CRS consistency
  species_list[[i]] <- st_transform(species_list[[i]], st_crs(bharaltest))
  # Calculate intersection
  intersection <- st_intersection(bharaltest, species_list[[i]])
  # Total area of target species
  target_area <- st_area(species_list[[i]])
  # Area of overlap
  if (nrow(intersection) > 0) {  # Check if intersection exists
    overlap_area <- st_area(intersection)
    overlap_proportion <- as.numeric(sum(overlap_area) / sum(target_area))  # Proportion
    overlap_results$Overlap_Proportion[i] <- overlap_proportion
  } else {
    overlap_results$Overlap_Proportion[i] <- 0  # No overlap
  }
}
# Display results
print(overlap_results)



#################calculating km2 of overlap

# Initialize results data frame for overlap areas in km²
overlap_results <- data.frame(
  Species = names(species_list),
  Overlap_Area_km2 = NA
)

# Loop through species list to calculate overlaps
for (i in seq_along(species_list)) {
  # Ensure CRS consistency (WGS84 is lat/lon, transform to equal area for accurate area calculations)
  species_list[[i]] <- st_transform(species_list[[i]], crs = "+proj=cea +units=m")
  bharaltest_transformed <- st_transform(bharaltest, crs = "+proj=cea +units=m")
  
  # Calculate intersection
  intersection <- st_intersection(bharaltest_transformed, species_list[[i]])
  
  # Calculate total overlap area in km²
  if (nrow(intersection) > 0) {  # Check if intersection exists
    overlap_area <- sum(st_area(intersection)) / 1e6  # Convert m² to km²
    overlap_results$Overlap_Area_km2[i] <- round(as.numeric(overlap_area), 2)  # Round for clarity
  } else {
    overlap_results$Overlap_Area_km2[i] <- 0  # No overlap
  }
}

# Display results
print(overlap_results)



