###Modules#######
library(dplyr)
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
library(ggforce)
library(ggspatial)
install.packages(ggshadowtext)
library(ggshadowtext)  # For glow effects (install if missing)
###############LOAD IN MAP AND MAMMAL SHAPEFILES 

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

############################load in human pop dens data ###################


# Load human population raster
human_pop <- rast("../data/gpw_v4_population_density_rev11_2020_15_min.tif")

# Calculate the global top 5% threshold
human_pop_df_global <- as.data.frame(human_pop, xy = TRUE, na.rm = TRUE)
colnames(human_pop_df_global)[3] <- "population_density"
global_threshold <- quantile(human_pop_df_global$population_density, 0.95)

##################Tabulating species hotspots ####################################

# Create binary raster for hotspots (1 = hotspot, 0 = not)
hotspot_raster <- human_pop >= global_threshold


# Load species ranges (vector data)
species_list <- list(
  Bharal = bharaltest, 
  Red_Goral = red_goral,
  Red_Serrow = red_serrow,
  Takin = takin,
  Wild_Bactrian = wild_bactrian,
  Yak = yak
)

# Ensure CRS consistency between species ranges and raster
species_list <- lapply(species_list, function(species) {
  st_transform(species, crs(hotspot_raster))
})

############### COUNT HOTSPOTS IN SPECIES RANGES ###############

# Initialize a table to store the results
hotspot_counts <- data.frame(
  Species = names(species_list),
  HotspotCount = integer(length(species_list))
)

# Loop through each species to calculate hotspot counts
for (i in seq_along(species_list)) {
  species <- species_list[[i]]
  # Mask hotspot raster to the species range
  species_hotspot_raster <- mask(hotspot_raster, vect(species))
  # Count the number of cells with value 1 (hotspots)
  hotspot_count <- sum(values(species_hotspot_raster), na.rm = TRUE)
  # Store the result
  hotspot_counts$HotspotCount[i] <- hotspot_count
}

# View the hotspot count results
print(hotspot_counts)

####################################################################



# Mask the raster to include only the area within species ranges
species_ranges <- rbind(bharaltest, red_goral, red_serrow, takin, wild_bactrian, yak)
species_ranges <- st_transform(species_ranges, crs(human_pop))  # Align CRS
masked_human_pop <- mask(human_pop, vect(species_ranges))       # Mask raster

# Convert masked raster to data frame
masked_df <- as.data.frame(masked_human_pop, xy = TRUE, na.rm = TRUE)
colnames(masked_df)[3] <- "population_density"  # Rename column

# Add a binary column for the global top 5% threshold
masked_df$top5_global <- ifelse(masked_df$population_density >= global_threshold, 1, 0)

# Calculate the top 5% threshold **only** within the species range
threshold <- quantile(masked_df$population_density, 0.95, na.rm = TRUE)
masked_df$top5 <- ifelse(masked_df$population_density >= threshold, 1, 0)

# Load world map
world_map <- ne_countries(scale = "small", returnclass = "sf")

################################add species range maps #######################################


# Combine species ranges into a single object with a new 'species' column
species_ranges <- rbind(
  mutate(bharaltest, species = "Bharal"),
  mutate(red_goral, species = "Red Goral"),
  mutate(red_serrow, species = "Red Serrow"),
  mutate(takin, species = "Takin"),
  mutate(wild_bactrian, species = "Wild Bactrian"),
  mutate(yak, species = "Yak")
)

species_ranges <- st_transform(species_ranges, crs(human_pop))  # Align CRS


#####################################################################################

