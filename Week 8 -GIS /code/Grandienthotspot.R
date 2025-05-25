### Modules #######
library(dplyr)
library(terra)
library(raster)
library(sf)
library(sp)
library(dismo)
library(units)     # used for precise unit conversion
library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(ggforce)
library(ggspatial)
# Load ggnewscale
library(ggnewscale)
############### LOAD IN MAP AND MAMMAL SHAPEFILES ###########

# Download a 1:100m scale world map
world_map <- ne_countries(scale = "small", returnclass = "sf")

# Load mammal shapefiles
mammals_iucn_data <- st_read("../data/MAMMALS/MAMMALS.shp")

# Load species ranges
bharaltest <- mammals_iucn_data[mammals_iucn_data$sci_name == "Pseudois nayaur", ]
red_goral <- mammals_iucn_data[mammals_iucn_data$sci_name == "Naemorhedus baileyi", ]
red_serrow <- mammals_iucn_data[mammals_iucn_data$sci_name == "Capricornis rubidus", ]
takin <- mammals_iucn_data[mammals_iucn_data$sci_name == "Budorcas taxicolor", ]
wild_bactrian <- mammals_iucn_data[mammals_iucn_data$sci_name == "Camelus ferus", ]
yak <- mammals_iucn_data[mammals_iucn_data$sci_name == "Bos mutus", ]

##########################################################

################# LOAD HUMAN POP DENSITY DATA ###################

# Load human population raster
human_pop <- rast("../data/gpw_v4_population_density_rev11_2020_15_min.tif")

# Calculate the global top 5% threshold
human_pop_df_global <- as.data.frame(human_pop, xy = TRUE, na.rm = TRUE)
colnames(human_pop_df_global)[3] <- "population_density"
global_threshold <- quantile(human_pop_df_global$population_density, 0.95)

################# PREPARE SPECIES RANGES ###################

# Combine species ranges
species_ranges <- rbind(
  mutate(bharaltest, species = "Bharal"),
  mutate(red_goral, species = "Red Goral"),
  mutate(red_serrow, species = "Red Serrow"),
  mutate(takin, species = "Takin"),
  mutate(wild_bactrian, species = "Wild Bactrian"),
  mutate(yak, species = "Yak")
)

species_ranges <- st_transform(species_ranges, crs(human_pop))  # Align CRS

################ MASK POPULATION DATA TO SPECIES RANGES ###################

# Mask the raster to include only the area within species ranges
masked_human_pop <- mask(human_pop, vect(species_ranges))  # Mask raster

# Convert masked raster to data frame
masked_df <- as.data.frame(masked_human_pop, xy = TRUE, na.rm = TRUE)
colnames(masked_df)[3] <- "population_density"  # Rename column

# Filter to include only top 5% population densities
masked_df_top5 <- masked_df %>% filter(population_density >= global_threshold)

####################################### PLOT MAP ########################################

# Plot map
map2 <- ggplot() +
  # Add blue ocean background
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90,
           fill = "lightblue", alpha = 0.3) +
  
  # Add base world map
  geom_sf(data = world_map, fill = "#D1FFBD", alpha = 0.6, color = "black", linewidth = 0.2) +
  
  # Add species ranges with discrete colors
  geom_sf(data = species_ranges, aes(fill = species), alpha = 0.5, color = NA) +
  
  # Manual color scale for species ranges
  scale_fill_manual(
    name = "Species",
    values = c(
      "Bharal" = "#FF6961",
      "Red Goral" = "green",
      "Red Serrow" = "#F37E17",
      "Takin" = "#60C4F2",
      "Wild Bactrian" = "yellow",
      "Yak" = "purple"
    )
  ) +
  
  # Reset the fill scale for population density
  new_scale_fill() +
  
  # Add top 5% population density as a gradient
  geom_tile(data = masked_df_top5, 
            aes(x = x, y = y, fill = population_density), 
            width = 0.3, height = 0.3, alpha = 0.7) +
  
  # Gradient scale for population density
  scale_fill_gradient(
    name = "Population Density (Top 5%)",
    low = "black", high = "red", na.value = "transparent"
  ) +
  
  # Adding a north arrow
  annotation_north_arrow(location = "br", which_north = "true",
                         pad_x = unit(1, "cm"), pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering()) +
  
  # Title and map settings
  ggtitle("Top 5% Global Human Population Density Gradient within Species Ranges") +
  coord_sf(xlim = c(70, 115), ylim = c(20, 47), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),  # Remove gridlines
    legend.position = "right"      # Place legend to the right
  )

# Display the map
print(map2)
