#define working directory - locate data files
working_dir = "D:/VP/Analyse-R/Data"
setwd(working_dir)

#define chemical and concentration (automatic in python)
molecule<-"Cu"
conc<-"100ugL"

#datafiles
datafiles = list.files(working_dir)
datafile = 'test.xls'

#read data - utf16 encoding !
df<-read.csv2(datafile,sep="\t",header=TRUE,dec=".",fileEncoding = "UTF-16LE",encoding="UTF-16")

#concatenate data
###

#ignore quantif data - look at locomotion (distance)
df <- df[df$datatype == "Locomotion",]

# sort first by time, then species, then location in grid
df <- df[with(df, order(sn,pn,location,aname)),]
row.names(df) <- NULL   #reset index

# create date column - also in datetime format
df$time <- c(paste(df$stdate,df$sttime))
df$datetime <- c(as.POSIXct(paste(df$stdate,df$sttime),format = "%d/%m/%Y %H:%M:%S"))
df$specie <- c(substring(df$location,1,1))

#select columns to retain
good_cols <- c(
  "time","datetime","location","stdate",
  "specie","inact","inadur","inadist",
  "smlct","smldur","smldist","larct",
  "lardur","lardist","emptyct","emptydur")

#select desired output columns
df <- subset(df, select = good_cols)

#create column for cage location, time in seconds from unix timestamp, total distance
df$animal <- as.integer(substring(df$location,2,3)) #cage location as integer
df$abtime <- as.numeric(df$datetime) - as.numeric(df$datetime[1])
df$dist <- df$inadist + df$smldist + df$lardist

df_gamm <- df[df$specie == 'G',]
df_erpo <- df[df$specie == 'E',]
df_radix <- df[df$specie == 'R',]

## Continue with distance dataframe

colnames(tx)[2]<-c("date")
colnames(tx)[3]<-c("abtime")
colnames(tx)[4]<-c("rq")
colnames(tx)[5]<-c("specie")
colnames(tx)[6]<-c("condition")


head(tx)



##############conditions:
                                                             #####  créer tablea par bestiole et concentration

erp_c1<-tx[tx$channel==Tx4erpobdella,]                                                  #####  créer tablea par bestiole et concentration
erp_c1$animal<-"Erpobdella"                                                             #####  créer tablea par bestiole et concentration
erp_c2<-tx[tx$channel==Tx2erpobdella,]                                                  #####  créer tablea par bestiole et concentration
erp_c2$animal<-"Erpobdella"                                                             #####  créer tablea par bestiole et concentration
erp_tem<-tx[tx$channel==Tx3erpobdella,]                                                 #####  créer tablea par bestiole et concentration
erp_tem$animal<-"Erpobdella"    
erp_tem<-tx[tx$channel==TxTerpobdella,]                                                   #####  créer tablea par bestiole et concentration
erp_tem$specie<-"Erpobdella"                                                         #####  créer tablea par bestiole et concentration

rad_c1<-tx[tx$channel==Tx4radix,]                                                      #####  créer tablea par bestiole et concentration
rad_c1$animal<-"radix"                                                                 #####  créer tablea par bestiole et concentration
rad_c2<-tx[tx$channel==Tx2radix,]                                                      #####  créer tablea par bestiole et concentration
rad_c2$animal<-"Radix"                                                                  #####  créer tablea par bestiole et concentration
rad_tem<-tx[tx$channel==Tx3radix,]                                                      #####  créer tablea par bestiole et concentration
rad_tem$animal<-"Radix"  
rad_tem<-tx[tx$channel==TxTradix,]                                                   #####  créer tablea par bestiole et concentration
rad_tem$specie<-"Radix"                                                                  #####  créer tablea par bestiole et concentration



### Tox 5,7,8 et 6

