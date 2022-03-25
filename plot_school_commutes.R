setwd("~/Projects/learnFRED/models/helloFRED")

library(tidyverse)
library(OpenStreetMap)

stulocs <- read_csv("student_locations.csv")
test <- stulocs[1:1000,]

# aes and ggplot2 expect single x and y parameters. So we need to group home
# and school coords into paired start,stop points 



# define the corners of the map.
# see this site: https://www.littlemissdata.com/blog/maps

# define the spatial extent to OpenStreetMap
lat1 <- 47.25; lat2 <- 47.95; lon1 <- -123.1; lon2 <- -121.5

# other 'type' options are "osm", "maptoolkit-topo", "bing", "stamen-toner",
# "stamen-watercolor", "esri", "esri-topo", "nps", "apple-iphoto", "skobbler";
# play around with 'zoom' to see what happens; 10 seems just right to me
sa_map <- openmap(c(lat2, lon1), c(lat1, lon2), zoom = 10, 
                  type = "esri-topo", mergeTiles = TRUE)

# use instead of 'ggplot()'
sa_map2 <- openproj(sa_map)
sa_map2_plt <- OpenStreetMap::autoplot.OpenStreetMap(sa_map2)

# annotate("text", label = "Atlantic\nOcean", 
#          x = 18.2, y = -33.8, size = 5.0, angle = -60, colour = "navy") +
# geom_point(data = cape_point_sites,
#            aes(x = lon + 0.002, y = lat - 0.007), # slightly shift the points
#            colour = "red", size =  2.5) +
# xlab("Longitude (°E)") + ylab("Latitude (°S)")
sa_map2_plt <- sa_map2_plt + geom_segment(data = test, 
          aes(x = home_longitude, y = home_latitude,
              xend = school_longitude, yend = school_latitude))
sa_map2_plt
