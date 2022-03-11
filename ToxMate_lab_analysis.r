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

#create column for cage location, time in seconds from unix timestamp, total distance
df$animal <- as.integer(substring(df$location,2,3)) #cage location as integer
df$abtime <- as.numeric(df$datetime) - as.numeric(df$datetime[1])
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
timestamps <- unique(df_gamm$datetime)
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

#mean and quantile distance
mean_dist <- rowMeans(df_dist)
  
qq<-function(x)quantile(x,0.05,na.rm=T)
quant_dist <- tapply(df_dist,as.factor(rownames(df_dist)),qq)