#gam_c1<-tx[tx$channel==Tx5gammare,]                                                   #####  créer tablea par bestiole et concentration
#gam_c1$specie<-"Gammarus"                                                              #####  créer tablea par bestiole et concentration
#gam_c2<-tx[tx$channel==Tx7gammare,]                                                    #####  créer tablea par bestiole et concentration
#gam_c2$specie<-"Gammarus" 
#gam_c3<-tx[tx$channel==Tx8gammare,]                                                    #####  créer tablea par bestiole et concentration
#gam_c3$specie<-"Gammarus"                                                              #####  créer tablea par bestiole et concentration
#gam_tem<-tx[tx$channel==TxTgammare,]                                                   #####  créer tablea par bestiole et concentration
#gam_tem$specie<-"Gammarus"  
                                                             #####  créer tablea par bestiole et concentration

#erp_c1<-tx[tx$channel==Tx5erpobdella,]                                                  #####  créer tablea par bestiole et concentration
#erp_c1$animal<-"Erpobdella"                                                             #####  créer tablea par bestiole et concentration
#erp_c2<-tx[tx$channel==Tx7erpobdella,]                                                  #####  créer tablea par bestiole et concentration
#erp_c2$animal<-"Erpobdella"                                                             #####  créer tablea par bestiole et concentration
#erp_tem<-tx[tx$channel==Tx8erpobdella,]                                                 #####  créer tablea par bestiole et concentration
#erp_tem$animal<-"Erpobdella"    
#erp_tem<-tx[tx$channel==TxTerpobdella,]                                                   #####  créer tablea par bestiole et concentration
#erp_tem$specie<-"Erpobdella"                                                         #####  créer tablea par bestiole et concentration

#rad_c1<-tx[tx$channel==Tx5radix,]                                                      #####  créer tablea par bestiole et concentration
#rad_c1$animal<-"radix"                                                                 #####  créer tablea par bestiole et concentration
#rad_c2<-tx[tx$channel==Tx7radix,]                                                      #####  créer tablea par bestiole et concentration
#rad_c2$animal<-"Radix"                                                                  #####  créer tablea par bestiole et concentration
#rad_tem<-tx[tx$channel==Tx8radix,]                                                      #####  créer tablea par bestiole et concentration
#rad_tem$animal<-"Radix"  
#rad_tem<-tx[tx$channel==TxTradix,]                                                   #####  créer tablea par bestiole et concentration
#rad_tem$specie<-"Radix"                                                                  #####  créer tablea par bestiole et concentration









#################### Debut script
rm(tx)
setwd("C:/Users/decamps/Documents/ToxMate/Developpement-Outil/Ecotox/Traitement données/ToxMate/calibration_2018/3-Resultats/cu1")


print(gam_c1$date[1])                                                                                                       #### debut mesure
print(gam_c1$date[length(gam_c1$date)])

start<-"18/03/14 20:00:00"		##fenêtre d'observation pour le graphe:
stop<-"18/03/18 20:00:00"
pas<-60  	########pas d'intégration en minutes:
q=0.05	#####Choix du quantile pour calcul IGT:
by=4   #### pas échelle



bilan<-c()			##tableau de synthèse sur les différentes conditions:

##############condition témoin:####################################################################################################

to<-rad_c1
dist<-to$inadist+to$smldist+to$lardist                                                         #### Calcul et ajout distance
to<-cbind(to,dist)                                                                             #### Calcul et ajout distance
head(to,50)

to$date<-paste(substring(to$date,3,4),substring(to$date,6,7),substring(to$date,9,19),sep="/")   #### date format aa/mm/jr hh:mm:sd
tab<-to[min((1:length(to$date))[(substr(to$date,1,14)==substr(start,1,14))]):max((1:length(to$date))[(substr(to$date,1,14)==substr(stop,1,14))]),] #### tableau commence par start et finit par stop

time<-as.numeric(difftime(as.POSIXct(tab$date),as.POSIXct(start),units="secs")) 				##temps depuis le début de l'expérience en secondes:
tab<-cbind(tab,time)                                                                             
tab<-tab[time<as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),]

brea<-seq(0,as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),60*pas)
time_cat<-cut(x=tab$time,breaks=brea,right=F,labels=as.character(brea[-length(brea)]))
time_cat<-as.numeric(as.character(time_cat))
tab<-cbind(tab,time_cat)                                                                             
summary(as.factor(tab$time_cat),maxsum=1000)

