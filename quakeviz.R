# The intent of this very simple project is to create a 3D visualization of where
# the earthquakes in the built-in quakes dataset occurred. Many of the visualizations
# of this dataset that are demonstrated in instructional materials focus on 2D mapping
# of the surface-level epicenters of these earthquakes, so the intent here is to
# quite literally take a deeper look.
# A quick example of the usual 2D viz of quakes:
plot(quakes$long,quakes$lat,pch=20,cex=0.5)

# For a 3D version of this, the rgl package needs to be installed (if not already) and
# loaded.
install.packages("rgl")
library("rgl")

# It is necessary to make sure the x, y, and z axes of the resulting plot are correct.
# the x-axis needs to be the longitude, as longitudinal values change with movement
# between west and east. In the part of the world where Fiji is located, longitudes
# increase to the east, therefore, there is a positive correlation between x-values
# and longitude. For the latitude, since Fiji is in the southern hemisphere, all of the
# values are negative, and they increase to the north, so latitudes positively correlate
# with the y-axis. Without incorporating the z-axis yet, we can see a flat rendition
# of where we're at so far that comes out similar to the 2D plot above.
plot3d(quakes$long,quakes$lat,0)

# This brings us to the z-axis: the depth of the earthquakes. This information is
# contained in quakes$depth and can be incorporated for a 3D visual. However, a bit of
# spatial logic here has to be considered: since the depths are measured in positive
# integers, a greater number indicates a quake that originated further below the
# surface. This means it is important to establish an inverse relationship between
# the depth variable and the z-axis of the resulting 3D plot.
plot3d(quakes$long,quakes$lat,-quakes$depth)

# Now we have a nice 3D representation of a slice of the Earth's crust beneath Fiji
# that shows us exactly where each quake in the dataset originated. Dragging the box
# to look at a top-down perspective shows the same pattern we've observed in our 2D
# surface visualizations so far.
# More can be done to provide a dynamic visualization of the available information.
# For example, maybe we want to incorporate magnitude information into this. The
# dataset includes magnitudes ranging from 4.0 to 6.4 in increments of 0.1 for a
# total of 25 possible values. One way to differentiate this is with color. The color
# palette used here is up to the user; personally, after playing around with it for a
# bit, I found a blue/orange/red palette to be the most striking against plot3d()'s
# default white background.
mag.pal <- colorRampPalette(c("blue","orange","red"))
cols <- mag.pal(25)
mag.cols <- cut(quakes$mag,breaks=seq(min(quakes$mag),max(quakes$mag),length=25),
                include.lowest=TRUE)

# Now, we're able to get a visual that gives us the ability to quickly glance and see
# where the worst earthquakes occurred. The dots have been a little on the small side
# in our initial visualization, so size=7 helps a little, especially if the visualization
# window is maximized. Also, we should add labels to our axes.
plot3d(quakes$long,quakes$lat,-quakes$depth,col=cols[mag.cols],size=7,xlab="Longitude",
       ylab="Latitude",zlab="Depth")

# Looking at this visualization for a few minutes can actually help us figure out some
# information. There appears to be an intersection here of two major fault lines along
# which most of the earthquakes occurred; one to the west running northwest to southeast,
# and another to the east running northeast to southwest. The eastern fault line appears
# to produce more earthquakes, deeper below the surface, and of less intensity than the
# western one.
# This type of analysis can be used to look at a lot more earthquake data than the built-in
# quakes dataset; any earthquake data that includes lat/long, depth, and magnitude
# information can be turned into this type of visualization. I encourage you to try it
# with other earthquake datasets and see what you find!