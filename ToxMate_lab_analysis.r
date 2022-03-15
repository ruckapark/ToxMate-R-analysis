#define working directory - locate data files
working_dir = "D:/VP/Analyse-R/Data"
setwd(working_dir)

#define chemical and concentration (automatic in python)
TxM <- 761

#datafiles
datafiles = list.files(working_dir,pattern = "\\.xls$")
datas <- vector(mode = "list", length = length(datafiles))
for(i in 1:length(datas)){
  #read in seperate datafiles and selection locomotion data
  data <- read.csv2(datafiles[i],sep="\t",header=TRUE,dec=".",fileEncoding = "UTF-16LE",encoding="UTF-16")
  data <- data[data$datatype == "Locomotion",]
  data <- data[with(data, order(sn,pn,location,aname)),]
  row.names(data) <- NULL   #reset index for bind non-inteference
  datas[[i]] <- data
}

#concatenate data
df <- do.call("rbind", datas)
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

#add distances to df with check for dead
for(i in 1:length(animals)){
  #num of continuous zeros
  dist <- df_gamm[df_gamm$animal == i,]['dist']$dist
  inactive_time <- max(rle(dist)$length)
  print(inactive_time)
  if(inactive_time < 1000){
    df_dist[i] <- df_gamm[df_gamm$animal == i,]['dist']$dist
  }
}

#remove columns with NA values (dead organims)
empty_columns <- sapply(df_dist, function(x) all(is.na(x) | x == ""))
df_dist[, !empty_columns]

#add timestep mean option
agg_mean = TRUE
timestep <- 5 #groupmean in minutes
if(agg_mean){
  timebreaks <- seq(as.integer(rownames(df_dist)[1]),as.integer(rownames(df_dist)[nrow(df_dist)]),60*timestep)
  timegroup <- cut(x = as.numeric(rownames(df_dist)), breaks = timebreaks, labels = timebreaks[-length(timebreaks)],right = F)
  df_dist <- na.omit(cbind(df_dist,timegroup))
  df_dist <- aggregate(df_dist[,1:length(animals)],list(df_dist$timegroup),mean)
  rownames(df_dist) <- df_dist[,1]
  df_dist <- df_dist[-c(1)]
}

#mean and quantile distance
mean_dist <- rowMeans(df_dist)
quant_dist <- apply(df_dist, 1, quantile, probs = c(0.05),  na.rm = TRUE)

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

#graph parameters
ind_colors <-c("darkred","red","azure2","brown",
               "brown3","darkslateblue","darkblue","blue",
               "magenta","darkgreen","darkslategrey","darkorchid4",
               "green","black","orange","orange4")

#graph displaying mean trajectory of all organisms and distances
x11()
par(mar=c(10,5,5,1))
plot(as.numeric(names(mean_dist)),unname(mean_dist))
abline(v=dopage)

#graph displaying IGT
x11()
par(mar=c(10,5,5,1))
plot(as.numeric(names(quant_dist)),unname(quant_dist))
abline(v=dopage)