dist_moy<-tapply(tab$dist,as.factor(paste(tab$time_cat,tab$rq)),"mean",na.rm=T)					##moyenne par individu des mesures poolées pour chaque pas de temps;
date<-unlist(strsplit(names(dist_moy)," "))[seq(1,length(unlist(strsplit(names(dist_moy)," "))),2)]
ind<-unlist(strsplit(names(dist_moy)," "))[seq(2,length(unlist(strsplit(names(dist_moy)," "))),2)]
tob<-as.data.frame(t(rbind(date,ind,dist_moy)))
tob$dist_moy<-as.numeric(as.character(tob$dist_moy))
tob$date<-as.numeric(as.character(tob$date))
good<-tob[order(tob$date),]


######## Graphique individuel
x11()
par(mar=c(10,5,5,1))

coul<-c("darkred","red","azure2","brown","brown3","darkslateblue","darkblue","blue","magenta","darkgreen","darkslategrey","darkorchid4","green","black","orange","orange4")
coul<-coul[1:length(unique(good$ind))]

tib<-good[good$ind==unique(good$ind)[1],]
plot(tib$date,tib$dist_moy,xlab="",type="n",ylab="Gammare Traveled Distance (mm)",axes=F,main="Individual Distance (mm)",las=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tib$date)[seq(1,length(tib$date),by=by)],3,16),at=tib$date[seq(1,length(tib$date),by=by)],las=2)
for (i in 1:length(unique(good$ind))){
	tib<-good[good$ind==unique(good$ind)[i],]
	lines(tib$date,tib$dist_moy,xlab="",ylab="",las=3,col=coul[i])
}
abline(v=tib$date[sum(as.numeric(difftime(as.POSIXct(date_conta),as.POSIXct(start),units="secs"))>tib$date)],col="red",lwd=2)

####

################# ENLEVER MORTS TEMOIN ##############################################################
goodc1<-good[good$ind=="1"|good$ind=="2"|good$ind=="3"|good$ind=="4"|good$ind=="6"|good$ind=="7"|good$ind=="9"|good$ind=="10"|good$ind=="11"|good$ind=="12"|good$ind=="13"|good$ind=="14"|good$ind=="15"|good$ind=="16",]

tibt<-goodc1[goodtem$ind==unique(goodtem$ind)[1],]


survie_gam_tem<-"14/16"               ############ Mettre les survivants
x11()
par(mar=c(10,5,5,1))
plot(tibt$date,tibt$dist_moy,xlab="",type="n",ylab="Gammare Traveled Distance (mm)",axes=F,main=paste("Gammare-Temoin (survival =",survie_gam_tem,")"),las=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tibt$date)[seq(1,length(tibt$date),by=by)],3,16),at=tibt$date[seq(1,length(tibt$date),by=by)],las=2)
for (i in 1:length(unique(goodtem$ind))){
tibt<-goodtem[goodtem$ind==unique(goodtem$ind)[i],]
lines(tibt$date,tibt$dist_moy,xlab="",ylab="",las=3,lwd=2,col=coul[i])
}





######## Graphique MOY IGT:
dist_moyenne<-tapply(goodtem$dist_moy,as.factor(goodtem$date),"mean",na.rm=T)
qq<-function(x)quantile(x,q,na.rm=T)
dist_quant_moy<-tapply(goodtem$dist_moy,as.factor(goodtem$date),qq)
IGT<-(dist_quant_moy)^2  
dd<-unique(goodtem$date)

x11()
par(mar=c(10,5,5,1))
plot(dd,dist_moyenne,xlab="",ylab="Distance (mm)",axes=F,ylim=c(0,300),col="black",main=paste("Gammarus Distance_ Temoin (survival =",survie_gam_tem,")"),las=3,cex.main=1.8,cex.lab=1.9,cex=1)
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+dd)[seq(1,length(dd),by=by)],3,16),at=dd[seq(1,length(dd),by=by)],las=2)
lines(dd,dist_moyenne,col="black",lwd=3)
abline(v=dd[sum(as.numeric(difftime(as.POSIXct(date_conta),as.POSIXct(start),units="secs"))>dd)],col="red",lwd=2)

