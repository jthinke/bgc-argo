# chnage i to plot different panels (1, or 2)
i<-2

windows()
colx<-colorRampPalette(c("white","#d95f02"))
coly<-colorRampPalette(c("lightblue","#7570b3"))
coll<-list(colx=colx, coly=coly)
bathycols<-colorRampPalette(c("gray10", "gray90"))
plot(pf$geometry, axes=FALSE, col=1, xlim=c(-5e+06, 5e+06), ylim=c(-5.1e+06, 5e+06))
plot(bathy, col=bathycols(16), add=TRUE, legend=FALSE)

longs<-seq(from=-180, by=1, to=180)
lats<-seq(from=-80, by=5, to=-45)
nlongs<-length(longs)
nlats<-length(lats)

# plot custom lines of latitude first
for(j in 1:nlats){
  x<-longs
  y<-rep(lats[j], length=nlongs)
  xy<-data.frame(x=x,y=y)
  xy<- sf::st_as_sf(xy, coords = c("x","y"))
  xy<-sf::st_set_crs(xy, 4326) 
  xy<-sf::st_transform(xy, 3031)
  nc<-round(length(xy$geometry)/2,0)
  text.xy<-sf::st_coordinates(xy)[nc,]
  text(x=text.xy[1]+250000, y=text.xy[2], labels=lats[j], cex=0.66)
  plot(xy$geometry, type="l", lty=1, lwd=0.25, col="gray", add=TRUE)
}

longs<-seq(from=-180, by=20, to=160)
lats<-seq(from=-80, by=5, to=-45)
nlongs<-length(longs)
nlats<-length(lats)

#now plot custom lines of longitude and add text to ID
for(k in 1:nlongs){
  y<-lats
  x<-rep(longs[k], length=nlats)
  xy<-data.frame(x=x,y=y)
  xy <- sf::st_as_sf(xy, coords = c("x","y"))
  xy<-sf::st_set_crs(xy, 4326) 
  xy<-sf::st_transform(xy, 3031)
  plot(xy$geometry, type="l", lty=1, lwd=0.25, col="gray", add=TRUE)
  #nc<-length(xy$geometry)
  text.xy<-data.frame(x=longs[k], y=max(lats)+2.5)%>%
    st_as_sf(coords=c("x","y"))%>%
    st_set_crs(4326)%>%
    st_transform(3031)
  text.xy<-sf::st_coordinates(text.xy)
  text(x=text.xy[1], y=text.xy[2], labels=longs[k], cex=0.66, srt=-longs[k])
}
ice.col<-"#6C8896"
plot(ice$geometry, col=ice.col, border=ice.col, add=TRUE)
plot(ant$geometry, col="#1A1A1A", add=TRUE)
plot(isl$geometry, col="#1A1A1A", add=TRUE)

# set fully transparent white for 0-value kde estimates?
f1<-kdes[[i]]
COL<-coll[[i]]
imagePlot(f1, col=c("#FFFFFF00", COL(12)[2:12]), legend.line=4, 
          smallplot=c(0.8,0.825, 0.55,0.8), legend.lab="Density", add=TRUE)
# imagePlot(f2, col=c("#FFFFFF00", coly(12)[2:12]), legend.line=4, 
#           smallplot=c(0.8,0.825, 0.25,0.5), legend.lab="Density", add=TRUE)

plot(sbdy$geometry, lty=1, add=TRUE)
plot(pf$geometry, lty=2,  add=TRUE)