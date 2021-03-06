#write start date for first analysis
sD<-as.Date("2019-05-01")
#Write end date for first analysis
eD<-as.Date("2019-09-15")

#Irrigation####
Irrig<- (downloadTOA5("PACE_AUTO_ALL_IRRIG_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,4:6)]

#Rename columns
names(Irrig)<-c("DateTime","Plot","Treatment","Irrigation")
Irrig$Date<-as.Date(Irrig$DateTime)

#force Treatment to be a factor
Irrig$Treatment<-as.factor(Irrig$Treatment)
Irrig<-Irrig[order(Irrig$Date,Irrig$Treatment),]
Irrig<-aggregate(data=Irrig,Irrigation~Date+Treatment,FUN=mean)
levels(Irrig$Treatment)<-c("Con","Drt","Con","Drt")

#subset data by treatment
Irrig1<-subset(Irrig, Treatment == "Con")
Irrig2<-subset(Irrig[Irrig$Date>"2019-05-31"&Irrig$Date<"2019-12-01",], Treatment == "Drt")
Irrig2[Irrig2$Irrigation==0.000000,]<-NA

#Soil Moisture####
#only keep moisture variables of interest
s1 <- (downloadTOA5("PACE_AUTO_S1_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]
s2 <- (downloadTOA5("PACE_AUTO_S2_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]
s3 <- (downloadTOA5("PACE_AUTO_S3_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]
s4 <- (downloadTOA5("PACE_AUTO_S4_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]
s5 <- (downloadTOA5("PACE_AUTO_S5_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]
s6 <- (downloadTOA5("PACE_AUTO_S6_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,3:18)]

#Rename columns
names(s1)<-c("DateTime","1RYEUpperAmbDrt",
             "2RYEUpperAmbCon",
             "3LUCUpperAmbDrt",
             "3LUCLowerAmbDrt",
             "3FESUpperAmbDrt",
             "4FESUpperEleCon",
             "4LUCUpperEleCon",
             "4LUCLowerEleCon",
             "5FESUpperEleDrt",
             "5LUCUpperEleDrt",
             "5LUCLowerEleDrt",
             "6LUCUpperAmbCon",
             "6LUCLowerAmbCon",
             "6FESUpperAmbCon",
             "7BISUpperAmbDrt",
             "8BISUpperAmbCon")

names(s2)<-c("DateTime","1BISUpperAmbCon",
             "2BISUpperAmbDrt",
             "3LUCUpperEleDrt",
             "3LUCLowerEleDrt",
             "3FESUpperEleDrt",
             "4LUCLowerAmbDrt",
             "4LUCUpperAmbDrt",
             "4FESUpperAmbDrt",
             "5LUCUpperAmbCon",
             "5LUCLowerAmbCon",
             "5FESUpperAmbCon",
             "6LUCUpperEleCon",
             "6LUCLowerEleCon",
             "6FESUpperEleCon",
             "7RYEUpperAmbDrt",
             "8RYEUpperAmbCon")

names(s3)<-c("DateTime","1RYEUpperAmbCon",
             "2RYEUpperAmbDrt",
             "3FESUpperAmbCon",
             "3LUCUpperAmbCon",
             "3LUCLowerAmbCon",
             "4LUCUpperEleCon",
             "4LUCLowerEleCon",
             "4FESUpperEleCon",
             "5FESUpperEleDrt",
             "5LUCUpperEleDrt",
             "5LUCLowerEleDrt",
             "6LUCUpperAmbDrt",
             "6LUCLowerAmbDrt",
             "6FESUpperAmbDrt",
             "7BISUpperAmbDrt",
             "8BISUpperAmbCon")

names(s4)<-c("DateTime","1RYEUpperAmbCon",
             "2RYEUpperAmbDrt",
             "3LUCUpperEleCon",
             "3LUCLowerEleCon",
             "3FESUpperEleCon",
             "4LUCUpperAmbDrt",
             "4LUCLowerAmbDrt",
             "4FESUpperAmbDrt",
             "5FESUpperAmbCon",
             "5LUCUpperAmbCon",
             "5LUCLowerAmbCon",
             "6FESUpperEleDrt",
             "6LUCUpperEleDrt",
             "6LUCLowerEleDrt",
             "7BISUpperAmbCon",
             "8BISUpperAmbDrt")

names(s5)<-c("DateTime","1BISUpperAmbDrt",
             "2BISUpperAmbCon",
             "3FESUpperEleCon",
             "3LUCUpperEleCon",
             "3LUCLowerEleCon",
             "4FESUpperAmbDrt",
             "4LUCUpperAmbDrt",
             "4LUCLowerAmbDrt",
             "5LUCUpperEleDrt",
             "5FESUpperEleDrt",
             "5LUCLowerEleDrt",
             "6LUCUpperAmbCon",
             "6LUCLowerAmbCon",
             "6FESUpperAmbCon",
             "7RYEUpperAmbDrt",
             "8RYEUpperAmbCon")

names(s6)<-c("DateTime","1RYEUpperAmbCon",
             "2RYEUpperAmbDrt",
             "3LUCUpperEleDrt",
             "3LUCLowerEleDrt",
             "3FESUpperEleDrt",
             "4FESUpperAmbCon",
             "4LUCUpperAmbCon",
             "4LUCLowerAmbCon",
             "5LUCUpperEleCon",
             "5LUCLowerEleCon",
             "5FESUpperEleCon",
             "6LUCUpperAmbDrt",
             "6LUCLowerAmbDrt",
             "6FESUpperAmbDrt",
             "7BISUpperAmbDrt",
             "8BISUpperAmbCon")

#convert to long form, add "shelter" variable
s1<-melt(s1,id.vars="DateTime")
s1$Shelter<-1
s2<-melt(s2,id.vars="DateTime")
s2$Shelter<-2
s3<-melt(s3,id.vars="DateTime")
s3$Shelter<-3
s4<-melt(s4,id.vars="DateTime")
s4$Shelter<-4
s5<-melt(s5,id.vars="DateTime")
s5$Shelter<-5
s6<-melt(s6,id.vars="DateTime")
s6$Shelter<-6

s1<-rbind(s1,s2,s3,s4,s5,s6)

#LUC####
x<-"LUC"
#create new dfs based on species
s1plot<-s1[grep(x, s1$variable),]
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##recognize variables as factors instead of characters
s1plot$Species<-as.factor(s1plot$Species)
s1plot$Plot<-as.factor(s1plot$Plot)
s1plot$Shelter<-as.factor(s1plot$Shelter)

##average and standard error by treatment
s1plot<-na.omit(s1plot)
s1plot$Date<-as.Date(s1plot$DateTime)
s1plot<-aggregate(data=s1plot,value~Date+Treatment+Shelter+Plot,FUN=mean,simplify=TRUE,drop=TRUE)
s1plot<-aggregate(data=s1plot,value~Date+Treatment,FUN=function(x) c(avg=mean(x),upper=mean(x)+sd(x)/sqrt(length(x)),lower=mean(x)-sd(x)/sqrt(length(x))),simplify=TRUE,drop=TRUE)
s1plot2<-data.frame(s1plot[["value"]])
s1plot$value<-s1plot2$avg
s1plot$upper<-s1plot2$upper
s1plot$lower<-s1plot2$lower

#rename columns
s1plot$Treatment<-factor(s1plot$Treatment,levels=c("UpperAmbCon","LowerAmbCon","UpperAmbDrt","LowerAmbDrt",
                                                   "UpperEleCon","LowerEleCon","UpperEleDrt","LowerEleDrt"))
s1plot<-s1plot[order(s1plot$Date,s1plot$Treatment),]

ymax<-max(s1plot$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(s1plot$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
n<-levels(s1plot$Treatment)
for(i in n){
   df1<-subset(s1plot, Treatment == i)
   assign(paste("df",match(i,n),sep=""),df1)
}

#export graphs to tiff----
tiff(file = paste("FIELD",x,"Daily Soil_Moisture",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 

#LUC plot----
par(mfrow=c(2,1),oma=c(4,3,3,0))

#Soil moisture plot
#Upper sensors
par(mar =c(0,0,0,3))
plot(df1$value ~ df1$Date, 
     type = "l",lwd=0.75,
     xaxt='n',
     ylim = c(ymin-0.01,ymax),
     ylab="",
     xlab="",
     main="",
     col=4,
     cex.axis=0.75)
mtext(side=3,"Surface to 15cm",padj=2,cex=0.75)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lwd=0.75,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
points(df3$value ~ df3$Date, type = "l",col=2,lwd=0.75)
polygon(c(df3$Date,rev(df3$Date)),c(df3$lower,rev(df3$upper)),col=adjustcolor("red",alpha.f=0.5),border=NA)
points(df4$value ~ df4$Date, type = "l",col=2,lwd=0.75,lty=2)
polygon(c(df4$Date,rev(df4$Date)),c(df4$lower,rev(df4$upper)),col=adjustcolor("red",alpha.f=0.25),density=25)
legend("topright", y = NULL, 
       legend=c("aT-Con","aT-Drt","eT-Con","eT-Drt"), 
       col = c(4,4,2,2),lty=c(1,2,1,2),lwd=1.5,cex=0.75)

#Lower sensors
par(mar = c(1,0,0,3))
plot(df5$value ~ df5$Date, 
     type = "l",lwd=0.75,
     ylim = c(ymin-0.01,ymax),
     ylab="",
     xlab="",
     col=4,
     cex.main=0.75,
     cex.axis=0.75,
     xaxt='n')
axis.Date(side=1,x=df5$Date,cex.axis=0.75)
box(which = "plot", lty = "solid")
mtext(side=3,"15cm to 30cm",padj=2,cex=0.75)
polygon(c(df5$Date,rev(df5$Date)),c(df5$lower,rev(df5$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df6$value ~ df6$Date, type = "l",col=4,lwd=0.75,lty=2)
polygon(c(df6$Date,rev(df6$Date)),c(df6$lower,rev(df6$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
points(df7$value ~ df7$Date, type = "l",col=2,lwd=0.75)
polygon(c(df7$Date,rev(df7$Date)),c(df7$lower,rev(df7$upper)),col=adjustcolor("red",alpha.f=0.5),border=NA)
points(df8$value ~ df8$Date, type = "l",col=2,lwd=0.75,lty=2)
polygon(c(df8$Date,rev(df8$Date)),c(df8$lower,rev(df8$upper)),col=adjustcolor("red",alpha.f=0.25),density=25)
# arrows(x0 =as.Date("2019-06-01"),length=0.05, y0 = 0.025, y1 = -0.015)
# text(x = as.Date("2019-06-01"), y = 0.03,labels=expression(paste("Drought Treatment Initiated")),cex=0.6)

#Irrigation plot
par(new=TRUE)
plot(Irrig1$Irrigation~Irrig1$Date,
     type="h",
     lwd=2,
     axes=FALSE,
     xaxt='n',
     ylab="",
     xlab="",
     ylim = c(0,125))
par(new=TRUE)
with(Irrig2,plot(Irrigation~Date,
                                           type="h",lwd=2,
                                           col=2,
                                           axes=FALSE,
                                           xaxt='n',
                                           ylab="",
                                           xlab="",
                                           ylim = c(0,125),
                                           xlim=c(min(Irrig1$Date),max(Irrig1$Date))))
corners2 = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
par(xpd = TRUE) #Draw outside plot area
text(x = corners2[2]*1.00044, y = mean(corners2[3:4])/6, "Irrigation\n(mm)",srt=270,cex=0.6)
text(x = corners2[2]*1.00019, y = mean(corners2[3:4])/6, "20\n10\n0",las=0,cex=0.65)
axis(side=4,at=c(0,10,20),las=2,labels=c("","",""))

mtext(text="Soil Moisture Content in Lucerne by Treatment",side=3,line=1,outer=TRUE)
mtext(text="Date",side=1,line=2,outer=TRUE,cex=0.75)
mtext(text="Soil Water Content",side=2,line=2,outer=TRUE,cex=0.75)

dev.off()

#FES####
x<-"FES"
#create new dfs based on species
s1plot<-rbind(s1[grep(x, s1$variable),])
s2plot<-rbind(s2[grep(x, s2$variable),])
s3plot<-rbind(s3[grep(x, s3$variable),])
s4plot<-rbind(s4[grep(x, s4$variable),])
s5plot<-rbind(s5[grep(x, s5$variable),])
s6plot<-rbind(s6[grep(x, s6$variable),])

#Separate treatments and other variables into separate columns
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s2plot<-separate(data=s2plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s3plot<-separate(data=s3plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s4plot<-separate(data=s4plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s5plot<-separate(data=s5plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s6plot<-separate(data=s6plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##combine all LUC data
allplot<-rbind(s1plot,s2plot,s3plot,s4plot,s5plot,s6plot)

##recognize variables as factors instead of characters
allplot$Treatment<-as.factor(allplot$Treatment)
allplot$Species<-as.factor(allplot$Species)
allplot$Plot<-as.factor(allplot$Plot)
allplot$Shelter<-as.factor(allplot$Shelter)

##average and standard error by treatment
allsum = data.table(allplot)
allsum<-na.omit(allsum)
allsum$Date<-as.Date(allsum$DateTime)
allsum = allsum[,list(value = mean(value)), 'Plot,Shelter,Treatment,Date']
allsum = allsum[,list(avg_value = mean(value), ste_value = sd(value)/sqrt(length(value))), 'Treatment,Date']
allsum$upper<-allsum$avg_value+allsum$ste_value
allsum$lower<-allsum$avg_value-allsum$ste_value

#rename columns
names(allsum)<-c("Treatment","Date","value","stderror","upper","lower")
allsum$Treatment<-factor(allsum$Treatment,levels=c("UpperAmbCon","UpperAmbDrt","UpperEleCon","UpperEleDrt"))
allsum<-allsum[order(Date,Treatment),] 

ymax<-max(allsum$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(allsum$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
df1<-subset(allsum, Treatment == "UpperAmbCon")
df2<-subset(allsum, Treatment == "UpperAmbDrt")
df3<-subset(allsum, Treatment == "UpperEleCon")
df4<-subset(allsum, Treatment == "UpperEleDrt")

#export graphs to tiff####
tiff(file = paste("FIELD",x,"Daily_Soil_Moisture",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 
#FES plot####
#Soil moisture plot
par(mar=c(5.1,4.1,4.1,3.1))
plot(df1$value ~ df1$Date, 
     type = "l",
     ylim = c(ymin-0.022,ymax+0.032),
     ylab="",
     xlab="",
     main="Soil Water Content in Fescue Plots by Treatment",
     col=4)
mtext(side=2,"Soil Water Content",padj=-3.5)
mtext(side=1,"Date",padj=3.5)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
points(df3$value ~ df3$Date, type = "l",col=2)
polygon(c(df3$Date,rev(df3$Date)),c(df3$lower,rev(df3$upper)),col=adjustcolor("red",alpha.f=0.5),border=NA)
points(df4$value ~ df4$Date, type = "l",col=2,lty=2)
polygon(c(df4$Date,rev(df4$Date)),c(df4$lower,rev(df4$upper)),col=adjustcolor("red",alpha.f=0.25),density=25)
legend("topleft", y = NULL, 
       legend=c("aT-Con","aT-Drt","eT-Con","eT-Drt"), 
       col = c(4,4,2,2),lty=c(1,2,1,2),lwd=1.5,cex=0.75)
# arrows(x0 =as.Date("2018-06-01"),length=0.05, y0 = 0.03, y1 = 0.01)
# text(x = as.Date("2018-06-01"), y = 0.035,labels=expression(paste("Drought Treatment Initiated")),cex=0.6)

#Irrigation plot
par(new=TRUE)
plot(Irrig1$Irrigation~Irrig1$Date,
     type="h",
     lwd=2,
     axes=FALSE,
     xaxt='n',
     ylab="",
     xlab="",
     ylim = c(0,150))
par(new=TRUE)
plot(Irrig2$Irrigation~Irrig2$Date,
     type="h",
     lwd=2,
     col=2,
     axes=FALSE,
     xaxt='n',
     ylab="",
     xlab="",
     ylim = c(0,150),
     xlim=c(min(Irrig1$Date),max(Irrig1$Date)))
corners2 = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
par(xpd = TRUE) #Draw outside plot area
text(x = corners2[2]*1.00044, y = mean(corners2[3:4])/8, "Irrigation\n(mm)",srt=270,cex=0.7)
text(x = corners2[2]*1.00019, y = mean(corners2[3:4])/7, "20\n\n10\n\n0",las=0,cex=0.55)
axis(side=4,at=c(0,10,20),las=2,labels=c("","",""))

dev.off()

#Bis####
x<-"BIS"
#create new dfs based on species
s1plot<-rbind(s1[grep(x, s1$variable),])
s2plot<-rbind(s2[grep(x, s2$variable),])
s3plot<-rbind(s3[grep(x, s3$variable),])
s4plot<-rbind(s4[grep(x, s4$variable),])
s5plot<-rbind(s5[grep(x, s5$variable),])
s6plot<-rbind(s6[grep(x, s6$variable),])

#Separate treatments and other variables into separate columns
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s2plot<-separate(data=s2plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s3plot<-separate(data=s3plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s4plot<-separate(data=s4plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s5plot<-separate(data=s5plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s6plot<-separate(data=s6plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##combine all LUC data
allplot<-rbind(s1plot,s2plot,s3plot,s4plot,s5plot,s6plot)
allplot<-allplot[allplot$DateTime>"2018-05-27 00:00:00",]

##recognize variables as factors instead of characters
allplot$Treatment<-as.factor(allplot$Treatment)
allplot$Species<-as.factor(allplot$Species)
allplot$Plot<-as.factor(allplot$Plot)
allplot$Shelter<-as.factor(allplot$Shelter)

##average and standard error by treatment
allsum = data.table(allplot)
allsum<-na.omit(allsum)
allsum$Date<-as.Date(allsum$DateTime)
allsum = allsum[,list(value = mean(value)), 'Plot,Shelter,Treatment,Date']
allsum = allsum[,list(avg_value = mean(value), ste_value = sd(value)/sqrt(length(value))), 'Treatment,Date']
allsum$upper<-allsum$avg_value+allsum$ste_value
allsum$lower<-allsum$avg_value-allsum$ste_value

#rename columns
names(allsum)<-c("Treatment","Date","value","stderror","upper","lower")
allsum$Treatment<-factor(allsum$Treatment,levels=c("UpperAmbCon","UpperAmbDrt"))
allsum<-allsum[order(Date,Treatment),] 

ymax<-max(allsum$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(allsum$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
df1<-subset(allsum, Treatment == "UpperAmbCon")
df2<-subset(allsum, Treatment == "UpperAmbDrt")

#export graphs to tiff####
tiff(file = paste("FIELD",x,"Daily_Soil_Moisture",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 
#BIS plot####
#Soil moisture plot
par(mar=c(5.1,4.1,4.1,3.1))
plot(df1$value ~ df1$Date, 
     type = "l",
     ylim = c(ymin-0.02,ymax+0.015),
     ylab="",
     xlab="",
     main="Soil Water Content in Biserrula Plots by Treatment",
     col=4)
mtext(side=2,"Soil Water Content",padj=-3.5)
mtext(side=1,"Date",padj=3.5)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
legend("topleft", y = NULL, 
       legend=c("aT-Con","aT-Drt"), 
       col = c(4,4),lty=c(1,2),lwd=1.5,cex=0.75)
# arrows(x0 =as.Date("2018-08-22"),length=0.05, y0 = 0.03, y1 = 0.0)
# text(x = as.Date("2018-08-22"), y = 0.035,labels=expression(paste("Drought Treatment Initiated")),cex=0.6)


#Irrigation plot
par(new=TRUE)
plot(Irrig1$Irrigation~Irrig1$Date,
     type="h",
     lwd=2,
     axes=FALSE,
     xaxt='n',
     ylab="",
     xlab="",
     ylim = c(0,150))
par(new=TRUE)
with(Irrig2,plot(Irrig2$Irrigation~Irrig2$Date,
                                                    type="h",lwd=2,
                                                    col=2,
                                                    axes=FALSE,
                                                    xaxt='n',
                                                    ylab="",
                                                    xlab="",
                                                    ylim = c(0,150),
                                                    xlim=c(min(Irrig1$Date),max(Irrig1$Date))))
corners2 = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
par(xpd = TRUE) #Draw outside plot area
text(x = corners2[2]*1.00044, y = mean(corners2[3:4])/8, "Irrigation\n(mm)",srt=270,cex=0.7)
text(x = corners2[2]*1.00019, y = mean(corners2[3:4])/7, "20\n\n10\n\n0",las=0,cex=0.55)
axis(side=4,at=c(0,10,20),las=2,labels=c("","",""))

dev.off()

#Rye####
x<-"RYE"
#create new dfs based on species
s1plot<-rbind(s1[grep(x, s1$variable),])
s2plot<-rbind(s2[grep(x, s2$variable),])
s3plot<-rbind(s3[grep(x, s3$variable),])
s4plot<-rbind(s4[grep(x, s4$variable),])
s5plot<-rbind(s5[grep(x, s5$variable),])
s6plot<-rbind(s6[grep(x, s6$variable),])

#Separate treatments and other variables into separate columns
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s2plot<-separate(data=s2plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s3plot<-separate(data=s3plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s4plot<-separate(data=s4plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s5plot<-separate(data=s5plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s6plot<-separate(data=s6plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##combine all LUC data
allplot<-rbind(s1plot,s2plot,s3plot,s4plot,s5plot,s6plot)

##recognize variables as factors instead of characters
allplot$Treatment<-as.factor(allplot$Treatment)
allplot$Species<-as.factor(allplot$Species)
allplot$Plot<-as.factor(allplot$Plot)
allplot$Shelter<-as.factor(allplot$Shelter)

##average and standard error by treatment
allsum = data.table(allplot)
allsum<-na.omit(allsum)
allsum$Date<-as.Date(allsum$DateTime)
allsum = allsum[,list(value = mean(value)), 'Plot,Shelter,Treatment,Date']
allsum = allsum[,list(avg_value = mean(value), ste_value = sd(value)/sqrt(length(value))), 'Treatment,Date']
allsum$upper<-allsum$avg_value+allsum$ste_value
allsum$lower<-allsum$avg_value-allsum$ste_value

#rename columns
names(allsum)<-c("Treatment","Date","value","stderror","upper","lower")
allsum$Treatment<-factor(allsum$Treatment,levels=c("UpperAmbCon","UpperAmbDrt"))
allsum<-allsum[order(Date,Treatment),] 

ymax<-max(allsum$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(allsum$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
df1<-subset(allsum, Treatment == "UpperAmbCon")
df2<-subset(allsum, Treatment == "UpperAmbDrt")

#export graphs to tiff####
tiff(file = paste("FIELD",x,"Daily_Soil_Moisture",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 
#RYE plot####
#Soil moisture plot
par(mar=c(5.1,4.1,4.1,3.1))
plot(df1$value ~ df1$Date, 
     type = "l",
     ylim = c(ymin-0.025,ymax+0.02),
     ylab="",
     xlab="",
     main="Soil Water Content in Rye Plots by Treatment",
     col=4)
mtext(side=2,"Soil Water Content",padj=-3.5)
mtext(side=1,"Date",padj=3.5)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
legend("topleft", y = NULL, 
       legend=c("aT-Con","aT-Drt"), 
       col = c(4,4),lty=c(1,2),lwd=1.5,cex=0.75)
# arrows(x0 =as.Date("2018-08-22"),length=0.05, y0 = 0.03, y1 = 0.0)
# text(x = as.Date("2018-08-22"), y = 0.035,labels=expression(paste("Drought Treatment Initiated")),cex=0.6)

#Irrigation plot
par(new=TRUE)
plot(Irrig1$Irrigation~Irrig1$Date,
     type="h",
     lwd=2,
     axes=FALSE,
     xaxt='n',
     ylab="",
     xlab="",
     ylim = c(0,150))
par(new=TRUE)
with(Irrig2,plot(Irrigation~Date,
                                           type="h",lwd=2,
                                           col=2,
                                           axes=FALSE,
                                           xaxt='n',
                                           ylab="",
                                           xlab="",
                                           ylim = c(0,150),
                                           xlim=c(min(Irrig1$Date),max(Irrig1$Date))))
corners2 = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
par(xpd = TRUE) #Draw outside plot area
text(x = corners2[2]*1.00044, y = mean(corners2[3:4])/8, "Irrigation\n(mm)",srt=270,cex=0.7)
text(x = corners2[2]*1.00019, y = mean(corners2[3:4])/7, "20\n\n10\n\n0",las=0,cex=0.55)
axis(side=4,at=c(0,10,20),las=2,labels=c("","",""))

dev.off()

#Soil Temperature####
#only keep variables of interest
s1 <- (downloadTOA5("PACE_AUTO_S1_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)] #only keep variables of interest
s2 <- (downloadTOA5("PACE_AUTO_S2_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)]
s3 <- (downloadTOA5("PACE_AUTO_S3_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)]
s4 <- (downloadTOA5("PACE_AUTO_S4_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)]
s5 <- (downloadTOA5("PACE_AUTO_S5_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)]
s6 <- (downloadTOA5("PACE_AUTO_S6_BLWGRND_R_", startDate=sD, endDate=eD, keepFiles=FALSE))[,c(1,19:26)]

#Rename columns
names(s1)<-c("DateTime","3LUCAmbDrt",
             "3FESAmbDrt",
             "4FESEleCon",
             "4LUCEleCon",
             "5LUCEleDrt",
             "5FESEleDrt",
             "6LUCAmbCon",
             "6FESAmbCon")

names(s2)<-c("DateTime","3LUCEleDrt",
             "3FESEleDrt",
             "4LUCAmbDrt",
             "4FESAmbDrt",
             "5LUCAmbCon",
             "5FESAmbCon",
             "6LUCEleCon",
             "6FESEleCon")

names(s3)<-c("DateTime","3FESAmbCon",
             "3LUCAmbCon",
             "4LUCEleCon",
             "4FESEleCon",
             "5FESEleDrt",
             "5LUCEleDrt",
             "6LUCAmbDrt",
             "6FESAmbDrt")

names(s4)<-c("DateTime","3LUCEleCon",
             "3FESEleCon",
             "4LUCAmbDrt",
             "4FESAmbDrt",
             "5FESAmbCon",
             "5LUCAmbCon",
             "6FESEleDrt",
             "6LUCEleDrt")

names(s5)<-c("DateTime","3FESEleCon",
             "3LUCEleCon",
             "4FESAmbDrt",
             "4LUCAmbDrt",
             "5FESEleDrt",
             "5LUCEleDrt",
             "6LUCAmbCon",
             "6FESAmbCon")

names(s6)<-c("DateTime","3LUCEleDrt",
             "3FESEleDrt",
             "4FESAmbCon",
             "4LUCAmbCon",
             "5LUCEleCon",
             "5FESEleCon",
             "6FESAmbDrt",
             "6LUCAmbDrt")

#convert to long form, add "shelter" variable
s1<-melt(s1,id.vars="DateTime")
s1$Shelter<-1
s2<-melt(s2,id.vars="DateTime")
s2$Shelter<-2
s3<-melt(s3,id.vars="DateTime")
s3$Shelter<-3
s4<-melt(s4,id.vars="DateTime")
s4$Shelter<-4
s5<-melt(s5,id.vars="DateTime")
s5$Shelter<-5
s6<-melt(s6,id.vars="DateTime")
s6$Shelter<-6

#LUC####
x<-"LUC"
#create new dfs based on species
s1plot<-rbind(s1[grep(x, s1$variable),])
s2plot<-rbind(s2[grep(x, s2$variable),])
s3plot<-rbind(s3[grep(x, s3$variable),])
s4plot<-rbind(s4[grep(x, s4$variable),])
s5plot<-rbind(s5[grep(x, s5$variable),])
s6plot<-rbind(s6[grep(x, s6$variable),])

#Separate treatments and other variables into separate columns
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s2plot<-separate(data=s2plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s3plot<-separate(data=s3plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s4plot<-separate(data=s4plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s5plot<-separate(data=s5plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s6plot<-separate(data=s6plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##combine all LUC data
allplot<-rbind(s1plot,s2plot,s3plot,s4plot,s5plot,s6plot)

##recognize variables as factors instead of characters
allplot$Treatment<-as.factor(allplot$Treatment)
allplot$Species<-as.factor(allplot$Species)
allplot$Plot<-as.factor(allplot$Plot)
allplot$Shelter<-as.factor(allplot$Shelter)
allplot$Date<-date(allplot$DateTime)

##average and standard error by treatment
allsum = data.table(allplot)
allsum<-na.omit(allsum)
allsum = allsum[,list(value = mean(value)), 'Plot,Shelter,Treatment,Date']
allsum = allsum[,list(avg_value = mean(value), ste_value = sd(value)/sqrt(length(value))), 'Treatment,Date']
allsum$upper<-allsum$avg_value+allsum$ste_value
allsum$lower<-allsum$avg_value-allsum$ste_value

#rename columns, reorder by date and treatment
names(allsum)<-c("Treatment","Date","value","stderror","upper","lower")
allsum<-allsum[order(Date,Treatment),] 

ymax<-max(allsum$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(allsum$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
df1<-subset(allsum, Treatment == "AmbCon")
df2<-subset(allsum, Treatment == "AmbDrt")
df3<-subset(allsum, Treatment == "EleCon")
df4<-subset(allsum, Treatment == "EleDrt")

##export to tiff file####
tiff(file = paste("FIELD",x,"Daily_Soil_Temperature",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 
#Luc temp plot####
plot(df1$value ~ df1$Date, 
     type = "l",
     ylim = c(ymin,ymax+1),
     ylab=expression(paste("Temperature (",degree~C,")")),
     xlab="Date",
     main="Soil Temperature in Lucerne Plots by Treatment",
     col=4)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
points(df3$value ~ df3$Date, type = "l",col=2)
polygon(c(df3$Date,rev(df3$Date)),c(df3$lower,rev(df3$upper)),col=adjustcolor("red",alpha.f=0.5),border=NA)
points(df4$value ~ df4$Date, type = "l",col=2,lty=2)
polygon(c(df4$Date,rev(df4$Date)),c(df4$lower,rev(df4$upper)),col=adjustcolor("red",alpha.f=0.25),density=25)
legend("topleft", y = NULL, 
       legend=c("aT-Con","aT-Drt","eT-Con","eT-Drt"), 
       col = c(4,4,2,2),lty=c(1,2,1,2),lwd=2,cex=0.8)

dev.off()

#FES####
x<-"FES"
#create new dfs based on species
s1plot<-rbind(s1[grep(x, s1$variable),])
s2plot<-rbind(s2[grep(x, s2$variable),])
s3plot<-rbind(s3[grep(x, s3$variable),])
s4plot<-rbind(s4[grep(x, s4$variable),])
s5plot<-rbind(s5[grep(x, s5$variable),])
s6plot<-rbind(s6[grep(x, s6$variable),])

#Separate treatments and other variables into separate columns
s1plot<-separate(data=s1plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s2plot<-separate(data=s2plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s3plot<-separate(data=s3plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s4plot<-separate(data=s4plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s5plot<-separate(data=s5plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)
s6plot<-separate(data=s6plot, col=variable, c("Plot","Species", "Treatment"), sep = c(1,4), remove = TRUE)

##combine all LUC data
allplot<-rbind(s1plot,s2plot,s3plot,s4plot,s5plot,s6plot)

##recognize variables as factors instead of characters
allplot$Treatment<-as.factor(allplot$Treatment)
allplot$Species<-as.factor(allplot$Species)
allplot$Plot<-as.factor(allplot$Plot)
allplot$Shelter<-as.factor(allplot$Shelter)
allplot$Date<-date(allplot$DateTime)

##average and standard error by treatment
allsum = data.table(allplot)
allsum<-na.omit(allsum)
allsum = allsum[,list(value = mean(value)), 'Plot,Shelter,Treatment,Date']
allsum = allsum[,list(avg_value = mean(value), ste_value = sd(value)/sqrt(length(value))), 'Treatment,Date']
allsum$upper<-allsum$avg_value+allsum$ste_value
allsum$lower<-allsum$avg_value-allsum$ste_value

#rename columns, reorder by date and treatment
names(allsum)<-c("Treatment","Date","value","stderror","upper","lower")
allsum<-allsum[order(Date,Treatment),] 

ymax<-max(allsum$value,na.rm=T) #use same temperature range across temperature charts
ymin<-min(allsum$value,na.rm=T) #there is an NA value in a soil temp sensor data stream that is stopping the script

##subset each treatment to a different data set
df1<-subset(allsum, Treatment == "AmbCon")
df2<-subset(allsum, Treatment == "AmbDrt")
df3<-subset(allsum, Treatment == "EleCon")
df4<-subset(allsum, Treatment == "EleDrt")

##export to tiff file####
tiff(file = paste("FIELD",x,"Daily_Soil_Temperature",sD,"-",eD, ".tiff"), width = 1600, height = 1050, units = "px", res = 200) 
#Fes temp plot####
plot(df1$value ~ df1$Date, 
     type = "l",
     ylim = c(ymin,ymax+1.5),
     ylab=expression(paste("Temperature (",degree~C,")")),
     xlab="Date",
     main="Soil Temperature in Fescue Plots by Treatment",
     col=4)
polygon(c(df1$Date,rev(df1$Date)),c(df1$lower,rev(df1$upper)),col=adjustcolor("blue",alpha.f=0.5),border=NA)
points(df2$value ~ df2$Date, type = "l",col=4,lty=2)
polygon(c(df2$Date,rev(df2$Date)),c(df2$lower,rev(df2$upper)),col=adjustcolor("blue",alpha.f=0.25),density=25)
points(df3$value ~ df3$Date, type = "l",col=2)
polygon(c(df3$Date,rev(df3$Date)),c(df3$lower,rev(df3$upper)),col=adjustcolor("red",alpha.f=0.5),border=NA)
points(df4$value ~ df4$Date, type = "l",col=2,lty=2)
polygon(c(df4$Date,rev(df4$Date)),c(df4$lower,rev(df4$upper)),col=adjustcolor("red",alpha.f=0.25),density=25)
legend("topleft", y = NULL, 
       legend=c("aT-Con","aT-Drt","eT-Con","eT-Drt"), 
       col = c(4,4,2,2),lty=c(1,2,1,2),lwd=2,cex=0.8)

dev.off()