x11()
par(mar=c(10,5,5,1))
plot(dd,IGT,xlab="",ylab="Toxic Signal",axes=F,col="black",main=paste("Gammarus IGT_ Temoin (survival =",survie_gam_tem,")"),cex.main=1.8,cex.lab=1.9,cex=1,las=3,ylim=c(0,10000))
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+dd)[seq(1,length(dd),by=by)],3,16),at=dd[seq(1,length(dd),by=by)],las=2)
lines(dd,IGT,col="black",lwd=3)
abline(v=dd[sum(as.numeric(difftime(as.POSIXct(date_conta),as.POSIXct(start),units="secs"))>dd)],col="red",lwd=2)

### archive données:
bilan<-as.data.frame(cbind(dd,IGT))
names(bilan)<-c("date","IGT_tem")





##############c1####################################################################################################

to<-gam_c1
dist<-to$inadist+to$smldist+to$lardist                                                         #### Calcul et ajout distance
to<-cbind(to,dist)                                                                             #### Calcul et ajout distance

to$date<-paste(substring(to$date,3,4),substring(to$date,6,7),substring(to$date,9,19),sep="/")   #### date format aa/mm/jr hh:mm:sd
tab<-to[min((1:length(to$date))[(substr(to$date,1,14)==substr(start,1,14))]):max((1:length(to$date))[(substr(to$date,1,14)==substr(stop,1,14))]),] #### tableau commence par start et finit par stop

time<-as.numeric(difftime(as.POSIXct(tab$date),as.POSIXct(start),units="secs")) 				##temps depuis le début de l'expérience en secondes:
tab<-cbind(tab,time)                                                                             
tab<-tab[time<as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),]

brea<-seq(0,as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),60*pas)
time_cat<-cut(x=tab$time,breaks=brea,right=F,labels=as.character(brea[-length(brea)]))
time_cat<-as.numeric(as.character(time_cat))
tab<-cbind(tab,time_cat)                                                                             
summary(as.factor(tab$time_cat),maxsum=1000)

dist_moy<-tapply(tab$dist,as.factor(paste(tab$time_cat,tab$rq)),"mean",na.rm=T)					##moyenne par individu des mesures poolées pour chaque pas de temps;
date<-unlist(strsplit(names(dist_moy)," "))[seq(1,length(unlist(strsplit(names(dist_moy)," "))),2)]
ind<-unlist(strsplit(names(dist_moy)," "))[seq(2,length(unlist(strsplit(names(dist_moy)," "))),2)]
tob<-as.data.frame(t(rbind(date,ind,dist_moy)))
tob$dist_moy<-as.numeric(as.character(tob$dist_moy))
tob$date<-as.numeric(as.character(tob$date))
good<-tob[order(tob$date),]


######## Graphique individuel
x11()
par(mar=c(10,5,5,1))

coul<-c("darkred","red","azure2","brown","brown3","darkslateblue","darkblue","blue","magenta","darkgreen","darkslategrey","darkorchid4","green","black","orange","orange4")
coul<-coul[1:length(unique(good$ind))]

tib<-good[good$ind==unique(good$ind)[1],]
plot(tib$date,tib$dist_moy,xlab="",type="n",ylab="Gammare Traveled Distance (mm)",axes=F,main="Individual Distance (mm)",las=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tib$date)[seq(1,length(tib$date),by=by)],3,16),at=tib$date[seq(1,length(tib$date),by=by)],las=2)
for (i in 1:length(unique(good$ind))){
	tib<-good[good$ind==unique(good$ind)[i],]
	lines(tib$date,tib$dist_moy,xlab="",ylab="",las=3,col=coul[i])
}
abline(v=tib$date[sum(as.numeric(difftime(as.POSIXct(date_contac1),as.POSIXct(start),units="secs"))>tib$date)],col="red",lwd=2)

####

