#define working directory - locate data files
working_dir = "D:/VP/Analyse-R/Data"
setwd(working_dir)

#define chemical and concentration (automatic in python)
TxM <- 761

#datafiles
datafiles = list.files(working_dir,pattern = "\\.xls$")
datafile = '20220304-082359.xls'

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

#create column for cage location, time in seconds from unix timestamp, total distance
df$animal <- as.integer(substring(df$location,2,3)) #cage location as integer
df$abtime <- as.numeric(df$datetime)                #unix timestamp in seconds
df$dist <- df$inadist + df$smldist + df$lardist

#select columns to retain
good_cols <- c(
  "time","datetime","abtime",
  "specie","animal","dist")

#select desired output columns
df <- subset(df, select = good_cols)

df_gamm <- df[df$specie == 'G',]
df_erpo <- df[df$specie == 'E',]
df_radix <- df[df$specie == 'R',]

## Continue with distance dataframe for gammarus
timestamps <- unique(df_gamm$abtime)
animals <- unique(df_gamm$animal)

#create column 1
animal1values <- df_gamm[df_gamm$animal == 1,]['dist']$dist
#create distance dataframes
df_dist <- data.frame(matrix(nrow = length(timestamps),ncol = length(animals)))
rownames(df_dist) <- timestamps
colnames(df_dist) <- animals

#add distances to df
for(i in 1:length(animals)){
  df_dist[i] <- df_gamm[df_gamm$animal == i,]['dist']$dist
}

#add timestep mean option
timestep <- 2 #2 minutes
timebreaks <- seq(as.integer(rownames(df_dist)[1]),as.integer(rownames(df_dist)[nrow(df_dist)]),60*timestep)
timegroup <- cut(x = as.numeric(rownames(df_dist)), breaks = timebreaks, labels = timebreaks[-length(timebreaks)],right = F)
df_timed <- na.omit(cbind(df_dist,timegroup))
df_distmean <- aggregate(df_timed[,1:length(animals)],list(df_timed$timegroup),mean)

#mean and quantile distance
mean_dist <- rowMeans(df_dist)
quant_dist <- apply(df_dist, 1, quantile, probs = c(0.05),  na.rm = TRUE)

#graph parameters
ind_colors <-c("darkred","red","azure2","brown",
               "brown3","darkslateblue","darkblue","blue",
               "magenta","darkgreen","darkslategrey","darkorchid4",
               "green","black","orange","orange4")

#read in doping register
dope_reg <- read.csv('dope_reg_TOXAMONT.csv',header = F)
colnames(dope_reg) <- c("TxM","Substance","Formula","Concentration","Start","End")
dope_reg$Start <- as.numeric(c(as.POSIXct(dope_reg$Start,format = "%d/%m/%Y %H:%M:%S")))
dope_reg$End <- as.numeric(c(as.POSIXct(dope_reg$End,format = "%d/%m/%Y %H:%M:%S")))

#set dopage as entry in reg that corresponds to dataframe (put in function)
dope <- dope_reg[dope_reg$TxM == TxM,]
dope <- dope[(dope$End > as.numeric(rownames(df_dist)[1])) & (dope$End < as.numeric(rownames(df_dist)[nrow(df_dist)])),]
dopage <- as.numeric(dope$End[1])
molecule<- dope$Substance[1]
conc<- dope$Concentration[1]