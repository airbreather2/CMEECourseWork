

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

human_pop <- rast("../data/gpw_v4_population_density_rev11_2020_15_min.tif")

# Convert to data frame
human_pop_df <- as.data.frame(human_pop, xy = TRUE, na.rm = TRUE)
colnames(human_pop_df)[3] <- "population_density"

# Threshold for top 5%
threshold <- quantile(human_pop_df$population_density, 0.95)

# Create a binary column for top 5% and others
human_pop_df$top5 <- ifelse(human_pop_df$population_density >= threshold, 1, 0)

# Remove 0 and negative values from the raster data
human_pop_df_filtered <- human_pop_df %>%
  filter(population_density > 0)

# Check the result
head(human_pop_df)

rm(map1)
# Load the world map
library(rnaturalearth)
world_map <- ne_countries(scale = "small", returnclass = "sf")

# Plot
map1 <- ggplot() +
  # Add the blue ocean background
  annotate("rect", xmin = -180, xmax = 180, ymin = -90, ymax = 90, 
           fill = "lightblue", alpha = 0.3) +
  
  # Add the base world map
  geom_sf(data = world_map, fill = "#D1FFBD", alpha = 0.6, color = "black", linewidth = 0.2) +
  
  # Add species ranges manually with fill mapped to legend names
  geom_sf(data = bharal, aes(fill = "Bharal"), alpha = 0.65, color = NA ) +
  geom_sf(data = bharalsub, aes(fill = "Bharal"), alpha = 0.65, color = NA) +
  geom_sf(data = takin, aes(fill = "Takin"), alpha = 0.6, color = NA) +
  geom_sf(data = red_serrow, aes(fill = "Red Serrow"), alpha = 0.9, color = NA) +
  geom_sf(data = red_goral, aes(fill = "Red Goral"), alpha = 0.6, color = NA) +
  geom_sf(data = yak, aes(fill = "Yak"), alpha = 0.6, color = NA) +
  geom_sf(data = wild_bactrian, aes(fill = "Wild Bactrian"), alpha = 0.6, color = NA) +
  
  # Add a manual legend and change range colour 
  scale_fill_manual(
    name = "Species",
    values = c(
      "Bharal" = "red",
      "Takin" = "#60C4F2",
      "Red Serrow" = "#F37E17",
      "Red Goral" = "green",
      "Yak" = "purple",
      "Wild Bactrian" = "brown"
    ),
    guide = guide_legend(override.aes = list(size = 2, alpha = 0.8, color = "black"))
  ) +
  
  # Plot top 5% tiles only
  geom_tile(data = human_pop_df %>% filter(top5 == 1),
            aes(x = x, y = y), fill = "black", alpha = 1) +
  
  # Map settings
  ggtitle("Top 5% Human Population Density in Himalayas and Tibet") +
  coord_sf(xlim = c(60, 130), ylim = c(5, 50), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),   # Remove gridlines
    legend.position = "right",      # Legend position
    legend.key.size = unit(1, "cm") # Legend size
  )

# Display the map
print(map1)