################# ENLEVER MORTS TEMOIN ##############################################################
goodc1<-good[good$ind=="1"|good$ind=="2"|good$ind=="3"|good$ind=="4"|good$ind=="5"|good$ind=="6"|good$ind=="8"|good$ind=="9"|good$ind=="10"|good$ind=="11"|good$ind=="12"|good$ind=="13"|good$ind=="15"|good$ind=="16",]
tibc1<-goodc1[goodc1$ind==unique(goodc1$ind)[1],]


survie_gam_c1<-"14/16"               ############ Mettre les survivants
x11()
par(mar=c(10,5,5,1))
plot(tibc1$date,tibc1$dist_moy,xlab="",type="n",ylab="Traveled Distance (mm)",axes=F,main=paste("Gammarus- ",molecule," (EC50,  survival =",survie_gam_c1,")"),las=3,lwd=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tibc1$date)[seq(1,length(tibc1$date),by=by)],3,16),at=tibc1$date[seq(1,length(tibc1$date),by=by)],las=2)
for (i in 1:length(unique(goodc1$ind))){
tibc1<-goodc1[goodc1$ind==unique(goodc1$ind)[i],]
lines(tibc1$date,tibc1$dist_moy,xlab="",ylab="",las=3,lwd=2,col=coul[i])
}





######## Graphique MOY IGT:
dist_moyennec1<-tapply(goodc1$dist_moy,as.factor(goodc1$date),"mean",na.rm=T)
qq<-function(x)quantile(x,q,na.rm=T)
dist_quant_moyc1<-tapply(goodc1$dist_moy,as.factor(goodc1$date),qq)
IGTc1<-(dist_quant_moyc1)^2  
ddc1<-unique(goodc1$date)

x11()
par(mar=c(10,5,5,1))
plot(ddc1,dist_moyennec1,xlab="",ylab="Distance (mm)",axes=F,ylim=c(0,300),col="black",main=paste("Gammarus Distance_ ",molecule," (EC50,  survival =",survie_gam_c1,")"),las=3,cex.main=1.8,cex.lab=1.9,cex=1)
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc1)[seq(1,length(ddc1),by=by)],3,16),at=ddc1[seq(1,length(ddc1),by=by)],las=2)
lines(ddc1,dist_moyennec1,col="black",lwd=3)
abline(v=ddc1[sum(as.numeric(difftime(as.POSIXct(date_contac1),as.POSIXct(start),units="secs"))>ddc1)],col="red",lwd=2)

x11()
par(mar=c(10,5,5,1))
plot(ddc1,IGTc1,xlab="",ylab="Toxic Signal",axes=F,col="black",main=paste("Gammarus IGT_ ",molecule," (EC50,  survival =",survie_gam_c1,")"),cex.main=1.8,cex.lab=1.9,cex=1,las=3,ylim=c(0,10000))
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc1)[seq(1,length(ddc1),by=by)],3,16),at=ddc1[seq(1,length(ddc1),by=by)],las=2)
lines(ddc1,IGTc1,col="black",lwd=3)
abline(v=ddc1[sum(as.numeric(difftime(as.POSIXct(date_contac1),as.POSIXct(start),units="secs"))>ddc1)],col="red",lwd=2)

### archive données:
bilan<-as.data.frame(cbind(dd,IGT))
names(bilan)<-c("date","IGT_tem,"IGT_c1")





##############c2####################################################################################################

to<-gam_c2
dist<-to$inadist+to$smldist+to$lardist                                                         #### Calcul et ajout distance
to<-cbind(to,dist)                                                                             #### Calcul et ajout distance

to$date<-paste(substring(to$date,3,4),substring(to$date,6,7),substring(to$date,9,19),sep="/")   #### date format aa/mm/jr hh:mm:sd
tab<-to[min((1:length(to$date))[(substr(to$date,1,14)==substr(start,1,14))]):max((1:length(to$date))[(substr(to$date,1,14)==substr(stop,1,14))]),] #### tableau commence par start et finit par stop

time<-as.numeric(difftime(as.POSIXct(tab$date),as.POSIXct(start),units="secs")) 				##temps depuis le début de l'expérience en secondes:
tab<-cbind(tab,time)                                                                             
tab<-tab[time<as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),]

