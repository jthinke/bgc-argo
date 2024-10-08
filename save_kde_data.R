# function to retrieve lat/lon for kde analysis

# runs from line 240 u]in Figure 3mp.RMD
save_kde_data<-function(tt){
kdexy<-tt%>%
  st_transform(4231)%>%
  st_coordinates()%>%
  as.data.frame()

kdedata<-tt
kdedata$lon<-kdexy$X
kdedata$lat<-kdexy$Y
kdedata$lon<-ifelse(kdedata$lon>0, kdedata$lon-360, kdedata$lon)

kdedata<-kdedata[kdedata$month>3,]

h1<-mean(c(width.SJ(kdedata$lon), bandwidth.nrd(kdedata$lon)))
h2<-mean(c(width.SJ(kdedata$lat), bandwidth.nrd(kdedata$lat)))

kdedata.chpe<-kdedata[kdedata$spp=="CHPE",]
kdedata.ses<-kdedata[kdedata$spp=="SES",]
f1<-kde2d(x=kdedata.chpe$lon, y=kdedata.chpe$lat, n = 100, h = c(h1, h2))
f2<-kde2d(x=kdedata.ses$lon, y=kdedata.ses$lat, n = 100, h = c(h1, h2))

imagePlot(f1)
imagePlot(f2)

chpe_kde<-as.data.frame(f1)
ses_kde<-as.data.frame(f2)

write.csv(chpe_kde, "chpe_kde.csv")
write.csv(ses_kde, "ses_kde.csv")
}