rm(map2)
# Plot map
map2 <- ggplot() +
  # Add blue ocean background
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90,
           fill = "lightblue", alpha = 0.3) +
  
  # Add base world map
  geom_sf(data = world_map, fill = "#D1FFBD", alpha = 0.6, color = "black", linewidth = 0.2) +
  
  # Add species ranges
  geom_sf(data = species_ranges, aes(fill = "Species Range"), alpha = 0.5, color = NA) +
  
  # Add species ranges in different colors (but share the same legend)
  geom_sf(data = bharaltest, fill = "#FF6961", alpha = 0.5, color = NA, show.legend = TRUE) +
  geom_sf(data = red_goral, fill = "green", alpha = 0.5, color = NA, show.legend = TRUE) +
  geom_sf(data = red_serrow, fill = "#F37E17", alpha = 0.5, color = NA, show.legend = TRUE) +
  geom_sf(data = takin, fill = "#60C4F2", alpha = 0.5, color = NA, show.legend = TRUE) +
  geom_sf(data = wild_bactrian, fill = "yellow", alpha = 0.5, color = NA, show.legend = TRUE) +
  geom_sf(data = yak, fill = "purple", alpha = 0.5, color = NA, show.legend = TRUE) +
  
  # Add "halo" around human hotspot tiles
  geom_tile(data = masked_df %>% filter(top5_global == 1),
            aes(x = x, y = y), 
            width = 0.05, height = 0.05,  # Slightly larger halo
            fill = "yellow", alpha = 0.4) +
  
  # Plot top 5% global population density tiles within species ranges
  geom_tile(data = masked_df %>% filter(top5_global == 1),
            aes(x = x, y = y, fill = "Human Hotspot"), 
            width = 0.3, height = 0.3, alpha = 0.7) +  # Smaller tiles
  
  # Adding a north arrow
  annotation_north_arrow(location = "br", which_north = "true",
                         pad_x = unit(1, "cm"), pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering()) +
  
  # Define custom colors for species and hotspots in the legend
  scale_fill_manual(
    name = "Legend", 
    values = c(
      "Bharal" = "red",
      "Takin" = "#60C4F2",
      "Red Serrow" = "#F37E17",
      "Red Goral" = "green",
      "Yak" = "purple",
      "Human Hotspot" = "black"
    ),
    breaks = c("Bharal", "Red Goral", "Red Serrow", "Takin", "Wild Bactrian", "Yak", "Human Hotspot"),
    labels = c("Bharal", "Red Goral", "Red Serrow", "Takin", "Wild Bactrian", "Yak", "Top 5% Human Hotspot")
  ) +
  
  # Title and map settings
  ggtitle("Areas of top 5% Global Human Population Density within Species Ranges") +
  coord_sf(xlim = c(70, 115), ylim = c(20, 47), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),  # Remove gridlines
    legend.position = "right"      # Place legend to the right
  )

# Display the map
print(map2)




#######################################################find range and median

# Check the CRS of the raster
print(crs(human_pop))

# Initialize a table to store population density results
pop_density_results <- data.frame(
  Species = names(species_list),
  Median_Population_Density = NA,
  Min_Population_Density = NA,
  Max_Population_Density = NA
)

# Loop through each species to calculate population density stats
for (i in seq_along(species_list)) {
  species <- species_list[[i]]
  
  # Align species CRS with the raster CRS
  species_aligned <- st_transform(species, crs(human_pop))
  
  # Mask human population raster to the species range
  masked_species_pop <- mask(human_pop, vect(species_aligned))
  
  # Extract population density values
  pop_values <- values(masked_species_pop)
  
  # Check if the extracted values are NULL or all NA
  if (!is.null(pop_values) && any(!is.na(pop_values))) {
    # Calculate statistics
    pop_density_results$Median_Population_Density[i] <- median(pop_values, na.rm = TRUE)
    pop_density_results$Min_Population_Density[i] <- min(pop_values, na.rm = TRUE)
    pop_density_results$Max_Population_Density[i] <- max(pop_values, na.rm = TRUE)
  } else {
    # Assign NA if no valid population data is found
    pop_density_results$Median_Population_Density[i] <- NA
    pop_density_results$Min_Population_Density[i] <- NA
    pop_density_results$Max_Population_Density[i] <- NA
  }
}

# View results
print(pop_density_results)