brea<-seq(0,as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),60*pas)
time_cat<-cut(x=tab$time,breaks=brea,right=F,labels=as.character(brea[-length(brea)]))
time_cat<-as.numeric(as.character(time_cat))
tab<-cbind(tab,time_cat)                                                                             
summary(as.factor(tab$time_cat),maxsum=1000)

dist_moy<-tapply(tab$dist,as.factor(paste(tab$time_cat,tab$rq)),"mean",na.rm=T)					##moyenne par individu des mesures poolées pour chaque pas de temps;
date<-unlist(strsplit(names(dist_moy)," "))[seq(1,length(unlist(strsplit(names(dist_moy)," "))),2)]
ind<-unlist(strsplit(names(dist_moy)," "))[seq(2,length(unlist(strsplit(names(dist_moy)," "))),2)]
tob<-as.data.frame(t(rbind(date,ind,dist_moy)))
tob$dist_moy<-as.numeric(as.character(tob$dist_moy))
tob$date<-as.numeric(as.character(tob$date))
good<-tob[order(tob$date),]


######## Graphique individuel
x11()
par(mar=c(10,5,5,1))

coul<-c("darkred","red","azure2","brown","brown3","darkslateblue","darkblue","blue","magenta","darkgreen","darkslategrey","darkorchid4","green","black","orange","orange4")
coul<-coul[1:length(unique(good$ind))]

tib<-good[good$ind==unique(good$ind)[1],]
plot(tib$date,tib$dist_moy,xlab="",type="n",ylab="Gammare Traveled Distance (mm)",axes=F,,main="Individual Distance (mm)",las=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tib$date)[seq(1,length(tib$date),by=by)],3,16),at=tib$date[seq(1,length(tib$date),by=by)],las=2)
for (i in 1:length(unique(good$ind))){
	tib<-good[good$ind==unique(good$ind)[i],]
	lines(tib$date,tib$dist_moy,xlab="",ylab="",las=3,col=coul[i])
}
abline(v=tib$date[sum(as.numeric(difftime(as.POSIXct(date_contac2),as.POSIXct(start),units="secs"))>tib$date)],col="red",lwd=2)

####

################# ENLEVER MORTS TEMOIN ##############################################################
goodc2<-good[good$ind=="1"|good$ind=="2"|good$ind=="3"|good$ind=="4"|good$ind=="5"|good$ind=="6"|good$ind=="8"|good$ind=="9"|good$ind=="10"|good$ind=="11"|good$ind=="12"|good$ind=="13"|good$ind=="15"|good$ind=="16",]
tibc2<-goodc2[goodc2$ind==unique(goodc2$ind)[1],]


survie_gam_c2<-"14/16"               ############ Mettre les survivants
x11()
par(mar=c(10,5,5,1))
plot(tibc2$date,tibc2$dist_moy,xlab="",type="n",ylab="Traveled Distance (mm)",axes=F,main=paste("Gammarus- ",molecule," (EC50/5,  survival =",survie_gam_c2,")"),las=3,lwd=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tibc2$date)[seq(1,length(tibc2$date),by=by)],3,16),at=tibc2$date[seq(1,length(tibc2$date),by=by)],las=2)
for (i in 1:length(unique(goodc2$ind))){
tibc2<-goodc2[goodc2$ind==unique(goodc2$ind)[i],]
lines(tibc2$date,tibc2$dist_moy,xlab="",ylab="",las=3,lwd=2,col=coul[i])
}





######## Graphique MOY IGT:
dist_moyennec2<-tapply(goodc2$dist_moy,as.factor(goodc2$date),"mean",na.rm=T)
qq<-function(x)quantile(x,q,na.rm=T)
dist_quant_moyc2<-tapply(goodc2$dist_moy,as.factor(goodc2$date),qq)
IGTc2<-(dist_quant_moyc2)^2  
ddc2<-unique(goodc2$date)

