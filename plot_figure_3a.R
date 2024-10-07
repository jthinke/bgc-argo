# chnage i to plot different panels (1, or 2)
i<-2

windows()
bathycols<-colorRampPalette(c("gray10", "gray90"))
plot(pf$geometry, axes=FALSE, col=1, xlim=c(-5e+06, 5e+06), ylim=c(-5.1e+06, 5e+06))
plot(bathy, col=bathycols(16),smallplot=c(0.8,0.825, 0.55,0.8), legend.line=4,
     legend.lab="Depth (m)", add=TRUE)
#
longs<-seq(from=-180, by=1, to=180)
lats<-seq(from=-80, by=5, to=-45)
nlongs<-length(longs)
nlats<-length(lats)
# plot lines of latitude first
for(j in 1:nlats){
  x<-longs
  y<-rep(lats[j], length=nlongs)
  xy<-data.frame(x=x,y=y)
  xy <- sf::st_as_sf(xy, coords = c("x","y"))
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

#now plot lines of longitude and add text to indicate which
for(k in 1:nlongs){
  y<-lats
  x<-rep(longs[k], length=nlats)
  xy<-data.frame(x=x,y=y)
  xy<- sf::st_as_sf(xy, coords = c("x","y"))
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
#ice.col<-adjustcolor("grey40", alpha.f=0.5)
ice.col<-"#6C8896"
plot(ice$geometry, col=ice.col, border=ice.col, add=TRUE)
plot(ant$geometry, axes=FALSE, col="#1A1A1A", add=TRUE, lwd=0.1)
plot(isl$geometry, axes=FALSE, col="#1A1A1A", add=TRUE, lwd=0.1)
mons<-unique(tt$month)
nmons<-length(mons)

# reorder months for emphasizing mid-winter on top
mons<-c(2,3,4,9,10,11,5,6,7,8)
CEX<-c(0.5,0.5,0.5,0.5, 0.5,0.5,0.75,0.75,0.75,0.75)

COLS<-c("#542788","#313695","#4575b4","#c51b7d",
        "#de77ae","#f1b6da","#fee090","#fdae61","#f46d43",
        "#d73027")
# plot once for chpe, then for ses
tts<-tt[tt$spp==SPP[i],]
for(ii in 1:nmons){
  tt.dat<-tts[tts$month==mons[ii],]
  ids<-unique(tt.dat$id)
  nids<-length(ids)
  for(jj in 1:nids){
    m.dat<-tt.dat[tt.dat$id==ids[jj],]
    plot(m.dat$geometry, pch=16, col=COLS[ii], cex=CEX[ii], add=TRUE)
  }
}
plot(sbdy$geometry, axes=FALSE, col=1, add=TRUE, lty=1)
plot(pf$geometry, axes=FALSE, col=1, add=TRUE, lty=2)

legend(x=6500000, y=480000,
       title="Monthly positions",
       legend=c("Feb","Mar","Apr","May","Jun","Jul",
                "Aug","Sep","Oct","Nov"),
       pch=16,col=c("#542788","#313695","#4575b4","#fee090","#fdae61","#f46d43",
                    "#d73027","#c51b7d",
                    "#de77ae","#f1b6da"),
       pt.cex=1,
       bty="n")