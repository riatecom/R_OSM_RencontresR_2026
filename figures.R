library(mapsf)
library(maptiles)
library(maposm)
library(terra)
library(sf)

point <- c(x = -1.555, y = 47.234) |>
  matrix(ncol = 2, nrow = 1) |>
  st_point() |>
  st_sfc(crs = "EPSG:4326") |>
  st_transform("EPSG:3857")
zone <- point |>
  st_buffer(1000)

# osm_tiles <- get_tiles(zone, crop = T)
# osm2 <- mask(osm_tiles, vect(zone))
# writeRaster(osm2, filename = "data/osm2.tif")

osm2 <- rast("data/osm2.tif")


mf_theme(mar = c(0,0,0,0), background = NA)
mf_png(x = zone, filename = "fig/osm_tiles.png", width = 420, height = 420)
mf_raster(osm2)
mf_map(zone, add = T, col = NA, lwd = 1)
mf_credits(txt = "\ua9 OpenStreetMap contributors")
dev.off()





# osm_v <- om_get(x =  c(x = -1.555, y = 47.234),quiet = F)
# om_write(osm_v, filename = "data/osm_v.gpkg")
osm_v <- om_read("data/osm_v.gpkg")
mf_theme(mar = c(0,0,0,0), background = NA)
mf_png(x = zone, filename = "fig/osm_vect.png", width = 420, height = 420, expandBB =c(-0.04,-0.038,-0.04,-0.038))
mf_map(osm_v$zone, col = "#f2efe9", border = NA, add = F, expandBB = c(-0.04,-0.038,-0.04,-0.038))
mf_map(osm_v$urban, col = "#e0dfdf", border = "#e0dfdf", lwd = .5, add = TRUE)
mf_map(osm_v$green, col = "#c8facc", border = "#c8facc", lwd = .5, add = TRUE)
mf_map(osm_v$water, col = "#aad3df", border = "#aad3df", lwd = .5, add = TRUE)
mf_map(osm_v$railway, col = "grey50", lty = 2, lwd = .2, add = TRUE)
mf_map(osm_v$road, col = "white", border = "white", lwd = .5, add = TRUE)
mf_map(osm_v$street, col = "white", border = "white", lwd = .5, add = TRUE)
mf_map(osm_v$building, col = "#d9d0c9", border = "#c6bab1", lwd = .5, add = TRUE)
mf_map(zone, add = T, col = NA, lwd = 1)
mf_scale(size = 250, scale_units = "m")
dev.off()