x11()
par(mar=c(10,5,5,1))
plot(ddc2,dist_moyennec2,xlab="",ylab="Distance (mm)",axes=F,ylim=c(0,300),col="black",main=paste("Gammarus Distance_ ",molecule," (EC50/5,  survival =",survie_gam_c2,")"),las=3,cex.main=1.8,cex.lab=1.9,cex=1)
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc2)[seq(1,length(ddc2),by=by)],3,16),at=ddc2[seq(1,length(ddc2),by=by)],las=2)
lines(ddc2,dist_moyennec2,col="black",lwd=3)
abline(v=ddc2[sum(as.numeric(difftime(as.POSIXct(date_contac2),as.POSIXct(start),units="secs"))>ddc2)],col="red",lwd=2)

x11()
par(mar=c(10,5,5,1))
plot(ddc2,IGTc2,xlab="",ylab="Toxic Signal",axes=F,col="black",main=paste("Gammarus IGT_ ",molecule," (EC50,  survival =",survie_gam_c2,")"),cex.main=1.8,cex.lab=1.9,cex=1,las=3,ylim=c(0,10000))
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc2)[seq(1,length(ddc2),by=by)],3,16),at=ddc1[seq(1,length(ddc2),by=by)],las=2)
lines(ddc2,IGTc2,col="black",lwd=3)
abline(v=ddc2[sum(as.numeric(difftime(as.POSIXct(date_contac2),as.POSIXct(start),units="secs"))>ddc2)],col="red",lwd=2)

### archive données:
bilan<-as.data.frame(cbind(dd,IGT))
names(bilan)<-c("date","IGT_tem,"IGT_c1","IGT_c2")



##############c3####################################################################################################

to<-gam_c3
dist<-to$inadist+to$smldist+to$lardist                                                         #### Calcul et ajout distance
to<-cbind(to,dist)                                                                             #### Calcul et ajout distance

to$date<-paste(substring(to$date,3,4),substring(to$date,6,7),substring(to$date,9,19),sep="/")   #### date format aa/mm/jr hh:mm:sd
tab<-to[min((1:length(to$date))[(substr(to$date,1,14)==substr(start,1,14))]):max((1:length(to$date))[(substr(to$date,1,14)==substr(stop,1,14))]),] #### tableau commence par start et finit par stop

time<-as.numeric(difftime(as.POSIXct(tab$date),as.POSIXct(start),units="secs")) 				##temps depuis le début de l'expérience en secondes:
tab<-cbind(tab,time)                                                                             
tab<-tab[time<as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),]

brea<-seq(0,as.numeric(difftime(as.POSIXct(stop),as.POSIXct(start),units="secs")),60*pas)
time_cat<-cut(x=tab$time,breaks=brea,right=F,labels=as.character(brea[-length(brea)]))
time_cat<-as.numeric(as.character(time_cat))
tab<-cbind(tab,time_cat)                                                                             
summary(as.factor(tab$time_cat),maxsum=1000)

dist_moy<-tapply(tab$dist,as.factor(paste(tab$time_cat,tab$rq)),"mean",na.rm=T)					##moyenne par individu des mesures poolées pour chaque pas de temps;
date<-unlist(strsplit(names(dist_moy)," "))[seq(1,length(unlist(strsplit(names(dist_moy)," "))),2)]
ind<-unlist(strsplit(names(dist_moy)," "))[seq(2,length(unlist(strsplit(names(dist_moy)," "))),2)]
tob<-as.data.frame(t(rbind(date,ind,dist_moy)))
tob$dist_moy<-as.numeric(as.character(tob$dist_moy))
tob$date<-as.numeric(as.character(tob$date))
good<-tob[order(tob$date),]


######## Graphique individuel
x11()
par(mar=c(10,5,5,1))

coul<-c("darkred","red","azure2","brown","brown3","darkslateblue","darkblue","blue","magenta","darkgreen","darkslategrey","darkorchid4","green","black","orange","orange4")
coul<-coul[1:length(unique(good$ind))]

tib<-good[good$ind==unique(good$ind)[1],]
plot(tib$date,tib$dist_moy,xlab="",type="n",ylab="Gammare Traveled Distance (mm)",axes=F,,main="Individual Distance (mm)",las=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tib$date)[seq(1,length(tib$date),by=by)],3,16),at=tib$date[seq(1,length(tib$date),by=by)],las=2)
for (i in 1:length(unique(good$ind))){
	tib<-good[good$ind==unique(good$ind)[i],]
	lines(tib$date,tib$dist_moy,xlab="",ylab="",las=3,col=coul[i])
}
abline(v=tib$date[sum(as.numeric(difftime(as.POSIXct(date_contac3),as.POSIXct(start),units="secs"))>tib$date)],col="red",lwd=2)

####

################# ENLEVER MORTS TEMOIN ##############################################################
goodc3<-good[good$ind=="2"|good$ind=="3"|good$ind=="4"|good$ind=="5"|good$ind=="6"|good$ind=="7"|good$ind=="8"|good$ind=="9"|good$ind=="10"|good$ind=="11"|good$ind=="13"|good$ind=="14"|good$ind=="16",]
tibc3<-goodc3[goodc3$ind==unique(goodc3$ind)[1],]


survie_gam_c3<-"14/16"               ############ Mettre les survivants
x11()
par(mar=c(10,5,5,1))
plot(tibc3$date,tibc3$dist_moy,xlab="",type="n",ylab="Traveled Distance (mm)",axes=F,main=paste("Gammarus- ",molecule," (EC50/25,  survival =",survie_gam_c3,")"),las=3,lwd=3,ylim=c(0,300))
axis(2)
axis(1,labels=substring((as.POSIXct(start)+tibc3$date)[seq(1,length(tibc3$date),by=by)],3,16),at=tibc3$date[seq(1,length(tibc3$date),by=by)],las=2)
for (i in 1:length(unique(goodc3$ind))){
tibc3<-goodc3[goodc3$ind==unique(goodc3$ind)[i],]
lines(tibc3$date,tibc3$dist_moy,xlab="",ylab="",las=3,lwd=2,col=coul[i])
}





######## Graphique MOY IGT:
dist_moyennec3<-tapply(goodc3$dist_moy,as.factor(goodc3$date),"mean",na.rm=T)
qq<-function(x)quantile(x,q,na.rm=T)
dist_quant_moyc3<-tapply(goodc3$dist_moy,as.factor(goodc3$date),qq)
IGTc3<-(dist_quant_moyc3)^2  
ddc3<-unique(goodc3$date)

x11()
par(mar=c(10,5,5,1))
plot(ddc3,dist_moyennec3,xlab="",ylab="Distance (mm)",axes=F,ylim=c(0,300),col="black",main=paste("Gammarus Distance_ ",molecule," (EC50/25,  survival =",survie_gam_c3,")"),las=3,cex.main=1.8,cex.lab=1.9,cex=1)
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc3)[seq(1,length(ddc3),by=by)],3,16),at=ddc3[seq(1,length(ddc3),by=by)],las=2)
lines(ddc3,dist_moyennec3,col="black",lwd=3)
abline(v=ddc3[sum(as.numeric(difftime(as.POSIXct(date_contac3),as.POSIXct(start),units="secs"))>ddc3)],col="red",lwd=2)


x11()
par(mar=c(10,5,5,1))
plot(ddc3,IGTc3,xlab="",ylab="Toxic Signal",axes=F,col="black",main=paste("Gammarus IGT_ ",molecule," (EC50/25,  survival =",survie_gam_c3,")"),cex.main=1.8,cex.lab=1.9,cex=1,las=3,ylim=c(0,10000))
axis(2,lwd=2.5,cex.axis=1.6)
axis(1,labels=substring((as.POSIXct(start)+ddc3)[seq(1,length(ddc3),by=by)],3,16),at=ddc3[seq(1,length(ddc3),by=by)],las=2)
lines(ddc3,IGTc3,col="black",lwd=3)
abline(v=ddc3[sum(as.numeric(difftime(as.POSIXct(date_contac3),as.POSIXct(start),units="secs"))>ddc3)],col="red",lwd=2)

### archive données:
bilan<-as.data.frame(cbind(dd,IGT))
names(bilan)<-c("date","IGT_tem,"IGT_c1")


